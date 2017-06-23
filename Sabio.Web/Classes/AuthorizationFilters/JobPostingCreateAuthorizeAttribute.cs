using Microsoft.AspNet.Identity;
using Sabio.Web.Requests;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Classes.AuthorizationFilters
{
    public class JobPostingCreateAuthorizeAttribute : AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            if (!filterContext.HttpContext.Request.IsAuthenticated)
            {
                filterContext.Result = new RedirectToRouteResult(
                                            new System.Web.Routing.RouteValueDictionary(
                                                new { controller = "users", action = "login" }));
            }
            else
            {
                string userId = HttpContext.Current.User.Identity.GetUserId();
                if (CompanyPersonService.VerifyHasCompany(userId))
                {
                    base.OnAuthorization(filterContext);
                }
                else
                {
                    filterContext.Result = new RedirectToRouteResult(
                                                new System.Web.Routing.RouteValueDictionary(
                                                    new { controller = "companies", action = "create" }));
                }
            }

        }
    }
}