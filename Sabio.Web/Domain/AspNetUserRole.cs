using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class AspNetUserRole
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string AspNetUserId { get; set; }
        public int TotalRows { get; set; }
        public bool hasUsr { get; set; }
        public bool hasMgr { get; set; }
        public bool hasAdm { get; set; }
    }
}