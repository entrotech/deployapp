using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class BlogBlogTagAddRequest
    {
        public int BlogId { get; set; }
        public int BlogTagId { get; set; }
    }
}