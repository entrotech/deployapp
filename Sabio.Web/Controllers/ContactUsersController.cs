using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("contactusers")]
    [Authorize(Roles = "Admin")]
    public class ContactUsersController : BaseController
    {
        [Route]
        public ActionResult Contact()
        {
            return View();
        }
    }
}