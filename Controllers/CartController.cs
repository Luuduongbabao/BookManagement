using BookManagement.Models;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BookManagement.Controllers
{
    public class CartController : Controller
    {
        BookDatabase db = new BookDatabase();

        public ActionResult Index()
        {
            var cart = Session["Cart"] as List<object> ?? new List<object>();
            return View(cart);
        }

        public ActionResult AddToCartBook(string id)
        {
            if (string.IsNullOrWhiteSpace(id))
            {
                return RedirectToAction("Index");
            }

            id = id.Trim();
            var cart = Session["Cart"] as List<object> ?? new List<object>();

            var book = db.Books.Find(id);
            if (book != null)
            {
                cart.Add(book);
            }

            Session["Cart"] = cart;
            return RedirectToAction("Index");
        }

        public ActionResult AddToCartProduct(string id)
        {
            if (string.IsNullOrWhiteSpace(id))
            {
                return RedirectToAction("Index");
            }

            id = id.Trim();
            var cart = Session["Cart"] as List<object> ?? new List<object>();

            var product = db.Products.Find(id);
            if (product != null)
            {
                cart.Add(product);
            }

            Session["Cart"] = cart;
            return RedirectToAction("Index");
        }

        public ActionResult RemoveFromCartBook(string id)
        {
            if (string.IsNullOrWhiteSpace(id))
            {
                return RedirectToAction("Index");
            }

            // Loại bỏ khoảng trắng ở đầu và cuối id
            id = id.Trim();

            var cart = Session["Cart"] as List<object> ?? new List<object>();

            // Kiểm tra giá trị id và các đối tượng trong giỏ hàng
            var book = cart.OfType<Book>().FirstOrDefault(b => b.BookID.Trim() == id);  // Đảm bảo so sánh chính xác
            if (book != null)
            {
                cart.Remove(book);
            }
            else
            {
                // Debugging để kiểm tra trường hợp không tìm thấy
                Console.WriteLine($"Không tìm thấy sách với ID: {id}");
            }

            Session["Cart"] = cart;
            return RedirectToAction("Index");
        }

        public ActionResult RemoveFromCartProduct(string id)
        {
            if (string.IsNullOrWhiteSpace(id))
            {
                return RedirectToAction("Index");
            }

            // Loại bỏ khoảng trắng ở đầu và cuối id
            id = id.Trim();

            var cart = Session["Cart"] as List<object> ?? new List<object>();

            // Kiểm tra giá trị id và các đối tượng trong giỏ hàng
            var product = cart.OfType<Product>().FirstOrDefault(p => p.ProductID.Trim() == id);  // Đảm bảo so sánh chính xác
            if (product != null)
            {
                cart.Remove(product);
            }
            else
            {
                // Debugging để kiểm tra trường hợp không tìm thấy
                Console.WriteLine($"Không tìm thấy sản phẩm với ID: {id}");
            }

            Session["Cart"] = cart;
            return RedirectToAction("Index");
        }

    }
}