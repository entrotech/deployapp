using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class PersonNotificationPreference
    {
      
        public int PersonId { get; set; }
        public int NotificationEventId { get; set; }
        public string NotificationEventName { get; set; }
        public bool SendEmail { get; set; }
        public bool SendText { get; set; }

    }
}