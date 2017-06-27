using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace Sabio.Web.Classes
{

    /// <summary>
    /// Provides type-safe access to app settings from config file
    /// </summary>
    public class SiteConfig
    {
        public static string SiteDomain
        {
            get { return GetFromConfig("SiteDomain"); }
        }

        public static string BaseUrl
        {
            get { return GetFromConfig("BaseUrl"); }
        }

        public static string SendGrid
        {
            get { return GetFromConfig("SendGrid"); }
        }

        public static string Environment
        {
            get { return GetFromConfig("Environment"); }
        }

        public static string SiteAdminEmailAddress
        {
            get { return GetFromConfig("SiteAdminEmailAddress"); }
        }

        public static string BrandName
        {
            get { return GetFromConfig("BrandName"); }
        }

        public static string BrandTagline
        {
            get { return GetFromConfig("BrandTagline"); }
        }

        public static string AWSProfileName
        {
            get { return GetFromConfig("AWSProfileName"); }
        }

        public static string AWSRegion
        {
            get { return GetFromConfig("AWSRegion"); }
        }

        public static string AWSBaseUrl
        {
            get { return GetFromConfig("AWSBaseUrl"); }
        }

        public static string AWSBucket
        {
            get { return GetFromConfig("AWSBucket"); }
        }

        public static string AWSFolder
        {
            get { return GetFromConfig("AWSFolder"); }
        }
        public static string GetUrlFromFileKey(string fileKey)

        {
            string url;
            
            {
                 url = "//" + AWSBucket +"."+ AWSBaseUrl + "/" + AWSFolder + "/" + fileKey;
                 
            }
       
            return url;
        }

        #region Helper Methods

        private static string GetFromConfig(string key)
        {
            return WebConfigurationManager.AppSettings[key];
        }

        #endregion


    }
}