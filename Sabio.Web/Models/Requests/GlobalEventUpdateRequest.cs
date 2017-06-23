using Sabio.Web.Models.Requests;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models
{
    public class GlobalEventUpdateRequest : GlobalEventAddRequest
    {
        [Required]
        public int Id { get; set; }
    }
}