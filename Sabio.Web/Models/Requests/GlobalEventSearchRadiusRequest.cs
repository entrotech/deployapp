using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class GlobalEventSearchRadiusRequest
    {
        public decimal Lat { get; set; }
        public decimal Lng { get; set; }
        public int Radius { get; set; }
    }
}