using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Sabio.Web.Models.Requests
{
    public class FaqAddRequest

    {
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
            
        public string UserIdCreated { get; set; }
        [Required]
        [MaxLength (500)]
        public string Question { get; set; }
        [Required]       
        public string Answer { get; set; }
        [Required]
        public int FaqCategoryId { get; set; }

    }
}