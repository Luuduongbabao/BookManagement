using BookManagement.Models;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BookManagement.Controllers
{
    public class AdminController : Controller
    {
        BookDatabase db = new BookDatabase();

        public ActionResult AdminDashboard()
        {
            if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Admin")
            {
                return View();
            }
            return RedirectToAction("Login", "Account");
        }

        public ActionResult Index()
        {
            var books = db.Books.Include("Category").ToList();
            var lowStockBooks = db.Books.Where(b => b.stock < 5).Select(b => b.BookID).ToList();
            if (lowStockBooks.Any())
            {
                Session["OutOfStockBooks"] = lowStockBooks;
            }
            return View(books);
        }
        public JsonResult GetLowStockBooks()
        {
            var lowStockBooks = db.Books
                .Where(b => b.stock < 5)
                .Select(b => new { b.BookID, b.title, b.stock })
                .ToList();

            return Json(lowStockBooks, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult UpdateBookStock(string bookID)
        {
            try
            {
                if (string.IsNullOrEmpty(bookID))
                {
                    return Json(new { success = false, message = "ID sách không hợp lệ!" });
                }

                // Gọi stored procedure hoặc cập nhật trực tiếp bằng LINQ
                var updatedRows = db.Database.ExecuteSqlCommand("EXEC dbo.UpdateBookStockFromSupply @BookID",
                    new SqlParameter("@BookID", bookID));

                if (updatedRows > 0)
                {
                    return Json(new { success = true });
                }
                else
                {
                    return Json(new { success = false, message = "Không có bản ghi nào được cập nhật!" });
                }
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
        public ActionResult Create()
        {
            var book = new Book();
            ViewBag.Categories = new SelectList(db.Categories, "CategoryID", "CategoryName");
            return View(book);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Book book, HttpPostedFileBase BookImage)
        {
            if (book.stock <= 0) 
            {
                ModelState.AddModelError("stock", "Số lượng sách phải lớn hơn 0.");
            }
            if (ModelState.IsValid)
            {
                if (BookImage != null && BookImage.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(BookImage.FileName);
                    string filePath = Path.Combine(Server.MapPath("~/Images/"), fileName);
                    BookImage.SaveAs(filePath);
                    book.Book_Image = "/Images/" + fileName;
                }
                else
                {
                    book.Book_Image = "/Images/default.png"; 
                }

                db.Books.Add(book);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Categories = new SelectList(db.Categories, "CategoryID", "CategoryName", book.CategoryID);
            return View(book);
        }

        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return HttpNotFound();
            }

            var book = db.Books.FirstOrDefault(b => b.BookID == id); if (book == null)
            {
                return HttpNotFound();
            }
            ViewBag.CategoryList = new SelectList(db.Categories.ToList(), "CategoryID", "CategoryName", book.CategoryID);

            return View(book);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Book book, HttpPostedFileBase BookImage)
        {
            if (ModelState.IsValid)
            {
                var existingBook = db.Books.Find(book.BookID);
                if (existingBook != null)
                {
                    existingBook.title = book.title;
                    existingBook.author = book.author;
                    existingBook.price = book.price;
                    existingBook.stock = book.stock;
                    existingBook.CategoryID = book.CategoryID; 

                    if (BookImage != null && BookImage.ContentLength > 0)
                    {
                        string fileName = Path.GetFileName(BookImage.FileName);
                        string path = Path.Combine(Server.MapPath("~/Images"), fileName);
                        BookImage.SaveAs(path);
                        existingBook.Book_Image = "/Images/" + fileName;
                    }

                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }

            ViewBag.CategoryList = new SelectList(db.Categories.ToList(), "CategoryID", "CategoryName", book.CategoryID);

            return View(book);
        }


        
        public ActionResult ListCustomer()
        {
            db.Customers.Load();
            var customers = db.Customers.ToList();
            return View(customers);
        }

        [HttpGet]
        public ActionResult CreateCustomer()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CreateCustomer(Customer customer)
        {
            if (ModelState.IsValid)
            {
                var existingCustomer = db.Customers.Find(customer.CusID);
                if (existingCustomer != null)
                {
                    ModelState.AddModelError("CusID", "Mã khách hàng đã tồn tại. Vui lòng nhập mã khác.");
                    return View(customer);
                }

                db.Customers.Add(customer);
                db.SaveChanges();
                return RedirectToAction("ListCustomer");
            }
            return View(customer);
        }

        // GET: Edit Customer
        public ActionResult EditCustomer(string id)
        {
            if (string.IsNullOrWhiteSpace(id))
            {
                return HttpNotFound();
            }

            id = id.Trim(); 
            var customer = db.Customers.FirstOrDefault(c => c.CusID == id);
            if (customer == null)
            {
                return HttpNotFound();
            }

            return View(customer);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditCustomer(Customer customer, string CusDob)
        {
            if (!ModelState.IsValid)
            {
                foreach (var error in ModelState.Values.SelectMany(v => v.Errors))
                {
                    System.Diagnostics.Debug.WriteLine(error.ErrorMessage);
                }
                return View(customer);
            }

            var existingCustomer = db.Customers.Find(customer.CusID);
            if (existingCustomer != null)
            {
                existingCustomer.CusName = customer.CusName;
                existingCustomer.CusEmail = customer.CusEmail;
                existingCustomer.CusPhone = customer.CusPhone;
                existingCustomer.CusPassword = customer.CusPassword;
                existingCustomer.CusAddress = customer.CusAddress;

                if (!string.IsNullOrEmpty(CusDob))
                {
                    DateTime dob;
                    if (DateTime.TryParseExact(CusDob, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, out dob))
                    {
                        existingCustomer.CusDob = dob;
                    }
                }

                db.SaveChanges();
            }

            return RedirectToAction("ListCustomer");
        }

       

        public ActionResult ListCategory()
        {
            var categories = db.Categories.ToList();
            return View(categories);
        }

        public ActionResult CreateCategory()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateCategory(Category category)
        {
            if (ModelState.IsValid)
            {
                db.Categories.Add(category);
                db.SaveChanges();
                return RedirectToAction("ListCategory");
            }

            return View(category);
        }

        public ActionResult EditCategory(string id)
        {
            id = id?.Trim();

            if (string.IsNullOrWhiteSpace(id))
            {
                return HttpNotFound();  
            }
            var category = db.Categories.Find(id);
            if (category == null)
            {
                return HttpNotFound(); 
            }

            return View(category);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditCategory(Category category)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrWhiteSpace(category.CategoryID))
                {
                    ModelState.AddModelError("CategoryID", "Mã danh mục không hợp lệ.");
                    return View(category);
                }
                var existingCategory = db.Categories.Find(category.CategoryID);
                if (existingCategory != null)
                {
                    existingCategory.CategoryName = category.CategoryName;

                    db.SaveChanges();
                    return RedirectToAction("ListCategory");
                }
                else
                {
                    return HttpNotFound();
                }
            }
            return View(category);
        }

        

        public ActionResult ListSuppliers()
        {
            var suppliers = db.Suppliers.ToList();
            return View(suppliers);
        }

        public ActionResult CreateSupplier()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateSupplier(Supplier supplier)
        {
            if (ModelState.IsValid)
            {
                db.Suppliers.Add(supplier);
                db.SaveChanges();
                return RedirectToAction("ListSuppliers");
            }
            return View(supplier);
        }

        public ActionResult EditSupplier(string id)
        {
            if (string.IsNullOrWhiteSpace(id))
            {
                return HttpNotFound(); 
            }
            id = id.Trim();  
            var supplier = db.Suppliers.Find(id);  
            if (supplier == null)
            {
                return HttpNotFound();  
            }
            return View(supplier);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditSupplier(Supplier supplier)
        {
            if (ModelState.IsValid)
            {
                supplier.supplier_id = supplier.supplier_id?.Trim();
                var existingSupplier = db.Suppliers.Find(supplier.supplier_id);  
                if (existingSupplier != null)
                {
                    existingSupplier.supplier_name = supplier.supplier_name;  
                    existingSupplier.supplier_email = supplier.supplier_email; 
                    existingSupplier.phone = supplier.phone;  
                    existingSupplier.address = supplier.address;  

                    db.SaveChanges();  
                    return RedirectToAction("ListSuppliers");  
                }
                else
                {
                    return HttpNotFound();  
                }
            }
            return View(supplier);  
        }

        

        public ActionResult ListBookSupplies()
        {
            var bookSupplies = db.BookSupplies
                                 .Include(b => b.Supplier)  
                                 .Include(b => b.Book)      
                                 .ToList();

            return View(bookSupplies);  
        }

        public ActionResult CreateBookSupplies()
        {
            var bookSupply = new BookSupply
            {
                DateSuppliers = DateTime.Now
            };
            var books = db.Books.ToList();
            var suppliers = db.Suppliers.ToList();
            ViewBag.Suppliers = new SelectList(suppliers, "supplier_id", "supplier_name");
            ViewBag.Books = new SelectList(books, "BookID", "title");

            return View(bookSupply);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateBookSupplies(BookSupply bookSupply)
        {

            if (ModelState.IsValid)
            {
                if (bookSupply.DateSuppliers == default(DateTime))
                {
                    bookSupply.DateSuppliers = DateTime.Now;
                }
                db.BookSupplies.Add(bookSupply);  
                db.SaveChanges(); 

                return RedirectToAction("ListBookSupplies"); 
            }
            var suppliers = db.Suppliers.ToList();
            var books = db.Books.ToList();

            ViewBag.Suppliers = new SelectList(suppliers, "supplier_id", "supplier_name");
            ViewBag.Books = new SelectList(books, "book_id", "title");
            return View(bookSupply);  
        }

        public ActionResult ListProductSupplies()
        {
            var productSupplies = db.ProductSupplies
                                    .Include(p => p.Supplier)  
                                    .Include(p => p.Product)  
                                    .ToList();
            return View(productSupplies);  
        }

        public ActionResult CreateProductSupplies()
        {
            var productSupply = new ProductSupply
            {
                DateSuppliers = DateTime.Now 
            };
            var suppliers = db.Suppliers.ToList();
            var products = db.Products.ToList();
            ViewBag.Suppliers = new SelectList(suppliers, "supplier_id", "supplier_name");
            ViewBag.Products = new SelectList(products, "ProductId", "ProductName");
            return View(productSupply);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateProductSupplies(ProductSupply productSupply)
        {
            if (ModelState.IsValid)
            {
                // Kiểm tra giá trị hợp lệ cho quantity và price
                if (productSupply.quantity <= 0)
                {
                    ModelState.AddModelError("Quantity", "Số lượng phải lớn hơn 0.");
                }
                if (productSupply.price <= 0)
                {
                    ModelState.AddModelError("Price", "Giá phải lớn hơn 0.");
                }

                // Gán giá trị ngày nhập nếu chưa có
                if (productSupply.DateSuppliers == default(DateTime))
                {
                    productSupply.DateSuppliers = DateTime.Now;
                }

                // Tạo Supply_id nếu cần (nếu không tự động sinh)
                if (string.IsNullOrEmpty(productSupply.Supply_id))
                {
                    productSupply.Supply_id = GenerateSupplyId();  // Hàm tạo ID tùy chỉnh
                }

                // Nếu vẫn hợp lệ sau khi kiểm tra
                if (ModelState.IsValid)
                {
                    db.ProductSupplies.Add(productSupply);
                    db.SaveChanges();
                    return RedirectToAction("ListProductSupplies");
                }
            }

            // Nếu có lỗi, hiển thị lại form
            ViewBag.Suppliers = new SelectList(db.Suppliers, "supplier_id", "supplier_name");
            ViewBag.Products = new SelectList(db.Products, "ProductId", "ProductName");
            return View(productSupply);
        }

        // Hàm tạo ID tự động nếu cần
        private string GenerateSupplyId()
        {
            int nextId = db.ProductSupplies.Count() + 1;
            return "S" + nextId.ToString("D4");  // Định dạng thành 4 số, tổng cộng đủ 5 ký tự
        }

        public ActionResult ListProduct()
        {
            var products = db.Products.ToList();
            var lowStockProduct = db.Products.Where(p => p.ProductStock < 5).Select(p => p.ProductID).ToList();
            if (lowStockProduct.Any())
            {
                Session["OutOfStockProducts"] = lowStockProduct;
            }
            return View(products);
        }
        public ActionResult CreateProduct()
        {
            return View();
        }
        public JsonResult GetLowStockProducts()
        {
            var lowStockProducts = db.Products
                .Where(p => p.ProductStock < 5)
                .Select(p => new { p.ProductID, p.ProductName, p.ProductStock })
                .ToList();

            return Json(lowStockProducts, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult UpdateProductStock(string productID)
        {
            try
            {
                if (string.IsNullOrEmpty(productID))
                {
                    return Json(new { success = false, message = "ID sản phẩm không hợp lệ!" });
                }

                // Gọi stored procedure hoặc cập nhật trực tiếp bằng LINQ
                var updatedRows = db.Database.ExecuteSqlCommand("EXEC dbo.UpdateProductStockFromSupply @ProductID",
                    new SqlParameter("@ProductID", productID));

                if (updatedRows > 0)
                {
                    return Json(new { success = true });
                }
                else
                {
                    return Json(new { success = false, message = "Không có bản ghi nào được cập nhật!" });
                }
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateProduct(Product product, HttpPostedFileBase ProductImage)
        {
            if (product.ProductStock <= 0) 
            {
                ModelState.AddModelError("ProductStock", "Số lượng sản phẩm phải lớn hơn 0.");
            }
            if (ModelState.IsValid)
            {
                if (ProductImage != null && ProductImage.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(ProductImage.FileName);
                    string filePath = Path.Combine(Server.MapPath("~/Images/"), fileName);
                    ProductImage.SaveAs(filePath);
                    product.Product_Image = "/Images/" + fileName;
                }
                else
                {
                    product.Product_Image = "/Images/default.png";
                }

                db.Products.Add(product);
                db.SaveChanges();
                return RedirectToAction("ListProduct");
            }
            return View(product);
        }

        public ActionResult EditProduct(string id)
        {
            var product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditProduct(Product model, HttpPostedFileBase ProductImage)
        {
            if (ModelState.IsValid)
            {
                var product = db.Products.Find(model.ProductID.ToString().Trim()); 
                if (product == null)
                {
                    return HttpNotFound();
                }
                product.ProductName = model.ProductName.Trim(); 
                product.ProductPrice = model.ProductPrice;
                product.ProductStock = model.ProductStock;
                if (ProductImage != null && ProductImage.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(ProductImage.FileName);
                    string path = Path.Combine(Server.MapPath("~/Images/"), fileName);
                    ProductImage.SaveAs(path);
                    product.Product_Image = "~/Images/" + fileName;
                }
                db.SaveChanges();
                return RedirectToAction("ListProduct");
            }
            return View(model);
        }

        public ActionResult ListOrder()
        {
            db.Orders.Load();
            var orders = db.Orders.ToList();
            return View(orders);
        }

        public ActionResult ListCashier()
        {
            db.Cashiers.Load();
            var cashiers = db.Cashiers.ToList();
            return View(cashiers);
        }
    }
}