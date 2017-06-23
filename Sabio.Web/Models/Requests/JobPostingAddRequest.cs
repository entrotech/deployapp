using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class JobPostingAddRequest
    {
        [Required]
        public int CompanyId { get; set; }
        [StringLength(100)]
        public string PositionName { get; set; }
        [StringLength(100)]
        public string StreetAddress { get; set; }
        [StringLength(50)]
        public string City { get; set; }
        public int StateProvinceId { get; set; }
        public int CountryId { get; set; }
        public int? Compensation { get; set; }
        public int CompensationRateId { get; set; }
        public int FullPartId { get; set; }
        public int ContractPermanentId { get; set; }
        public int ExperienceLevelId { get; set; }
        [StringLength(4000)]
        public string Description { get; set; }
        [StringLength(4000)]
        public string Responsibilities { get; set; }
        [StringLength(4000)]
        public string Requirements { get; set; }
        [StringLength(4000)]
        public string ContactInformation { get; set; }
        public int JobPostingStatusId { get; set; }
        public decimal Latitude { get; set; }
        public decimal Longitude { get; set; }
        public List<int> JobTagIds { get; set; }
    }
}