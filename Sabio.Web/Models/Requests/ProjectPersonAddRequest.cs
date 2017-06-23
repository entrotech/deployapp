using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class ProjectPersonAddRequest
    {
        [Required]
        public int ProjectId { get; set; }
        [Required]
        public int PersonId { get; set; }
        public bool IsLeader { get; set; }
        public int StatusId { get; set; }
        public decimal? HourlyRate { get; set; }
    }
}