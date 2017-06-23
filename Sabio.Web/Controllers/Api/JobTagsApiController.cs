using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
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
    [RoutePrefix("api/jobtags")]
    public class JobTagsApiController : ApiController
    {
        public IJobTagService _jobTagService;

        public JobTagsApiController(IJobTagService jobTagService)
        {
            _jobTagService = jobTagService;
        }

        [Route, HttpPost]
        public HttpResponseMessage Add(JobTagAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<int> response = new ItemResponse<int>();

            response.Item = _jobTagService.Insert(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(JobTagUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            _jobTagService.Update(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {

            ItemResponse<JobTag> response = new ItemResponse<JobTag>();

            response.Item = _jobTagService.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {

            ItemsResponse<JobTag> response = new ItemsResponse<JobTag>();

            response.Items = _jobTagService.SelectAll();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _jobTagService.Delete(id);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
