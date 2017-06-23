using System.ComponentModel.DataAnnotations;

namespace Sabio.Web.Models.Request
{
    public class ProposalSendRequest
    {
        public string Description { get; set; }
        public int? Budget { get; set; }
        public string Deadline { get; set; }
        public string ProjectType { get; set; }
        public string FirstName { get; set; }

        public string LastName { get; set; }
        public string Company { get; set; }
        public string PhoneNumber { get; set; }

        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }
    }
}