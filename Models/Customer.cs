namespace BookManagement.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Customer")]
    public partial class Customer
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Customer()
        {
            Orders = new HashSet<Order>();
        }

        [Key]
        [StringLength(5)]
        public string CusID { get; set; }

        [Required]
        [StringLength(100)]
        public string CusName { get; set; }

        [Required]
        [StringLength(100)]
        public string CusEmail { get; set; }

        [Column(TypeName = "text")]
        [Required]
        public string CusAddress { get; set; }

        [Required]
        [StringLength(20)]
        public string CusPhone { get; set; }

        [Required]
        [StringLength(255)]
        public string CusPassword { get; set; }

        [Column(TypeName = "date")]
        public DateTime CusDob { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Order> Orders { get; set; }
    }
}
