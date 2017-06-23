﻿using Sabio.Web.Classes.AuthorizationFilters;
using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("jobpostings")]
    public class JobPostingsController : BaseController
    {
        [Route("create")]
        [JobPostingCreateAuthorize]
        public ActionResult Create()
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            return View(model);
        }
        [Route("{id:int}/edit")]
        [JobPostingEditAuthorize]
        public ActionResult Edit(int id)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View("Create", model);
        }
        [Route("index")]
        [Route]
        public ActionResult Index()
        {
            return View();
        }
        [Route("{id:int}")]
        public ActionResult Read(int id)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model);
        }
    }
}