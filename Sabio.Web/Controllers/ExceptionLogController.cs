﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("exceptions")]
    [Authorize(Roles = "Admin")]
    public class ExceptionLogController : BaseController
    {
        [Route]
        [Route("index")]
        public ActionResult Index()
        {
            return View();
        }
    }
}