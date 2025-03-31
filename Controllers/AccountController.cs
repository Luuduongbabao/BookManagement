using BookManagement.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;


namespace BookManagement.Controllers
{
    public class AccountController : Controller
    {
        BookDatabase db = new BookDatabase();
        // GET: Account
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string LoginIdentifier, string CusPassword, bool? RememberMe)
        {
            bool isRemembered = RememberMe ?? false;

            if (string.IsNullOrEmpty(LoginIdentifier) || string.IsNullOrEmpty(CusPassword))
            {
                ViewBag.ErrorMessage = "Vui lòng nhập email/tên đăng nhập và mật khẩu.";
                return View();
            }

            // 1️⃣ Kiểm tra trong bảng Admin
            var admin = db.Admins.FirstOrDefault(a =>
                (a.AdminEmail == LoginIdentifier || a.AdminName == LoginIdentifier) &&
                a.AdminPassword == CusPassword);

            if (admin != null)
            {
                var lowStockBooks = db.Books.Where(b => b.stock < 5)
                .Select(b => new { b.BookID, b.title, b.stock })
                .ToList();

                if (lowStockBooks.Any())
                {
                    Session["LowStockWarnings"] = lowStockBooks;
                }
                else
                {
                    Session["LowStockWarnings"] = null;
                }

                Session["UserName"] = admin.AdminName;
                Session["UserRole"] = "Admin";

                if (isRemembered)
                {
                    HttpCookie cookie = new HttpCookie("UserLogin", admin.AdminName)
                    {
                        Expires = DateTime.Now.AddDays(7)
                    };
                    Response.Cookies.Add(cookie);
                }

                return RedirectToAction("AdminDashboard", "Admin");
            }

            // 2️⃣ Kiểm tra trong bảng Cashier (Thu ngân)
            var cashier = db.Cashiers.FirstOrDefault(c =>
                (c.CashierEmail == LoginIdentifier || c.CashierName == LoginIdentifier) &&
                c.CashierPassword == CusPassword);

            if (cashier != null)
            {
                Session["UserName"] = cashier.CashierName;
                Session["UserRole"] = "Cashier";

                if (isRemembered)
                {
                    HttpCookie cookie = new HttpCookie("UserLogin", cashier.CashierName)
                    {
                        Expires = DateTime.Now.AddDays(7)
                    };
                    Response.Cookies.Add(cookie);
                }

                return RedirectToAction("ListOrder", "Cashier");
            }

            // 3️⃣ Kiểm tra trong bảng Customer (Khách hàng)
            var customer = db.Customers.FirstOrDefault(c =>
                (c.CusEmail == LoginIdentifier || c.CusName == LoginIdentifier) &&
                c.CusPassword == CusPassword);

            if (customer != null)
            {
                Session["UserName"] = customer.CusName;
                Session["UserRole"] = "Customer";

                if (isRemembered)
                {
                    HttpCookie cookie = new HttpCookie("UserLogin", customer.CusName)
                    {
                        Expires = DateTime.Now.AddDays(7)
                    };
                    Response.Cookies.Add(cookie);
                }

                return RedirectToAction("Index", "Book");
            }

            ViewBag.ErrorMessage = "Tên đăng nhập hoặc mật khẩu không đúng.";
            return View();
        }


        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(Customer model, string ConfirmPassword)
        {
            if (string.IsNullOrEmpty(model.CusName))
                ModelState.AddModelError("CusName", "Username is required.");
            if (string.IsNullOrEmpty(model.CusEmail))
                ModelState.AddModelError("CusEmail", "Email is required.");
            if (string.IsNullOrEmpty(model.CusPassword))
                ModelState.AddModelError("CusPassword", "Password is required.");
            if (string.IsNullOrEmpty(ConfirmPassword))
                ModelState.AddModelError("ConfirmPassword", "Confirm Password is required.");
            if (model.CusPassword != ConfirmPassword)
                ModelState.AddModelError("ConfirmPassword", "Passwords do not match.");

            int age = DateTime.Now.Year - model.CusDob.Year;
            if (DateTime.Now < model.CusDob.AddYears(age)) age--; // Kiểm tra ngày sinh nhật đã qua chưa
            if (age < 18)
                ModelState.AddModelError("CusDob", "You must be at least 18 years old to register.");

            if (!System.Text.RegularExpressions.Regex.IsMatch(model.CusPhone ?? "", @"^0\d{9}$"))
                ModelState.AddModelError("CusPhone", "Phone number must be exactly 10 digits and start with 0.");

            if (!ModelState.IsValid)
                return View(model);

            using (var db = new BookDatabase())
            {
                // Kiểm tra email đã tồn tại chưa
                if (db.Customers.Any(c => c.CusEmail == model.CusEmail))
                {
                    ModelState.AddModelError("CusEmail", "This email is already taken. Please choose another.");
                    return View(model);
                }

                // Kiểm tra username đã tồn tại chưa
                if (db.Customers.Any(c => c.CusName == model.CusName))
                {
                    ModelState.AddModelError("CusName", "This username is already taken. Please choose another.");
                    return View(model);
                }

                // Mã hóa mật khẩu trước khi lưu (có thể dùng HashAlgorithm như BCrypt)
                //string hashedPassword = HashPasswordSHA256(model.CusPassword);

                var newCustomer = new Customer
                {
                    CusID = Guid.NewGuid().ToString().Substring(0, 5),
                    CusName = model.CusName,
                    CusEmail = model.CusEmail,
                    CusAddress = model.CusAddress,
                    CusPhone = model.CusPhone,
                    CusPassword = model.CusPassword, // Lưu mật khẩu đã mã hóa
                    CusDob = model.CusDob
                };

                db.Customers.Add(newCustomer);
                db.SaveChanges();
            }

            return RedirectToAction("Login", "Account");
        }
        //private string HashPasswordSHA256(string password)
        //{
        //    using (SHA256 sha256 = SHA256.Create())
        //    {
        //        byte[] bytes = Encoding.UTF8.GetBytes(password);
        //        byte[] hashBytes = sha256.ComputeHash(bytes);
        //        return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
        //    }
        //}

        public ActionResult Logout()
        {
            Session.Clear();
            Session.Abandon();
            return RedirectToAction("Index", "Book");
        }
    }
}