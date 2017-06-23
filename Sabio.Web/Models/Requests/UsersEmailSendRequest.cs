using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class UsersEmailSendRequest
    {
        public string AspNetUserRoleId { get; set; }
        public string Subject { get; set; }
        public string Title { get; set; }
        public string Body { get; set; }
        public string PlainText { get; set; }
    }
}