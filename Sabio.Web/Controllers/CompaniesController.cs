using Sabio.Web.Classes.AuthorizationFilters;
using Sabio.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    [RoutePrefix("companies")]
    public class CompaniesController : BaseController
    {
        [Route]
        [Route("index")]
        public ActionResult List()
        {
            return View();
        }

        
      
            
        [Route("Create")]
        [Authorize]
        public ActionResult Create()
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            return View(model);
        }
        [Route("{id:int}/Edit")]
        [CompanyAuthorize]
        public ActionResult Edit(int id)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View("Create",model);
        }

        [Route("{id:int}")]
        public ActionResult Read(int id)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model);
        }

        //#region jQuery Endpoints

        [Route("indexjq")]
        public ActionResult Index()
        {
            return View();
        }
        [Route("Invoice")]
        public ActionResult Invoice()
        {
            return View();
        }
    }
}
