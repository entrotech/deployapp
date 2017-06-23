using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class EducationLevelAddRequest
    {
        public string Code  { get; set; }
        [Required, MaxLength(50)]
        public string Name { get; set; }
        public bool Inactive { get; set; }
        public int DisplayOrder { get; set; }
       
    }
}