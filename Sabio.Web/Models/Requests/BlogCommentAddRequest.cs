using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class BlogCommentAddRequest
    {
       
        public string Comment { get; set; }
       
        public int? ParentId { get; set; }
      
        public int BlogId  { get; set; }
       
    }
}