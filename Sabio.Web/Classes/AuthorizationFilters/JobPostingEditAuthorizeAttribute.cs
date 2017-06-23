using Microsoft.AspNet.Identity;
using Sabio.Web.Domain;
using Sabio.Web.Requests;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Classes.AuthorizationFilters
{
    public class JobPostingEditAuthorizeAttribute : AuthorizeAttribute
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
                int jobPostingId = 0;
                Int32.TryParse(HttpContext.Current.Request.Url.Segments[2].TrimEnd('/'), out jobPostingId);
                JobPostingService _jobPosting = new JobPostingService();
                JobPosting jp = _jobPosting.SelectById(jobPostingId);
                int companyId = jp.CompanyId;
                string userId = HttpContext.Current.User.Identity.GetUserId();
                if (CompanyPersonService.Verify(companyId, userId))
                {
                    base.OnAuthorization(filterContext);
                }
                else
                {
                    filterContext.Result = new RedirectToRouteResult(
                                                new System.Web.Routing.RouteValueDictionary(
                                                    new { controller = "jobpostings", action = jobPostingId }));
                }
            }

        }
    }
}