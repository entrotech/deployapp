using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using Sabio.Web.Domain;

namespace Sabio.Web.Models.Requests
{
    public class ProposalUpdateRequest: ProposalAddRequest
    {
        public int Id { get; set; }
        public ProposalStatusCategory Status { get; set; }
        public string UserIdCreated { get; set; }
        public int? ProjectId { get; set; }

    }
}