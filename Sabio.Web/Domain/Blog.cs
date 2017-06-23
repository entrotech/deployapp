using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace Sabio.Web.Domain
{
    public class Blog
    {
        public int Id { get; set; }
        public string UserIdCreated { get; set; }
        public string Title { get; set; }
        public string Body { get; set; }
        public string BlogCategory { get; set; }
        public bool Private { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public List<BlogTag> Tags { get; set; }
        public string AuthorEmail { get; set; }

        public string FirstName { get; set; }

        public string  LastName { get; set; }

        public string PhotoKey { get; set; }
        public string Email { get; set; }

        public  List<BlogPhoto> Photos { get; set; }


        public string GenerateSlug 
        {
           get
            {
                string phrase = string.Format("{0}-{1}", Id, Title);

                string str = RemoveAccent(phrase).ToLower();

                // invalid chars           
                str = Regex.Replace(str, @"[^a-z0-9\s-]", "");

                // convert multiple spaces into one space   
                str = Regex.Replace(str, @"\s+", " ").Trim();

                // cut and trim 
                str = str.Substring(0, str.Length <= 45 ? str.Length : 45).Trim();

                // hyphens   
                str = Regex.Replace(str, @"\s", "-");
                return str;
            }
        }


        private string RemoveAccent(string input)
        {

            //byte[] bytes = System.Text.Encoding.GetEncoding("Cyrillic").GetBytes(input);
            //return System.Text.Encoding.ASCII.GetString(bytes);
            return Regex.Replace(input.Normalize(NormalizationForm.FormKD), @"[^-a-zA-Z0-9_]+", String.Empty);
        }
    }
}