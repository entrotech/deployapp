using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class Testimonial
    {
        public int Id { get; set; }
        public string Content { get; set; }
        public int DisplayOrder { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public PersonBase Person { get; set; }
        public bool Inactive { get; set; }
    }
}