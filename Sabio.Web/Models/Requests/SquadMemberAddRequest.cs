using Sabio.Web.Domain;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class SquadMemberAddRequest
    {
        
        [Required]
        public int SquadId { get; set; }
        [Required]
        public int PersonId { get; set; }
        public string UserIdCreated { get; set; }
        [MaxLength(250)]
        public string LeaderComment { get; set; }
        [Required]
        public int MemberStatusId { get; set; }
        public bool IsLeader { get; set; }

    }
}