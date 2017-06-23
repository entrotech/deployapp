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
    [RoutePrefix("api/languages")]  // square bracs are called "attributes"
    public class LanguagesApiController : ApiController
    {
        public ILanguageService _languageservice = null;
       
        public LanguagesApiController(ILanguageService languageservice)
        {
            _languageservice = languageservice;
        }

        [Route, HttpPost]
        public HttpResponseMessage Add(LanguageAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = _languageservice.Insert(model);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(LanguageUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
            _languageservice.Update(model);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            ItemResponse<Language> response = new ItemResponse<Language>();

            response.Item = _languageservice.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route/*("")*/, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            ItemsResponse<Language> response = new ItemsResponse<Language>();

            response.Items = _languageservice.SelectAll();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _languageservice.Delete(id);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}