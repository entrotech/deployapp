using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class Announcement
    {
        public int Id { get; set; }

        public int PersonId { get; set; }

        public string Title { get; set; }

        public AnnouncementCategory AnnouncementCategory { get; set; }

        public string Body { get; set; }

        public DateTime DateCreated { get; set; }

        public string PersonFirstName { get; set; }

        public string PersonLastName { get; set; }

        public string PhotoKey { get; set; }
    }
}