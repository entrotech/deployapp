using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class PersonSearchRequest
    {
        public string SearchString { get; set; }
        public int? CurrentPage { get; set; }
        public int? ItemsPerPage { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        public decimal? Radius { get; set; }
        public bool IsVeteran { get; set; }
        public bool IsEmployer { get; set; }
        public bool IsFamilyMember { get; set; }
    }
}