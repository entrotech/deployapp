using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class JobApplicationUpdateRequest
    {
        public int Id { get; set; }
        public int StatusId { get; set; }
        public string Notes { get; set; }
    }
}