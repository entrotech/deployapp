using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class SecurityToken
    {
        public Guid TokenGuid { get; set; }
        public int TokenTypeId { get; set; }
        public String FirstName { get; set; }
        public String LastName { get; set; }
        public string Email { get; set; }
        public String AspNetUserId { get; set; }
        public DateTime DateCreated { get; set; }
    }
}