using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace BookManagement.Models
{
    public partial class BookDatabase : DbContext
    {
        public BookDatabase()
            : base("name=BookDatabase")
        {
        }

        public virtual DbSet<Admin> Admins { get; set; }
        public virtual DbSet<Book> Books { get; set; }
        public virtual DbSet<BookSupply> BookSupplies { get; set; }
        public virtual DbSet<Cashier> Cashiers { get; set; }
        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<Customer> Customers { get; set; }
        public virtual DbSet<OrderBook> OrderBooks { get; set; }
        public virtual DbSet<OrderProduct> OrderProducts { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<ProductSupply> ProductSupplies { get; set; }
        public virtual DbSet<Supplier> Suppliers { get; set; }
        public virtual DbSet<Transaction> Transactions { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Admin>()
                .Property(e => e.AdminID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Admin>()
                .Property(e => e.AdminAddress)
                .IsUnicode(false);

            modelBuilder.Entity<Admin>()
                .Property(e => e.AdminPhone)
                .IsUnicode(false);

            modelBuilder.Entity<Admin>()
                .Property(e => e.AdminPassword)
                .IsUnicode(false);

            modelBuilder.Entity<Book>()
                .Property(e => e.BookID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Book>()
                .Property(e => e.price)
                .HasPrecision(10, 2);

            modelBuilder.Entity<Book>()
                .Property(e => e.CategoryID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Book>()
                .HasMany(e => e.BookSupplies)
                .WithRequired(e => e.Book)
                .HasForeignKey(e => e.book_id)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Book>()
                .HasMany(e => e.OrderBooks)
                .WithRequired(e => e.Book)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BookSupply>()
                .Property(e => e.Supply_id)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<BookSupply>()
                .Property(e => e.supplier_id)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<BookSupply>()
                .Property(e => e.book_id)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<BookSupply>()
                .Property(e => e.price)
                .HasPrecision(10, 2);

            modelBuilder.Entity<Cashier>()
                .Property(e => e.CashierID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Cashier>()
                .Property(e => e.CashierAddress)
                .IsUnicode(false);

            modelBuilder.Entity<Cashier>()
                .Property(e => e.CashierPhone)
                .IsUnicode(false);

            modelBuilder.Entity<Cashier>()
                .Property(e => e.CashierPassword)
                .IsUnicode(false);

            modelBuilder.Entity<Cashier>()
                .HasMany(e => e.Transactions)
                .WithRequired(e => e.Cashier)
                .HasForeignKey(e => e.cashier_id)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Category>()
                .Property(e => e.CategoryID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.CusID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.CusAddress)
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.CusPhone)
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .HasMany(e => e.Orders)
                .WithRequired(e => e.Customer)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<OrderBook>()
                .Property(e => e.OrderID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<OrderBook>()
                .Property(e => e.BookID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<OrderBook>()
                .Property(e => e.price)
                .HasPrecision(10, 2);

            modelBuilder.Entity<OrderBook>()
                .Property(e => e.DetailTotalPrice)
                .HasPrecision(21, 2);

            modelBuilder.Entity<OrderProduct>()
                .Property(e => e.OrderID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<OrderProduct>()
                .Property(e => e.ProductID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<OrderProduct>()
                .Property(e => e.price)
                .HasPrecision(10, 2);

            modelBuilder.Entity<OrderProduct>()
                .Property(e => e.DetailTotalPrice)
                .HasPrecision(21, 2);

            modelBuilder.Entity<Order>()
                .Property(e => e.OrderID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Order>()
                .Property(e => e.CusID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Order>()
                .Property(e => e.status)
                .IsUnicode(false);

            modelBuilder.Entity<Order>()
                .Property(e => e.payment_method)
                .IsUnicode(false);

            modelBuilder.Entity<Order>()
                .HasMany(e => e.OrderBooks)
                .WithRequired(e => e.Order)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Order>()
                .HasMany(e => e.OrderProducts)
                .WithRequired(e => e.Order)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Order>()
                .HasMany(e => e.Transactions)
                .WithRequired(e => e.Order)
                .HasForeignKey(e => e.Order_ID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Product>()
                .Property(e => e.ProductID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Product>()
                .Property(e => e.ProductPrice)
                .HasPrecision(10, 2);

            modelBuilder.Entity<Product>()
                .HasMany(e => e.OrderProducts)
                .WithRequired(e => e.Product)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Product>()
                .HasMany(e => e.ProductSupplies)
                .WithRequired(e => e.Product)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ProductSupply>()
                .Property(e => e.Supply_id)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<ProductSupply>()
                .Property(e => e.Supplier_id)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<ProductSupply>()
                .Property(e => e.productID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<ProductSupply>()
                .Property(e => e.price)
                .HasPrecision(10, 2);

            modelBuilder.Entity<Supplier>()
                .Property(e => e.supplier_id)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Supplier>()
                .Property(e => e.phone)
                .IsUnicode(false);

            modelBuilder.Entity<Supplier>()
                .Property(e => e.address)
                .IsUnicode(false);

            modelBuilder.Entity<Supplier>()
                .HasMany(e => e.BookSupplies)
                .WithRequired(e => e.Supplier)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Supplier>()
                .HasMany(e => e.ProductSupplies)
                .WithRequired(e => e.Supplier)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Transaction>()
                .Property(e => e.transaction_id)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Transaction>()
                .Property(e => e.Order_ID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Transaction>()
                .Property(e => e.cashier_id)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Transaction>()
                .Property(e => e.amount)
                .HasPrecision(10, 2);

            modelBuilder.Entity<Transaction>()
                .Property(e => e.payment_method)
                .IsUnicode(false);
        }
    }
}
