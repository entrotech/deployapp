using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("jobtags")]
    [Authorize(Roles = "Admin")]
    public class JobTagsController : BaseController
    {
      
        [Route("index")]
        [Route("")]
        public ActionResult NgIndex()
        {
            return View();
        }
    }
}