using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class BlogComment
    {

        public int Id { get; set; }

        public string FirstName { get; set; }
        public string LastName { get; set; }

        public string Email { get; set; }
        public string Comment { get; set; }
       
        public DateTime DateCreated { get; set; }
      
        public int BlogId { get; set; }
        public int?  ParentId { get; set; }

        public int Level { get; set; }
        public List<BlogComment> Replies { get; set; }
        public string  PhotoKey { get; set; }
        public bool IsApproved { get; set; }


    }
}