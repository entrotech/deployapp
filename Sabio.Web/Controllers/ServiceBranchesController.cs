using Sabio.Web.Models.ViewModels;
using System.Web.Mvc;

// Still in jQuery
namespace Sabio.Web.Controllers
{
    [RoutePrefix("ServiceBranches")]
    [Authorize(Roles = "Admin")]
    public class ServiceBranchesController : BaseController
    {
        // GET: ServiceBranches
        public ActionResult Index()
        {
            return View();
        }

        [Route("{id:int}/Edit")]
        [Route("Create")]
        public ActionResult Create(int id = 0)
        {
            ItemViewModel<int> model = new ItemViewModel<int>();
            model.Item = id;
            return View(model);
        }
        [Route("Test")]
        public ActionResult TestPage()
        {
            return View();
        }


    }
}