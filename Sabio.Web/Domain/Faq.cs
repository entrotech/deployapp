using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class Faq
    {
        public int Id { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public string UserIdCreated { get; set; }
        public string Question { get; set; }
        public string Answer { get; set; }
        public int FaqCategoryId { get; set; }
        public FaqCategory FaqCategory { get; set; }

    }
}