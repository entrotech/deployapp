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
    [RoutePrefix("api/companies")]
    public class CompanyApiController : ApiController
    {
        private ICompanyService _company = null;

        public CompanyApiController(ICompanyService companyService)
        {
            _company = companyService;
        }
        [Route, HttpPost]
        public HttpResponseMessage Insert(CompanyAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = _company.Insert(model);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<Company> response = new ItemResponse<Company>();

            response.Item = _company.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            //ItemsResponse<Company> response = new ItemsResponse<Company>();
            //var response =
            //    _company.SelectAll()
            //    .ToDictionary(c => c.Id);

            ItemsResponse<Company> response = new ItemsResponse<Company>();
            response.Items = _company.SelectAll();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(CompanyUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            _company.Update(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _company.Delete(id);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("search"), HttpGet]
        public HttpResponseMessage Search([FromUri]string searchString)
        {
            ItemsResponse<Company> response = new ItemsResponse<Company>();
            response.Items = _company.Search(searchString);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
