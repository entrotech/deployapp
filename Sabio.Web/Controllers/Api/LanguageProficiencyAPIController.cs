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
    [RoutePrefix("api/languageproficiency")]
    public class LanguageProficiencyAPIController : ApiController
    {
        [Route, HttpPost]
        public HttpResponseMessage Add(LanguageProficiencyAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
            ItemResponse<int> _response = new ItemResponse<int>();
            _response.Item = LanguageProficiencyService.Insert(model);
            return Request.CreateResponse(HttpStatusCode.OK, _response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(LanguageProficiencyUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
            LanguageProficiencyService.Update(model);
            SuccessResponse _response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, _response);
        }

        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            ItemResponse<LanguageProficiency> _response = new ItemResponse<LanguageProficiency>();

            _response.Item = LanguageProficiencyService.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, _response);
        }

        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            ItemsResponse<LanguageProficiency> response = new ItemsResponse<LanguageProficiency>();

            response.Items = LanguageProficiencyService.SelectAll();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            LanguageProficiencyService.Delete(id);

            SuccessResponse _response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, _response);
        }
    }
}
    
