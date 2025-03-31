namespace BookManagement.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class BookSupply
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(5)]
        public string Supply_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(5)]
        public string supplier_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(5)]
        public string book_id { get; set; }

        public int quantity { get; set; }

        public decimal price { get; set; }

        public DateTime? DateSuppliers { get; set; }

        public virtual Book Book { get; set; }

        public virtual Supplier Supplier { get; set; }
    }
}
