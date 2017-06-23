using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class SkillAddRequest
    {
        [Required, StringLength(250)]
        public string Name { get; set; }
        public string Code { get; set; }
        public int DisplayOrder { get; set; }
        public bool Inactive { get; set; }
    }
}