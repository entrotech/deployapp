using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("Faqs")]
    public class FaqsController : BaseController
    {
        
        [Route("index")]
        [Route]
        public ActionResult Index()
        {
            return View("Home");
        }


        [Route ("create")]
        [Route("{id:int}/edit")]
        [Authorize(Roles = "Admin")]
        public ActionResult Create(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;

            return View(model);
        }

        [Authorize(Roles = "Admin")]
        [Route("index/admin")]
        public ActionResult Admin()
        {
            return View("Index");
        }
    }
}