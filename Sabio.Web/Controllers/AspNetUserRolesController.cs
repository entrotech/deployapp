using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("aspnetuserroles")]
    [Authorize(Roles = "Admin")]
    public class AspNetUserRolesController : BaseController
    {
        [Route("index")]
        [Route("")]
        public ActionResult Index()
        {
            return View();
        }
    }
}