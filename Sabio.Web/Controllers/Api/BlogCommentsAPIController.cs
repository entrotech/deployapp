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
    [RoutePrefix("api/blogComment")]
    public class BlogCommentsAPIController : ApiController
    {
        [HttpGet][Route("{id:int}")]
        public HttpResponseMessage GetCommentByBlogId(int id) {
            ItemsResponse<BlogComment> res = new ItemsResponse<BlogComment>();
            res.Items = BlogCommentService.SelectById(id);
            return Request.CreateResponse(HttpStatusCode.OK, res);
        }
        [HttpGet]
        [Route("{id:int}/Blog")]
        public HttpResponseMessage SelectAllByBlog(int id)
        {
            ItemsResponse<BlogComment> res = new ItemsResponse<BlogComment>();
            res.Items = BlogCommentService.SelectAll(id);
            return Request.CreateResponse(HttpStatusCode.OK, res);
        }

        [Route, HttpPost]
        public HttpResponseMessage Create(BlogCommentAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = BlogCommentService.Post(model);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Edit(BlogCommentUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            BlogCommentService.Update(model);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            BlogCommentService.Delete(id);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [HttpPut] [Route("{id:int}/approve")]
        public HttpResponseMessage Approve(int id)
        {
            BlogCommentService.ApproveComment(id);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
