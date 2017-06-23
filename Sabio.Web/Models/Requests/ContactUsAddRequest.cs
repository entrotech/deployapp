using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Request
{
    public class ContactUsAddRequest
    {

        public string Name { get; set; }
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }
        public string Message { get; set; }

        public int ContactRequestStatusId { get; set; }

    }
}