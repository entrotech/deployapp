using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("militarybases")]
    [Authorize(Roles = "Admin")]
    public class MilitaryBasesController : BaseController
    {
        [Route("index")]
        [Route("")]
        public ActionResult NgIndex()
        {
            return View();
        }
    }
}