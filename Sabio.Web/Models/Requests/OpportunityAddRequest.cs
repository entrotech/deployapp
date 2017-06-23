using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class OpportunityAddRequest
    {
        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        [Required]
        [MaxLength(500)]
        public string Description { get; set; }

        [Required]
        [MaxLength(50)]
        public string ContactPersonFirstName { get; set; }

        [Required]
        [MaxLength(50)]
        public string ContactPersonLastName { get; set; }

        [Required]
        [EmailAddress]
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public int StateProvinceId { get; set; }            // my original
        public string PostalCode { get; set; }
        public int CountryId { get; set; }
        public string UserIdCreated  { get; set; }
        [Required]
        public DateTime DateTimeStart { get; set; }
        public DateTime? DateTimeEnd { get; set; }
    }
}