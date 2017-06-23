using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using Sabio.Web.Requests.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/testimonials")]
    public class TestimonialsApiController : ApiController
    {
        private ITestimonialService _testimonial = null;

        public TestimonialsApiController(ITestimonialService testimonialService)
        {
            _testimonial = testimonialService;
        }

        [Route, HttpPost]
        public HttpResponseMessage Post(TestimonialAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = _testimonial.Post(model);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Put(TestimonialUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            _testimonial.Update(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            ItemResponse<Testimonial> response = new ItemResponse<Testimonial>();

            response.Item = _testimonial.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            ItemsResponse<Testimonial> response = new ItemsResponse<Testimonial>();
            response.Items = _testimonial.SelectAll();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _testimonial.Delete(id);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("Search"), HttpGet]
        public HttpResponseMessage Search([FromUri]TestimonialSearchRequest model)
        {
            ItemsResponse<Testimonial> response = new ItemsResponse<Testimonial>();
            response.Items = _testimonial.Search(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
