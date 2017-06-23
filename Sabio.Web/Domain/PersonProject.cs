using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class PersonProject
    {
        public int PersonId { get; set; }
        public ProjectBase Project { get; set; }
        public DateTime Deadline { get; set; }
        public CompanyBase Company { get; set; }
        public string ProjectPersonStatus { get; set; }
        public int ProjectPersonStatusId { get; set; }
        public decimal? CurrentRate { get; set; }
        public int? TimeWorked { get; set; }
        public decimal? Earnings { get; set; }
        public bool IsLeader { get; set; }
        public string TrelloBoardUrl { get; set; }
        public DateTime DateCreated { get; set; }
    }
}