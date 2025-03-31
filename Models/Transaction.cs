namespace BookManagement.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Transaction
    {
        [Key]
        [StringLength(5)]
        public string transaction_id { get; set; }

        [Required]
        [StringLength(5)]
        public string Order_ID { get; set; }

        [Required]
        [StringLength(5)]
        public string cashier_id { get; set; }

        public decimal amount { get; set; }

        [Required]
        [StringLength(20)]
        public string payment_method { get; set; }

        public DateTime? TransactionDate { get; set; }

        public virtual Cashier Cashier { get; set; }

        public virtual Order Order { get; set; }
    }
}
