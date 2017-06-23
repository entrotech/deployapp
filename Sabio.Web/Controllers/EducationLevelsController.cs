using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web;
using Sabio.Web.Models.ViewModels;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("educationlevels")]
    [Authorize(Roles = "Admin")]
    public class EducationLevelsController : BaseController
    {
        [Route]
        [Route("index")]
        public ActionResult NgIndex()
        {
            return View();
        }
    }
}
