using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class JobPostingMonsterSearchRequest
    {
        public string cat { get; set; }
        public string q { get; set; }
        public int page { get; set; }
        public int pagesize { get; set; }
        public int jtyp { get; set; }
        public int jtsa { get; set; }
        public double salmin { get; set; }
        public double zip { get; set; }
        public double rad { get; set; }
        public string cy { get; set; }
    }
}