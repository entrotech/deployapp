using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class PersonNotificationPreferenceUpdateRequest : PersonNotificationPreferenceAddRequest
    {
        public int Id { get; set; }
    }
}