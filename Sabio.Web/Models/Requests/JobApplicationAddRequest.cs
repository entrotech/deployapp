using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class JobApplicationAddRequest
    {
        public int PersonId { get; set; }
        public int JobPostingId { get; set; }
        public string CoverLetter { get; set; }
    }
}