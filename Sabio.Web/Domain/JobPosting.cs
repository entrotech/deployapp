using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class JobPosting
    {
        public int Id { get; set; }
        public int CompanyId { get; set; }
        public string CompanyName { get; set; }
        public string PositionName { get; set; }
        public string StreetAddress { get; set; }
        public string City { get; set; }
        public int StateProvinceId { get; set; }
        public int CountryId { get; set; }
        public int Compensation { get; set; }
        public int CompensationRateId { get; set; }
        public int FullPartId { get; set; }
        public int ContractPermanentId { get; set; }
        public int ExperienceLevelId { get; set; }
        public string Description { get; set; }
        public string Responsibilities { get; set; }
        public string Requirements { get; set; }
        public string ContactInformation { get; set; }
        public int JobPostingStatusId { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public string CountryName { get; set; }
        public string StateProvinceName { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public int TotalRows { get; set; }
        public List<JobTag> JobTags { get; set; }
        public List<JobApplicationEmployer> Applications { get; set; }
    }
}