using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class SquadMemberEvent
    {
        public int PersonId { get; set; }

        public int SquadId { get; set; }

        public int SquadEventId { get; set; }

        public string SquadEventName { get; set; }

        public DateTime SquadEventStart { get; set; }

        public DateTime SquadEventEnd { get; set; }

        public string SquadEventDescription { get; set; }

        public string SquadEventLocation { get; set; }

    }
}