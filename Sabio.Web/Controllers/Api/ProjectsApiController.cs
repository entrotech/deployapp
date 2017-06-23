using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Sabio.Web.Models.Responses;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests;
using Sabio.Web.Domain;
using Sabio.Web.Models;

namespace Sabio.Web.Controllers.Api
{
    namespace Sabio.Web.Controllers.Api
    {
        [RoutePrefix("api/projects")]
        public class ProjectsApiController : ApiController
        {
            IProjectsService _projectService = null;
            public ProjectsApiController(IProjectsService projectService)
            {
                _projectService = projectService;
            }

            [Route, HttpPost]
            public HttpResponseMessage Post(ProjectsAddRequest model)
            {
                if (!ModelState.IsValid)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
                }
                ItemResponse<int> response = new ItemResponse<int>();
                response.Item = _projectService.Post(model);
                return Request.CreateResponse(HttpStatusCode.OK, response);
            }

           [Route("{id:int}"), HttpPut]
            public HttpResponseMessage Put(ProjectsUpdateRequest model)
            {
                if (!ModelState.IsValid)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
                }
                _projectService.Update(model);
                SuccessResponse response = new SuccessResponse();
                return Request.CreateResponse(HttpStatusCode.OK, response);
            }

            [Route("company/{id:int}"), HttpGet]
            public HttpResponseMessage SelectByCompanyId(int id)
            {
                
                ItemsResponse<Project> response = new ItemsResponse<Project>();
                response.Items = _projectService.SelectProjectByCompanyId(id);
                return Request.CreateResponse(HttpStatusCode.OK, response);
            }

            [Route("{id:int}"), HttpGet]
            public HttpResponseMessage SelectById(int id)
            {

                ItemResponse<Project> response = new ItemResponse<Project>();
                response.Item = _projectService.SelectById(id);
                return Request.CreateResponse(HttpStatusCode.OK, response);
            }

            [Route, HttpGet]
            public HttpResponseMessage SelectAll()
            {
                ItemsResponse<Project> response = new ItemsResponse<Project>();

                response.Items = _projectService.SelectAll();

                return Request.CreateResponse(HttpStatusCode.OK, response);
            }

            [Route("{id:int}"), HttpDelete]
            public HttpResponseMessage Delete(int id)
            {
                _projectService.Delete(id);
                SuccessResponse response = new SuccessResponse();
                return Request.CreateResponse(HttpStatusCode.OK, response);
            }

            //SEARCH

            //[Route("personSearch"), HttpGet]
            //public HttpResponseMessage PersonSearch([FromUri]ProjectPersonSearchRequest model)
            //{
            //    List<PersonBase> person = _projectService.PersonSearch(model);
            //    ItemsResponse<PersonBase>
            //        response = new ItemsResponse<PersonBase>();
            //    response.Items = person;

            //    return Request.CreateResponse(HttpStatusCode.OK, response);
            //}
        }
    }
}
