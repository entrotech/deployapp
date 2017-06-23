using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Sabio.Web.Models.ViewModels;
using Sabio.Web.Domain;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("contactrequests")]
    [Authorize(Roles = "Admin")]
    public class ContactRequestsController : BaseController
    {
        // GET: Emails
        [Route]
        public ActionResult Index()
        {
            return View();
        }
    }
}