using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class TimecardEntry : TimecardEntryBase
    {
        public string ProjectName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int PersonId { get; set; }
        public int TimecardStatusId { get; set; }
        public string Status { get; set; }
        public string ProjectStatus { get; set; }
        public int InvoiceId { get; set; }       
        public DateTime StartDateTimeLocal { get; set; }       
        public DateTime EndDateTimeLocal { get; set; }
        public decimal EarningsOnProj { get; set; }
    }
}