namespace BookManagement.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Order
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Order()
        {
            OrderBooks = new HashSet<OrderBook>();
            OrderProducts = new HashSet<OrderProduct>();
            Transactions = new HashSet<Transaction>();
        }

        [StringLength(5)]
        public string OrderID { get; set; }

        [Required]
        [StringLength(5)]
        public string CusID { get; set; }

        [StringLength(20)]
        public string status { get; set; }

        [Required]
        [StringLength(20)]
        public string payment_method { get; set; }

        [Required]
        [StringLength(255)]
        public string ShippingAddress { get; set; }

        [Column(TypeName = "date")]
        public DateTime? OrderDate { get; set; }

        public decimal? TotalOrderPrice { get; set; }

        public virtual Customer Customer { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderBook> OrderBooks { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderProduct> OrderProducts { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Transaction> Transactions { get; set; }
    }
}
