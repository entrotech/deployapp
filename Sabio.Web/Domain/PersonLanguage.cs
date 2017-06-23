using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class PersonLanguage
    {
        public string Key { get; set; }
        public int LanguageId { get; set; }
        public string LanguageName { get; set; }
        public int LanguageProficiencyId { get; set; }
        public string LanguageProficiencyCode { get; set; }
    }
}