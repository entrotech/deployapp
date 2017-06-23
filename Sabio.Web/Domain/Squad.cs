using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class Squad : SquadBase
    {
        public string Notes { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public string UserIdCreated { get; set; }
        public List <SquadTag> squads { get; set; }
        public List<SquadEvent> SquadEvents { get; set; }
        public List<SquadMember> SquadMember { get; set; }

        public List<SquadTag> SquadTag { get; set; }
    }
}