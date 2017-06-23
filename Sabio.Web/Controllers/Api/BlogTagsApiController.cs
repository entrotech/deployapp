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
    [RoutePrefix("api/blogtags")]
    public class BlogTagsApiController : ApiController
    {
        [Route, HttpPost]
        public HttpResponseMessage Add(BlogTagAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<int> response = new ItemResponse<int>();

            response.Item = BlogTagService.Insert(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(BlogTagUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            BlogTagService.Update(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {

            ItemResponse<BlogTag> response = new ItemResponse<BlogTag>();

            response.Item = BlogTagService.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("search"), HttpGet]
        public HttpResponseMessage SelectById([FromUri] string searchString)
        {

            ItemsResponse<BlogTag> response = new ItemsResponse<BlogTag>();

            response.Items = BlogTagService.search(searchString);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {

            ItemsResponse<BlogTag> response = new ItemsResponse<BlogTag>();

            response.Items = BlogTagService.SelectAll();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            BlogTagService.Delete(id);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}

