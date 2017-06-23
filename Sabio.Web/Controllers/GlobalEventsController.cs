﻿using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("globalevents")]
    public class GlobalEventsController : BaseController
    {
        [Route]
        [Route("index")]
        public ActionResult Index()
        {
            return View("IndexBlogTheme3");
        }

        [Route("index/admin")]
        [Authorize(Roles = "Admin")]
        public ActionResult Admin()
        {
            return View("IndexAdminNg");
        }

        [Route("{id:int}")]
        public ActionResult ViewById(int id)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();

            model.Item = id;

            return View("GlobalEvent", model);
        }

        public ActionResult Map()
        {
            return View();
        }

        [Route("{id:int}/edit")]
        [Route("create")]
        [Authorize(Roles = "Admin")]
        public ActionResult Create(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();

            model.Item = id;

            return View(model);
        }

        [Route("search")]
        public ActionResult Search()
        {
            return View();
        }

        public ActionResult FullCal()
        {
            return View("FullCalTest");
        }

        public ActionResult OldIndex()
        {
            return View("index");
        }
    }
}