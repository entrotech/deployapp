using Sabio.Web.Domain;
using Sabio.Web.Models.Request;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using Sabio.Web.Services;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/emails")]
    public class EmailsApiController : ApiController
    {
        private IEmailService _emailService = null;
        public EmailsApiController(IEmailService emailService)
        {
            _emailService = emailService;
        }
    
        // GET 
        [Route("send")]
        [HttpPost]
        public async Task<HttpResponseMessage> Send(ContactUsAddRequest model)
        {
            bool success = await _emailService.SendContactUs(model);
            ContactRequestService.Insert(model);
            return Request.CreateResponse(HttpStatusCode.OK, new SuccessResponse());
        }

        // ADD 
        [Route, HttpPost]
        public HttpResponseMessage Add(ContactUsAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<int> response = new ItemResponse<int>();

            response.Item = ContactRequestService.Insert(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        // GET BY ID
        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            ItemResponse<ContactRequest> response = new ItemResponse<ContactRequest>();

            response.Item = ContactRequestService.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        // GET ALL 
        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            List<ContactRequest> list = ContactRequestService.SelectAll();
            ItemsResponse<ContactRequest> response = new ItemsResponse<ContactRequest>()
            {
                Items = list
            };

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        // UPDATE 
        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(ContactRequestUpdateRequest model, int id)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ContactRequestService.Update(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        // SEARCH 
        [Route("search"), HttpGet]
        public HttpResponseMessage Search([FromUri]ContactRequestSearchRequest model)
        {
            int rows = 0;
            List<ContactRequest> contactRequests = ContactRequestService.Search(model, out rows);
            SearchResponse<ContactRequest>
                response = new SearchResponse<ContactRequest>();
            response.Items = contactRequests;
            response.ResultCount = rows;

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

    }


}