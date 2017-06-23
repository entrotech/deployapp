using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class LanguageProficiencyAddRequest
    {
        [Required]
        [MaxLength(50)]
        public string Name { get; set; }
        [Required]
        [MaxLength(5)]
        public string Code { get; set; }

        [Required]
        public int DisplayOrder { get; set; }

        [Required]
        public bool Inactive { get; set; }
    }
}