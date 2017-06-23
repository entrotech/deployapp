using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class SquadTagAddRequest
    {
        [Required, StringLength(128)]
        public string Keyword { get; set; }
        public int DisplayOrder { get; set; }
        public bool Inactive { get; set; }
    }
}