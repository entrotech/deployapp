using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class JobPostingUsaJobsSearchRequest
    {
        public string Keyword { get; set; }
        public string LocationName { get; set; }
        public int? PositionScheduleTypeCode { get; set; }
        public int Page { get; set; }
        public int ResultsPerPage { get; set; }
        public double? Radius { get; set; }
    }
}