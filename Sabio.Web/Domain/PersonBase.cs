using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class PersonBase
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string PhoneNumber { get; set; }
        public string Email { get; set; }
        public string JobTitle { get; set; }
        public string PhotoKey { get; set; }
        public string ProfilePicture { get; set; }
        public string FullName
        {
            get
            {
                return (FirstName ?? "") + " " +
                    (MiddleName ?? "") + " " +
                    (LastName ?? "");
            }
        }
        public string Address1 { set; get; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public StateProvinceBase StateProvince { get; set; }
        public string PostalCode { get; set; }
        public Country Country { get; set; }
        public decimal Latitude { get; set; }
        public decimal Longitude { get; set; }
        public bool IsVeteran { get; set; }
        public bool IsEmployer { get; set; }
        public bool IsFamilyMember { get; set; }


    }
}