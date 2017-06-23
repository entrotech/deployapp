using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/faqs")]
    public class FaqsApiController : ApiController
    {
        private IFaqService _faqService = null;
        public FaqsApiController(IFaqService faqService)
        {
            _faqService = faqService;
        }
        [Route, HttpPost]
        public HttpResponseMessage AddFaq(FaqAddRequest model)
        {
            if (!ModelState.IsValid && model != null)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<int> response = new ItemResponse<int>();

            response.Item = _faqService.Insert(model);

            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Put(FaqUpdateRequest model)
        {
            if (!ModelState.IsValid && model != null)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
            _faqService.Update(model);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        [Route, HttpGet]
        public HttpResponseMessage SelectAll([FromUri]ItemsRequest<int> model)
        {
            ItemsResponse<Faq> response = new ItemsResponse<Faq>();
            response.Items = _faqService.SelectAll();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        
        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectbyId(int id)
        {
            ItemResponse<Faq> response = new ItemResponse<Faq>();
            response.Item = _faqService.SelectById(id);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        // DELETE: api/faqs/5
        [Route("{Id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int Id)
        {
            _faqService.Delete(Id);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, new SuccessResponse());
        }
    }
}