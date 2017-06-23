using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class BlogPhotoAddRequest
    {
        public int BlogId { get; set; }
        public string BlogPhotoKey { get; set; }
    }
}