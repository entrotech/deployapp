using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class SquadEvent
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public string UserIdCreated { get; set; }
        public DateTime EventStart { get; set; }
        public DateTime EventEnd { get; set; }
        public string Description { get; set; }
        public string Location { get; set; }
        public int SquadId { get; set; }
        public string Color { get; set; }
        public string Timezone { get; set; }
    }
}