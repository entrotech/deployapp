using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class JobPostingIndeedSearchRequest
    {
        private string _publisher = "8372949888953645";
        private string _v = "2";
        private string _format = "json";
        private string _userip = "127.0.0.1";

        public string publisher
        {
            get { return _publisher; }
        }
        public string v
        {
            get { return _v; }
        }
        public string format
        {
            get { return _format; }
        }
        public string q { get; set; }
        public string l { get; set; }
        public double radius { get; set; }
        public string jt { get; set; }
        public int start { get; set; }
        public int limit { get; set; }
        public string userip
        {
            get { return _userip; }
        }
        public string useragent { get; set; }
    }
}