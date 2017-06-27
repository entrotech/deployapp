using Microsoft.AspNet.Identity.EntityFramework;
using Sabio.Web.Classes;
using Sabio.Web.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.ViewModels
{
    /// <summary>
    /// 
    /// </summary>
    public class BaseViewModel
    {//Sabio: make note that this base class does not have to be, or should not be abstract. 
     // it is a perfectly good class to be used as a ViewModel 

        public bool IsLoggedIn { get; set; }
        public string[] Roles { get; set; }
        public bool IsAdmin
        {
            get
            {
                return Roles != null && Roles.Contains("Admin");
            }
        }
        public bool IsManager
        {
            get
            {
                return Roles != null && Roles.Contains("Manager");
            }
        }
        public bool IsUser
        {
            get
            {
                return Roles != null && Roles.Contains("User");
            }
        }
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string UserPhoneNumber { get; set; }
        public string UserEmail { get; set; }
        public string FullName
        {
            get
            {
                return FirstName + " " + LastName;
            }
        }
        public List<ProjectBase> projects { get; set; }
        public TimecardEntryBase TimecardEntry { get; set; }

        public string SiteDomain
        {
            get { return SiteConfig.SiteDomain; }
        }

        public string BaseUrl
        {
            get { return SiteConfig.BaseUrl; }
        }

        public string SendGrid
        {
            get { return SiteConfig.SendGrid; }
        }

        public string Environment
        {
            get { return SiteConfig.Environment; }
        }

        public string SiteAdminEmailAddress
        {
            get { return SiteConfig.SiteAdminEmailAddress; }
        }

        public string BrandName
        {
            get { return SiteConfig.BrandName; }
        }

        public string BrandTagline
        {
            get { return SiteConfig.BrandTagline; }
        }

        public string AWSProfileName
        {
            get { return SiteConfig.AWSProfileName; }
        }

        public string AWSRegion
        {
            get { return SiteConfig.AWSRegion; }
        }

        public string AWSBaseUrl
        {
            get { return SiteConfig.AWSBaseUrl; }
        }

        public string AWSBucket
        {
            get { return SiteConfig.AWSBucket; }
        }

        public string AWSFolder
        {
            get { return SiteConfig.AWSFolder; }
        }


    }
}