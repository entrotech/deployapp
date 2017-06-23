using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class Project : ProjectBase
    {       
        public string Description { get; set; }
        public decimal? Budget { get; set; }
        public DateTime? Deadline { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public int ProjectStatusId { get; set; }
        public string Status { get; set; }
        public int CompanyId { get; set; }
        public decimal AmountToDate { get; set; }
        public string TrelloBoardId { get; set; }
        public string TrelloBoardUrl { get; set; }
        public List<ProjectPerson> Staff { get; set; }

    }
}