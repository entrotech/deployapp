using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class SquadMember
    {
        public int Id { get; set; }

        public int SquadId { get; set; }

        public PersonBase Person { get; set; }

        public string UserIdCreated { get; set; }

        public string LeaderComment { get; set; }

        public DateTime DateCreated { get; set; }

        public DateTime DateModified { get; set; }

        public SquadMemberStatus Status { get; set; }
        public bool IsLeader { get; set; }



    }
}