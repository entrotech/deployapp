using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Sabio.Web.Models.ViewModels;


namespace Sabio.Web.Controllers
{
    [RoutePrefix("proposals")]
    public class ProposalsController : BaseController
    {
        [Route("ngIndex")]
        [Authorize(Roles = "Admin")]
        public ActionResult ngIndex()
        {
            return View();
        }

        [Route]
        [AllowAnonymous]
        [Route("create")]
        public ActionResult Create(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model);
        }

        [Authorize(Roles = "Admin")]
        [Route("admin/create")]
        public ActionResult AdminCreate()
        {
            return View();
        }
    }
}