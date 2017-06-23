using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class AnnouncementAddRequest
    {
        [Required]
        [MaxLength(50)]
        public string Title { get; set; }

        [Required]
        [MaxLength(4000)]
        public string Body { get; set; }

        [Required]
        [Range(1, 3)]
        public int AnnouncementCategoryId { get; set; }

        public string PhotoKey { get; set; }
    }
}