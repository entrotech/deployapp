using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class JobApplicationUser
    {
        public int Id { get; set; }
        public int PersonId { get; set; }
        public int JobPostingId { get; set; }
        public string CoverLetter { get; set; }
        public string Status { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public JobPosting JobPosting { get; set; }
    }
}