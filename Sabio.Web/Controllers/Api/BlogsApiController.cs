using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using Sabio.Web.Models.Responses;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Sabio.Web.Domain;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/blogs")]
    public class BlogsApiController : ApiController
    {
        IBlogService _blogService = null;
        public BlogsApiController(IBlogService blogService)
        {
            _blogService = blogService;
        }

        [Route, HttpPost]
        public HttpResponseMessage Create(BlogAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = _blogService.Insert(model);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Edit(BlogUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            _blogService.Update(model);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            ItemResponse<Blog> response = new ItemResponse<Blog>();
            response.Item = _blogService.SelectById(id);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _blogService.Delete(id);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route(), HttpGet]
        public HttpResponseMessage SelectAll()
        {
            ItemsResponse<Blog> response = new ItemsResponse<Blog>();
            response.Items = _blogService.SelectAll();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("user"), HttpGet]
        public HttpResponseMessage SelectAllByUserId()
        {
            ItemsResponse<Blog> response = new ItemsResponse<Blog>();
           
            response.Items = _blogService.SelectAllByUserId();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("search")][HttpGet]
        public HttpResponseMessage Search([FromUri]string searchStr)
        {
            ItemsResponse<Blog> response = new ItemsResponse<Blog>();
            response.Items = _blogService.Search(searchStr);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }


    }
}
