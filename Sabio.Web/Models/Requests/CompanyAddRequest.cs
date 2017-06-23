using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class CompanyAddRequest
    {
        
        [Required]
        public string Name { get; set; }
        public string PhoneNumber { get; set; }
        public string Email { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public int StateProvinceId { get; set; }
        public int CountryId { get; set; }

        public string PostalCode { get; set; }
        [Required(ErrorMessage = "Name field required")]
        public bool Inactive { get; set; }
        public bool IsDeploy { get; set; }
        public int PersonId { get; set; }
    }
}