using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("blogtags")]
    [Authorize(Roles = "Admin")]
    public class BlogTagsController : BaseController
    {
        // GET: BlogTags
        [Route("")][Route("index")]
        public ActionResult NgIndex()
        {
            return View();
        }
    }
}