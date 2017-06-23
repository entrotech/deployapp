using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class SquadBase
    {
        public int MemberId { get; set; }
        public int MemberStatusId { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public string Mission { get; set; }
        public bool IsLeader { get; set; }


    }
}