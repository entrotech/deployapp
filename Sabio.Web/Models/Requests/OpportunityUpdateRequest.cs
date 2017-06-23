using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class OpportunityUpdateRequest : OpportunityAddRequest
    {
        public int Id { get; set; }
    }
}