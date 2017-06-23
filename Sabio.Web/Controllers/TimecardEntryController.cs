using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Sabio.Web.Models.ViewModels;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("timecardentry")]
    public class TimecardEntryController : BaseController
    {
        [Route("index")][Route("")]
        public ActionResult Index()
        {
            return View();
        }
        [Route("create")]
        public ActionResult Create()
        {
            return View();
        }
    }
}