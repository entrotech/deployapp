using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class SquadAddRequest : SquadMemberAddRequest
    {
        [Required, StringLength(50)]
        public string Name { get; set; }
        public string Mission { get; set; }
        public string Notes { get; set; }

        public int[] SquadTagIds { get; set; }


    }
}