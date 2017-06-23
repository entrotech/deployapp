using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class Proposal
    {
        

        public int Id { get; set; }
        public string Description { get; set; }
        public int Budget { get; set; }
        public string Deadline { get; set; }
        public string ProjectType { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Company { get; set; }
        public string PhoneNumber { get; set; }
        public string Email { get; set; }
        public string Notes { get; set; }
        public ProposalStatusCategory Status { get; set; }

        public int ProjectId { get; set; }


    }
}