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
    [RoutePrefix("api/exceptions")]
    public class ExceptionLogApiController : ApiController
    {
        [Route, HttpGet]
        public HttpResponseMessage GetAll()
        {
            int resultCount = 0;
            SearchResponse<Domain.Exception> response = new SearchResponse<Domain.Exception>();
            response.Items = ExceptionLoggingService.SelectAll(out resultCount);
            response.ResultCount = resultCount;
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("search"), HttpGet]
        public HttpResponseMessage Search([FromUri] ExceptionSearchRequest model)
        {
            if(!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            int resultCount = 0;
            SearchResponse<Domain.Exception> response = new SearchResponse<Domain.Exception>();
            response.Items = ExceptionLoggingService.Search(model, out resultCount);
            response.ResultCount = resultCount;
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
