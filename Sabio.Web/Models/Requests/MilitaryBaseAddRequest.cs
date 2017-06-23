using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class MilitaryBaseAddRequest
    {
        public string MilitaryBaseName { get; set; }
        public int ServiceBranchId { get; set; }
        public string ServiceBranchName { get; set; }
    }
}