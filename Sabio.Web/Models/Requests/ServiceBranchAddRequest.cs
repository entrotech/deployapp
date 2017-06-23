using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class ServiceBranchAddRequest
    {
        [Required, StringLength(50, ErrorMessage = "Code must not exceed 50 Characters")]
        public string Code { get; set; }
        [Required,StringLength(20,ErrorMessage ="Code must not exceed 20 Characters")]
        public string Name { get; set; }
        [Required(ErrorMessage ="Name field required")]
        public bool Inactive { get; set; }
        [Required]
        public int DisplayOrder { get; set; }
      
    }
}