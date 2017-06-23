using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class PersonLayout : PersonBase
    {
        public List<ProjectBase> Projects { get; set; }
        public TimecardEntryBase TimecardEntry { get; set; }
    }
}