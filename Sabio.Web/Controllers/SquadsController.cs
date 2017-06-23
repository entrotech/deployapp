using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Sabio.Web.Domain;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("squads")]
    [Authorize]
    public class SquadsController : BaseController
    {
        [Route("create")]
        [Route("{id:int}/edit")]
        public ActionResult Create(int id = 0) //assigned a default value of 0 so it is not null
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model); //runs through razor (processed on server to get pure HTML for browser)
        }

        [Route("indexjq")]
        [AllowAnonymous]
        public ActionResult Index()
        {
            return View();
        }

        [Route("index")]
        [Route]
        [AllowAnonymous]
        public ActionResult IndexNg()
        {
            return View();
        }
        
        [Route ("manage")]
        [Route("{id:int}/manage")]
        public ActionResult Manage(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model);
        }

        [Route("{id:int}/HomeNg1")]
        [AllowAnonymous]
        public ActionResult HomeNg1(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model);
        }
    }
}