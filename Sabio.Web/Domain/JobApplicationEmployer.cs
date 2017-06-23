using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class JobApplicationEmployer
    {
        public int Id { get; set; }
        public int PersonId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string JobTitle { get; set; }
        public string Resume { get; set; }
        public string CoverLetter { get; set; }
        public string ApplicationStatus { get; set; }
        public string Notes { get; set; }
        public DateTime DateCreated { get; set; }
    }
}