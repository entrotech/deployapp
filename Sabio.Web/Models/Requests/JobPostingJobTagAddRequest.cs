using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class JobPostingJobTagAddRequest
    {
        public int JobPostingId { get; set; }
        public int JobTagId { get; set; }
    }
}