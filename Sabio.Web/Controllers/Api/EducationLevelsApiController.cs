using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/educationlevels")]
    public class EducationLevelsApiController : ApiController
    {
        private IEducationLevelService _educationLevelService = null;
        public EducationLevelsApiController(IEducationLevelService educationLevelService)
        {
            _educationLevelService = educationLevelService;
        }

        //POST
        [Route, HttpPost]
        public HttpResponseMessage Add(EducationLevelAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = _educationLevelService.Add(model);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        //PUT
        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(EducationLevelUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            _educationLevelService.Update(model);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        //SELECT BY ID
        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            ItemResponse<EducationLevel> response = new ItemResponse<EducationLevel>();
            response.Item = _educationLevelService.SelectById(id);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        //SELECT ALL
        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            ItemsResponse<EducationLevel> response = new ItemsResponse<EducationLevel>();
            response.Items = _educationLevelService.SelectAll();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        //DELETE
        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _educationLevelService.Delete(id);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}