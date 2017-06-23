using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class JobPostingUpdateRequest : JobPostingAddRequest
    {
        public int Id { get; set; }
    }
}