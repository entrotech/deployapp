using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class ProjectPersonBase
    {
        public int PersonId { get; set; }
        public int ProjectId { get; set; }
        public string ProjectName { get; set; }
        public int StatusId { get; set; }
        public string ProjectPersonStatus { get; set; }
        public bool IsLeader { get; set; }
        public decimal? HourlyRate { get; set; }
    }
}