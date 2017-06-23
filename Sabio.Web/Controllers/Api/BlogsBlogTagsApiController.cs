using Sabio.Web.Domain;
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
   [RoutePrefix("api/blogsblogtags")]
    public class BlogsBlogTagsApiController : ApiController
    {
        [Route("blogs/{id:int}"), HttpGet]
        public HttpResponseMessage SelectBlogTagByBlog(int id)
        {
            ItemsResponse<BlogTag> response = new ItemsResponse<BlogTag>();

            response.Items = BlogBlogTagService.SelectBlogTags(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("blogtags/{id:int}"), HttpGet]
        public HttpResponseMessage SelectBlogByBlogTag(int id)
        {
            ItemsResponse<Blog> response = new ItemsResponse<Blog>();

            response.Items = BlogBlogTagService.SelectBlogs(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }   
}


