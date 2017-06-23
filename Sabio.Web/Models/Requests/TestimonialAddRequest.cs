using System.ComponentModel.DataAnnotations;

namespace Sabio.Web.Models.Requests
{
    public class TestimonialAddRequest
    {
        [Required]
        public string Content { get; set; }
        public int PersonId { get; set; }
    }
}