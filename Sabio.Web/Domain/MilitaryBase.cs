using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class MilitaryBase
    {
        public int Id { get; set; }
        public string MilitaryBaseName { get; set; }
        public int ServiceBranchId { get; set; }
        public string ServiceBranchName { get; set; }

    }
}