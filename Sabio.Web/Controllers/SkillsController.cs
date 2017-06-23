using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

// Still in jQuery
namespace Sabio.Web.Controllers
{
    [RoutePrefix("skills")]
    [Authorize(Roles = "Admin")]
    public class SkillsController : BaseController
    {
        [Route("index")][Route("")]
        public ActionResult NgIndex()
        {
            return View();
        }
    }
}