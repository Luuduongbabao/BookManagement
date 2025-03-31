namespace BookManagement.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Admin")]
    public partial class Admin
    {
        [StringLength(5)]
        public string AdminID { get; set; }

        [Required]
        [StringLength(100)]
        public string AdminName { get; set; }

        [Required]
        [StringLength(100)]
        public string AdminEmail { get; set; }

        [Column(TypeName = "text")]
        [Required]
        public string AdminAddress { get; set; }

        [Required]
        [StringLength(20)]
        public string AdminPhone { get; set; }

        [Required]
        [StringLength(255)]
        public string AdminPassword { get; set; }

        [Column(TypeName = "date")]
        public DateTime? AdminDOB { get; set; }
    }
}
