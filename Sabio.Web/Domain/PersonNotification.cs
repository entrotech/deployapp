using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class PersonNotification : PersonBase
    {
        public bool SendEmail { get; set; }
        public bool SendText { get; set; }
        public int LinkId { get; set; }
        public string GroupName { get; set; }
    }
}