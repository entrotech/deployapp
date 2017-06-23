using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class TimecardEntryAddRequest
    {
        [Required]
        public int ProjectId { get; set; }
        [Required]
        public int PersonId { get; set; }
        public int TimecardStatusId { get; set; }
        public int InvoiceId { get; set; }
        public DateTime? StartDateTimeUtc { get; set; }
        public DateTime? StartDateTimeLocal { get; set; }
        public DateTime? EndDateTimeUtc { get; set; }
        public DateTime? EndDateTimeLocal { get; set; }
    }
}