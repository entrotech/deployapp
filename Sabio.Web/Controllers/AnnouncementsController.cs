using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("announcements")]
    public class AnnouncementsController : BaseController
    {
        [Route("{id:int}")]
        public ActionResult ViewById(int id)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();

            model.Item = id;

            return View("Announcement", model);
        }

        [Route("{id:int}/edit")]
        [Route("create")]
        [Authorize(Roles = "Admin")]
        public ActionResult Create(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();

            model.Item = id;

            return View("CreateNg", model);
        }

        [Route]
        [Route("index")]
        public ActionResult Index()
        {
            return View("IndexBlogTheme2");
        }

        [Route("index/admin")]
        [Authorize(Roles = "Admin")]
        public ActionResult Admin()
        {
            return View("IndexNg2");
        }
    }
}