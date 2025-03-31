using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BookManagement.Models;
using System.Data.Entity;

namespace BookManagement.Controllers
{
    public class BookController : Controller
    {
        BookDatabase db = new BookDatabase();

        public ActionResult Index()
        {
            var books = db.Books.Include(b => b.Category).ToList();
            var products = db.Products.ToList();

            ViewBag.Categories = db.Categories.ToList();
            ViewBag.Products = products;  

            return View(books); 
        }

        public ActionResult Contact()
        {
            return View();
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult List(string categoryId, string sortOrder)
        {
            var books = db.Books.AsQueryable();
            int? catId = null;
            if (!string.IsNullOrEmpty(categoryId) && int.TryParse(categoryId, out int parsedId))
            {
                catId = parsedId;
            }

            if (catId.HasValue)
            {
                books = books.Where(b => b.CategoryID.Equals(catId.Value));
            }

            switch (sortOrder)
            {
                case "price_asc":
                    books = books.OrderBy(b => b.price);
                    break;
                case "price_desc":
                    books = books.OrderByDescending(b => b.price);
                    break;
                case "name_asc":
                    books = books.OrderBy(b => b.title);
                    break;
                case "name_desc":
                    books = books.OrderByDescending(b => b.title);
                    break;
            }
            
            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("List", books.ToList());
            }

            return View("Index", books.ToList());
        }
        public ActionResult ProductList(string sortOrder)
        {
            var products = db.Products.AsQueryable();

            switch (sortOrder)
            {
                case "price_asc":
                    products = products.OrderBy(p => p.ProductPrice);
                    break;
                case "price_desc":
                    products = products.OrderByDescending(p => p.ProductPrice);
                    break;
                case "name_asc":
                    products = products.OrderBy(p => p.ProductName);
                    break;
                case "name_desc":
                    products = products.OrderByDescending(p => p.ProductName);
                    break;
            }

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("ProductList", products.ToList());
            }

            return View("ProductList", products.ToList());
        }

        public ActionResult Detail(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return HttpNotFound();
            }

            id = id.Trim();
            var book = db.Books.Include(b => b.Category).FirstOrDefault(b => b.BookID == id);

            if (book == null)
            {
                return HttpNotFound();
            }

            return View("Detail", book);
        }

        public ActionResult ProductDetail(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return HttpNotFound();
            }

            id = id.Trim();
            var product = db.Products.FirstOrDefault(p => p.ProductID == id);

            if (product == null)
            {
                return HttpNotFound();
            }

            return View("ProductDetail", product);
        }
    }
}