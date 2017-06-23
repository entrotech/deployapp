using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class AnnouncementAndCategory
    {
        public List<AnnouncementCategoryTotal> CategoriesWithTotals { get; set; }

        public List<Announcement> Announcements { get; set; }
    }
}