using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class SquadTag
    {
        public int Id { get; set; }
        public string Keyword { get; set; }
        public int DisplayOrder { get; set; }
        public bool Inactive { get; set; }
    }
}