using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("SquadEvents")]
    public class SquadEventsController : BaseController
    {
        [Route("")] [Route("Index")]
        public ActionResult Index()
        {
            return View();
        }

        [Route("Create")]
        [Route("{id:int}/edit")]
        public ActionResult Create(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;

            return View(model);
        }

        [Route("EventDetails/{id:int}")]
        public ActionResult EventDetails(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;

            return View("EventDetails2", model);
        }
    }
}