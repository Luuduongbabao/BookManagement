namespace BookManagement.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Book")]
    public partial class Book
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Book()
        {
            BookSupplies = new HashSet<BookSupply>();
            OrderBooks = new HashSet<OrderBook>();
        }

        [StringLength(5)]
        public string BookID { get; set; }

        [Required]
        [StringLength(255)]
        public string title { get; set; }

        [StringLength(100)]
        public string author { get; set; }

        [StringLength(100)]
        public string publisher { get; set; }

        public decimal price { get; set; }

        public int stock { get; set; }

        [StringLength(5)]
        public string CategoryID { get; set; }

        [StringLength(255)]
        public string Book_Image { get; set; }

        public virtual Category Category { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BookSupply> BookSupplies { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderBook> OrderBooks { get; set; }
    }
}
