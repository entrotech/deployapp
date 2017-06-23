using Sabio.Web.Domain;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models
{
    public class ProposalAddRequest
    {
        [Required]
        [MaxLength (4000)]
        public string Description { get; set; }
        public int Budget { get; set; }
        public string Deadline { get; set; }
        [Required]
        [MaxLength(200)]
        public string ProjectType { get; set; }
        [Required]
        public string FirstName { get; set; }
     
        public string LastName { get; set; }
        public string Company { get; set; }
        [Required]
        public string PhoneNumber { get; set; }
        [Required]
        [MaxLength(128)]
        public string Email { get; set; }
        [MaxLength(4000)]
        public string Notes { get; set; }

        public int? StatusId{ get; set; }



    }
}