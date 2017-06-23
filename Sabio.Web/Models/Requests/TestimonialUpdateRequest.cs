using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class TestimonialUpdateRequest : TestimonialAddRequest
    {
        [Required]
        public int Id { get; set; }
        public bool Inactive { get;  set; }
    }
}