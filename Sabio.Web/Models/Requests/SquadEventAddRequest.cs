using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class SquadEventAddRequest
    {
        [Required]
        public string Name { get; set; }
        [Required]
        public DateTime EventStart { get; set; }
        [Required]
        public DateTime EventEnd { get; set; }
        public string Description { get; set; }
        public string Location { get; set; }
        public int SquadId { get; set; }
        public string Color { get; set; }
        public string Timezone { get; set; }
    }
}