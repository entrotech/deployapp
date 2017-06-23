using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class BlogAddRequest
    {
        [Required, StringLength(200)]
        public string Title { get; set; }
        [Required]
        public string Body { get; set; }
        [Required, StringLength(50)]
        public string BlogCategory { get; set; }
        [Required]
        public bool Private { get; set; }
        public List<int> BlogTagIds { get; set; }
    }
}