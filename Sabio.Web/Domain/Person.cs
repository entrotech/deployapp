using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class Person : PersonBase
    {
        public DateTime? DateOfBirth { get; set; }
        public string DOBFormatted
        {
            get
            {
                if (DateOfBirth.HasValue)
                {
                    return DateOfBirth.Value.ToShortDateString();
                }
                return "";
            }
        }
        public string AspNetUserId { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public string UserIdCreated { get; set; }
        public bool InActive { get; set; }
        public int DisplayOrder { get; set; }
        public List<PersonLanguage> Languages { get; set; }
        public List<Skill> Skills { get; set; }
        public List<MilitaryBase> MilitaryBases { get; set; }
        
        public List<CompanyBase> Companies { get; set; }
        public List<SquadBase> Squads { get; set; }     
        public string Description { get; set; }
        public string EmploymentStatus { get; set;}
        public List<PersonNotificationPreference> Preferences { get; set; }
        public bool IsEmployed { get; set; }
        public bool OpCodeEmployAssist { get; set; }

        public int EducationLevelId { get; set; }
        public int ServiceBranchId { get; set; }
        public bool IsPhonePublic { get; set; }
        public bool IsAddressPublic { get; set; }
        public bool IsEmailPublic { get; set; }
        public bool IsDateOfBirthPublic { get; set; }
    }
}