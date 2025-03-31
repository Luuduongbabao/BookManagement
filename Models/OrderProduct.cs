namespace BookManagement.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class OrderProduct
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(5)]
        public string OrderID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(5)]
        public string ProductID { get; set; }

        public int quantity { get; set; }

        public decimal price { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public decimal? DetailTotalPrice { get; set; }

        public virtual Order Order { get; set; }

        public virtual Product Product { get; set; }
    }
}
