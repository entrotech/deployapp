using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class BlogTagAddRequest
    {
        [Required, StringLength(100)]
        public string Keyword { get; set; }
    }
}