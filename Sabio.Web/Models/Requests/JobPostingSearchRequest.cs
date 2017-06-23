using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class JobPostingSearchRequest
    {
        public string SearchString { get; set; }
        public int? CurrentPage { get; set; }
        public int? ItemsPerPage { get; set; }
        public double? Distance { get; set; }
        public int? Compensation { get; set; }
        public int? FullPartId { get; set; }
        public int? ContractPermanentId { get; set; }
        public int? ExperienceLevelId { get; set; }
        public double? Latitude { get; set; }
        public double? Longitude { get; set; }
        public bool IsDeploy { get; set; }
        public List<int> JobTagIds { get; set; }
    }
}