using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class HomeStatisticsUpdateRequest
    {
        public string Title1 { get; set; }
        public string Number1 { get; set; }
        public bool AutoPopulate1 { get; set; }
        public string Title2 { get; set; }
        public string Number2 { get; set; }
        public bool AutoPopulate2 { get; set; }
        public string Title3 { get; set; }
        public string Number3 { get; set; }
        public bool AutoPopulate3 { get; set; }
        public string Title4 { get; set; }
        public string Number4 { get; set; }
        public bool AutoPopulate4 { get; set; }
    }
}