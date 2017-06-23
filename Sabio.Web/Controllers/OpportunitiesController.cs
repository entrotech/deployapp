using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{   
    [RoutePrefix("resources")]
    public class OpportunitiesController : BaseController
    {
        [Route]
        [Route("index")]
        [AllowAnonymous]
        public ActionResult IndexNg5()
        {
            return View("indexNg5");
        }

        [Route("index/admin")]
        [Authorize(Roles = "Admin")]
        public ActionResult Admin()
        {
            return View("Admin");
        }
    }

}