namespace BookManagement.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Cashier")]
    public partial class Cashier
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Cashier()
        {
            Transactions = new HashSet<Transaction>();
        }

        [StringLength(5)]
        public string CashierID { get; set; }

        [Required]
        [StringLength(100)]
        public string CashierName { get; set; }

        [Required]
        [StringLength(100)]
        public string CashierEmail { get; set; }

        [Column(TypeName = "text")]
        [Required]
        public string CashierAddress { get; set; }

        [Required]
        [StringLength(20)]
        public string CashierPhone { get; set; }

        [Required]
        [StringLength(255)]
        public string CashierPassword { get; set; }

        [Column(TypeName = "date")]
        public DateTime CashierDOB { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Transaction> Transactions { get; set; }
    }
}
