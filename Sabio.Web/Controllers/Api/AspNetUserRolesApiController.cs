using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Sabio.Web.Requests;
using Sabio.Web.Domain;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/aspnetuserroles")]
    public class AspNetUserRolesApiController : ApiController
    {
        IAspNetUserRoleService _AspNetUserRoleService = null;
        public AspNetUserRolesApiController(IAspNetUserRoleService AspNetUserRoleService)
        {
            _AspNetUserRoleService = AspNetUserRoleService;
        }

        [Route, HttpPost]
        public HttpResponseMessage Post(AspNetUserRoleAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            _AspNetUserRoleService.Post(model);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("Search"), HttpGet]
        public HttpResponseMessage Search([FromUri]AspNetUserRoleSearchRequest model)
        {
            ItemsResponse<AspNetUserRole> response = new ItemsResponse<AspNetUserRole>();
            response.Items = _AspNetUserRoleService.Search(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpDelete]
        public HttpResponseMessage Delete(AspNetUserRoleAddRequest model)
        {
            _AspNetUserRoleService.Delete(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
