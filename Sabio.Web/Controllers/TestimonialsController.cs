using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("testimonials")]
    public class TestimonialsController : BaseController
    {
        [Authorize(Roles = "Admin")]
        [Route("index/admin")]
        public ActionResult Index()
        {
            return View();
        }
        [Route]
        [Route("index")]
        public ActionResult PublicIndex()
        {
            return View();
        }
    }
}