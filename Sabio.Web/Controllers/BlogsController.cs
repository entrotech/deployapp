using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.ViewModels;
using Sabio.Web.Domain;
using Sabio.Web.Services;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("blogs")]
   
    public class BlogsController : BaseController
    {
        [AllowAnonymous]
        [Route("indexjq")]
        public ActionResult Index()
        {
            return View();
        }
        [Route("{id:int}/edit")]
        
        [Route("create2")]
        public ActionResult Create(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model);
        }

        [Route("edit")]
        public ActionResult Edit()
        {
            return View();
        }
      
        [AllowAnonymous]
        public ActionResult BlogPage(int id)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
    
            model.Item = id;
            return View(model);

        }
        [Route("Index")][Route]
        public ActionResult AngularBlog()
        {            
            return View();

        }

        [Route("ngMasonry")]
        public ActionResult ngMasonry()
        {
            return View();

        }

       [Route("Create")]
        [Authorize]
        public ActionResult create2()
        {
            return View();
        }

    }
}