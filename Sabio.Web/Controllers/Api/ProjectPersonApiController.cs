using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/projectperson")]
    public class ProjectPersonApiController : ApiController
    {
        [Route, HttpPost]
        public HttpResponseMessage Post(ProjectPersonAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            SuccessResponse response = new SuccessResponse();
            ProjectPersonService.Post(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpPut]
        public HttpResponseMessage Put(ProjectPersonAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            SuccessResponse response = new SuccessResponse();
            ProjectPersonService.Update(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{personId:int}"), HttpGet]
        public HttpResponseMessage SelectByPersonId(int personId)
        {

            ItemsResponse<ProjectPersonBase> response = new ItemsResponse<ProjectPersonBase>();
            response.Items = ProjectPersonService.SelectByPersonId(personId);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
