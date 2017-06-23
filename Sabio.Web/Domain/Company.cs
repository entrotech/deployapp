using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class Company : CompanyBase
    {
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; } 
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public StateProvinceBase StateProvince { get; set; }
        public Country Country { get; set; }
        public string PostalCode { get; set; }
        public bool Inactive { get; set; }
        public bool IsDeploy { get; set; }
        public string CompanyIdCreated { get; set; }
        public List<JobPosting> JobPostings { get; set; }
        public List<PersonBase> People { get; set; }
    }
}