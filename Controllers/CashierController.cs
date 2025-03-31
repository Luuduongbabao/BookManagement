using BookManagement.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BookManagement.Controllers
{
    public class CashierController : Controller
    {
        BookDatabase db = new BookDatabase();

        public ActionResult ListOrder(string statusFilter, DateTime? dateFilter, string searchQuery)
        {
            using (var db = new BookDatabase())
            {
                var ordersQuery = db.Orders.AsQueryable();

                if (!string.IsNullOrEmpty(statusFilter))
                    ordersQuery = ordersQuery.Where(o => o.status == statusFilter);

                if (dateFilter.HasValue)
                {
                    DateTime startDate = dateFilter.Value.Date;
                    DateTime endDate = startDate.AddDays(1).AddTicks(-1); // 23:59:59

                    ordersQuery = ordersQuery.Where(o => o.OrderDate >= startDate && o.OrderDate <= endDate);
                }

                if (!string.IsNullOrEmpty(searchQuery))
                    ordersQuery = ordersQuery.Where(o => o.OrderID.Contains(searchQuery) || o.CusID.Contains(searchQuery));

                var orders = ordersQuery.ToList();

                return View(orders);
                    }
        }

        public ActionResult Confirm()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ConfirmOrder(string orderId)
        {
            if (string.IsNullOrEmpty(orderId))
            {
                TempData["Message"] = "⚠ Lỗi: Không có OrderID hợp lệ!";
                return RedirectToAction("ListOrder");
            }

            var order = db.Orders.FirstOrDefault(o => o.OrderID == orderId);

            if (order != null)
            {
                order.status = "Completed";
                db.SaveChanges(); // Lưu vào Database
                TempData["Message"] = "✅ Đơn hàng đã được xác nhận!";
            }
            else
            {
                TempData["Message"] = "⚠ Không tìm thấy đơn hàng!";
            }

            return RedirectToAction("ListOrder");
        }


        [HttpPost]
        public ActionResult ConfirmCancelOrder(string orderId)
        {
            if (string.IsNullOrEmpty(orderId))
            {
                TempData["Message"] = "⚠ Lỗi: Không có OrderID hợp lệ!";
                return RedirectToAction("ListOrder");
            }

            using (var db = new BookDatabase())
            {
                var order = db.Orders.FirstOrDefault(o => o.OrderID == orderId);
                if (order != null)
                {
                    order.status = "Cancelled";
                    db.SaveChanges();
                    TempData["Message"] = "✅ Đơn hàng đã được hủy thành công!";
                }
                else
                {
                    TempData["Message"] = "⚠ Không tìm thấy đơn hàng!";
                }
            }

            return RedirectToAction("ListOrder");
        }

        public ActionResult ListTransaction(string paymentMethod)
        {
            using (var db = new BookDatabase()) // Mở kết nối DB
            {
                var transactions = db.Transactions.AsQueryable();

                // Kiểm tra nếu có tham số paymentMethod thì lọc dữ liệu
                if (!string.IsNullOrEmpty(paymentMethod))
                {
                    transactions = transactions.Where(t => t.payment_method == paymentMethod);
                }

                return View(transactions.ToList());
            }
        }
    }
}
