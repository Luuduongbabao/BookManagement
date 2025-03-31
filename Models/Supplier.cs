namespace BookManagement.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Supplier
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Supplier()
        {
            BookSupplies = new HashSet<BookSupply>();
            ProductSupplies = new HashSet<ProductSupply>();
        }

        [Key]
        [StringLength(5)]
        public string supplier_id { get; set; }

        [Required]
        [StringLength(100)]
        public string supplier_name { get; set; }

        [Required]
        [StringLength(100)]
        public string supplier_email { get; set; }

        [StringLength(20)]
        public string phone { get; set; }

        [Column(TypeName = "text")]
        public string address { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BookSupply> BookSupplies { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProductSupply> ProductSupplies { get; set; }
    }
}
