using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class SecurityTokenAddRequest
    {
        public int TokenTypeId { get; set; }
        [Required, StringLength(50)]
        public string FirstName { get; set; }
        [Required, StringLength(50)]
        public string LastName { get; set; }
        [Required, StringLength(256)]
        public string Email { get; set; }
        [Required]
        public string AspNetUserId { get; set; }
    }
}