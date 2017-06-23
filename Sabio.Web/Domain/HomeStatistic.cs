using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class HomeStatistic
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Number { get; set; }
        public bool AutoPopulate { get; set; }
    }
}