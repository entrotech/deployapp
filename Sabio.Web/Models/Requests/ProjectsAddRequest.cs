using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class ProjectsAddRequest
    {
        [Required]
        public string  ProjectName { get; set; }
        [Required]
        public string Description { get; set; }
        public decimal? Budget { get; set; }
        public DateTime? Deadline { get; set;}
        [Required]
        public int CompanyId { get; set; }
        public string TrelloBoardId { get; set; }
        public string TrelloBoardUrl { get; set; }
    }
}