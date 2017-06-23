using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class TimecardEntrySearchRequest
    {
        public int Id { get; set; }
        public int ProjectId { get; set; }
        public int PersonId { get; set; }
        public int TimecardStatusId { get; set; }
        public string TimecardStatus { get; set; }
        public bool IsActive { get; set; }
        public DateTime? StartDateTimeUtc { get; set; }
        public DateTime? StartDateTimeLocal { get; set; }
        public DateTime? EndDateTimeUtc { get; set; }
        public DateTime? EndDateTimeLocal { get; set; }
    }
}