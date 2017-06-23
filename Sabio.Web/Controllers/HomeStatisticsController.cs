using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("homestatistics")]
    [Authorize(Roles = "Admin")]
    public class HomeStatisticsController : BaseController
    {
        [Route]
        public ActionResult Stats()
        {
            return View();
        }
    }
}