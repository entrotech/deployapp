using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("Projects")]
    public class ProjectsController : BaseController
    {
        [Route]
        [Route("Index")]
        [Authorize]
        public ActionResult Index()
        {
            return View();
        }

        [Route("Admin")]
        [Authorize(Roles = "Admin")]
        public ActionResult ngIndex()
        {
            return View();
        }

        [Route("Create")]
        [Route("{id:int}/Edit")]
        [Authorize(Roles = "Admin")]
        public ActionResult ngCreate(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model);
        }

        [Route("{id:int}/Dashboard_old")]
        public ActionResult ngDashboard(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model);
        }

        [Route("{id:int}/Dashboard")]
        public ActionResult Dashboard_Blog(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model);
        }

        #region JQuery Endpoints


        [Route("{id:int}/DashboardJq")]
        public ActionResult Dashboard(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model);
        }

        // Temporarily set /projects to the jQuery version, until the ng version works
        [Route("Index/Admin")]
        public ActionResult IndexJq()
        {
            return View();
        }

        [Route("CreateJq")]
        [Route("{id:int}/EditJq")]
        public ActionResult Create(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;

            return View(model);
        }
    }
    #endregion
}