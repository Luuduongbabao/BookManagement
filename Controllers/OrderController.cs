using BookManagement.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Util;

namespace BookManagement.Controllers
{
    public class OrderController : Controller
    {
        BookDatabase db = new BookDatabase();

        public ActionResult Checkout()
        {
            // Lấy thông tin giỏ hàng từ session
            var cart = Session["Cart"] as List<object> ?? new List<object>();
            var books = cart.OfType<Book>().ToList();
            var products = cart.OfType<Product>().ToList();

            // Nếu giỏ hàng trống, redirect về trang giỏ hàng
            if (!books.Any() && !products.Any())
            {
                return RedirectToAction("Index", "Cart");
            }

            // Tính tổng giá trị đơn hàng
            var totalPrice = books.Sum(b => b.price) + products.Sum(p => p.ProductPrice);

            // Trả về view Checkout với thông tin giỏ hàng và tổng giá trị
            ViewBag.Books = books;
            ViewBag.Products = products;
            ViewBag.TotalPrice = totalPrice;

            return View();
        }

        [HttpPost]
        public ActionResult PlaceOrder(string paymentMethod, string shippingAddress)
        {
            // Lấy thông tin giỏ hàng từ session
            var cart = Session["Cart"] as List<object> ?? new List<object>();
            var books = cart.OfType<Book>().ToList();
            var products = cart.OfType<Product>().ToList();

            // Kiểm tra nếu giỏ hàng trống
            if (!books.Any() && !products.Any())
            {
                return RedirectToAction("Index", "Cart");
            }

            // Lấy CusID từ session (có thể lấy từ session "UserId" nếu người dùng đã đăng nhập)
            var userName = Session["UserName"] as string;
            var customer = db.Customers.FirstOrDefault(c => c.CusName == userName);
            if (customer == null || customer.CusID.Length != 5)
            {
                return RedirectToAction("Login", "Account");
            }
            var customerId = customer.CusID;

            //var customerId = Session["UserId"] as string;
            //if (string.IsNullOrWhiteSpace(customerId))
            //{
            //    return RedirectToAction("Login", "Account");
            //}

            // Tạo mã đơn hàng
            string orderId = GenerateOrderID();

            // Tạo đối tượng đơn hàng
            var order = new Order
            {
                OrderID = orderId,
                CusID = customerId, // Lưu CusID (khóa ngoại tham chiếu đến bảng Customer)
                status = "Pending", // Trạng thái ban đầu của đơn hàng
                payment_method = paymentMethod,
                ShippingAddress = shippingAddress,
                OrderDate = DateTime.Now,
                TotalOrderPrice = books.Sum(b => b.price) + products.Sum(p => p.ProductPrice)
            };
            db.Orders.Add(order);
            db.SaveChanges();

            // Lưu chi tiết đơn hàng sách vào cơ sở dữ liệu
            foreach (var book in books)
            {
                var orderDetail = new OrderBook
                {
                    OrderID = orderId,
                    BookID = book.BookID,
                    quantity = 1, // Số lượng sách trong giỏ
                    price = book.price
                };
                db.OrderBooks.Add(orderDetail);
            }

            // Lưu chi tiết đơn hàng sản phẩm vào cơ sở dữ liệu
            foreach (var product in products)
            {
                var orderDetail = new OrderProduct
                {
                    OrderID = orderId,
                    ProductID = product.ProductID,
                    quantity = 1, // Số lượng sản phẩm trong giỏ
                    price = product.ProductPrice
                };
                db.OrderProducts.Add(orderDetail);
            }

            // Tạo giao dịch
            var transaction = new Transaction
            {
                transaction_id = GenerateTransactionID(),
                Order_ID = orderId,
                cashier_id = "CA001", 
                amount = books.Sum(b => b.price) + products.Sum(p => p.ProductPrice),
                payment_method = paymentMethod,
                TransactionDate = DateTime.Now
            };

            // Lưu giao dịch vào cơ sở dữ liệu
            db.Transactions.Add(transaction);
            db.SaveChanges();

            // Xóa giỏ hàng trong session sau khi đặt hàng
            Session["Cart"] = null;

            // Chuyển hướng đến trang xác nhận đơn hàng
            return RedirectToAction("OrderConfirmation", "Order", new { orderId = order.OrderID });
        }


        public ActionResult OrderConfirmation(string orderId)
        {
            var order = db.Orders.Include("OrderBooks").Include("OrderProducts").FirstOrDefault(o => o.OrderID == orderId);
            if (order == null)
            {
                return HttpNotFound();
            }
            var lowStockWarnings = new List<object>();

            foreach (var item in order.OrderBooks)
            {
                var book = db.Books.FirstOrDefault(b => b.BookID == item.BookID);
                if (book != null)
                {
                    book.stock -= item.quantity; // Trừ số lượng sách đã đặt
                    if (book.stock < 0) book.stock = 0; // Tránh số lượng âm
                }
            }
            foreach (var item in order.OrderProducts)
            {
                var product = db.Products.FirstOrDefault(p => p.ProductID == item.ProductID);
                if (product != null)
                {
                    product.ProductStock -= item.quantity;
                    if (product.ProductStock < 0) product.ProductStock = 0; // Tránh số lượng âm
                }
            }
            db.SaveChanges();
            //var order = db.Orders.FirstOrDefault(o => o.OrderID == orderId);
            if (order == null)
            {
                return RedirectToAction("Index", "Book");
            }

            var customer = db.Customers.FirstOrDefault(c => c.CusID == order.CusID);
            var orderBooks = db.OrderBooks.Where(ob => ob.OrderID == orderId).ToList();
            var orderProducts = db.OrderProducts.Where(op => op.OrderID == orderId).ToList();
            decimal totalPrice = orderBooks.Sum(ob => ob.quantity * ob.price) + orderProducts.Sum(op => op.quantity * op.price);
            
            var outOfStockBooks = order.OrderBooks
            .Where(ob => db.Books.FirstOrDefault(b => b.BookID == ob.BookID)?.stock < 5) // Kiểm tra sách dưới 5
            .Select(ob => ob.BookID)
            .ToList();
            var outOfStockProducts = order.OrderProducts
            .Where(op => db.Products.FirstOrDefault(p => p.ProductID == op.ProductID)?.ProductStock < 5)
            .Select(op => op.ProductID)
            .ToList();
            if (outOfStockBooks.Count > 0)
            {
                TempData["OutOfStockBooks"] = outOfStockBooks; // Lưu thông báo tạm thời cho Admin
            }
            Session["LowStockWarnings"] = lowStockWarnings;

            ViewBag.OutOfStockBooks = outOfStockBooks;
            ViewBag.OutOfStockProducts = outOfStockProducts;
            ViewBag.CustomerName = customer?.CusName; // Lấy tên người dùng từ bảng Customer
            ViewBag.TotalPrice = totalPrice;
            ViewBag.OrderDate = order.OrderDate;
            return View(order);
        }

        private string GenerateOrderID()
        {
            Random random = new Random();
            return "O" + random.Next(1000, 9999).ToString(); // Ví dụ: "O1234"
        }

        private string GenerateTransactionID()
        {
            Random random = new Random();
            return "T" + random.Next(1000, 9999).ToString(); // Ví dụ: "T5678"
        }
    }

}