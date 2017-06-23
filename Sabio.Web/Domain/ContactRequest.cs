using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class ContactRequest
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public string Email { get; set; }

        public string Message { get; set; }

        public DateTime DateCreated { get; set; }

        public string Notes { get; set; }

        public int ContactRequestStatusId {get; set;}

    }
}