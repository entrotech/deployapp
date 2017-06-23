using Sabio.Web.Domain;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/projectpersonstatus")]
    public class ProjectPersonStatusApiController : ApiController
    {
        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            ItemsResponse<ProjectPersonStatus> response = new ItemsResponse<ProjectPersonStatus>();
            response.Items = ProjectPersonStatusService.SelectAll();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
