using Sabio.Web.Domain;
using Sabio.Web.Models;
using Sabio.Web.Models.Request;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using Sabio.Web.Services;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/proposals")]
    public class ProposalsApiController : ApiController

    {
        private IEmailService _emailService = null;

        public ProposalsApiController(IEmailService emailService)
        {
            _emailService = emailService;
        }

        [Route, HttpPost]
        public HttpResponseMessage Post(ProposalAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = ProposalService.Post(model);
            ProposalSendRequest sendRequest = new ProposalSendRequest();
            sendRequest.FirstName = model.FirstName;
            sendRequest.LastName = model.LastName;
            sendRequest.Email = model.Email;
            sendRequest.PhoneNumber = model.PhoneNumber;
            sendRequest.Deadline = model.Deadline;
            sendRequest.Budget = model.Budget;
            sendRequest.Company = model.Company;
            sendRequest.ProjectType = model.ProjectType;
            sendRequest.Description = model.Description;

            _emailService.SendProposalAdmin(sendRequest);
            ProposalSendRequest userRequest = new ProposalSendRequest();
            userRequest.FirstName = model.FirstName;
            userRequest.LastName = model.LastName;
            userRequest.Email = model.Email;
            _emailService.SendProposalUser(userRequest);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Put(ProposalUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            ItemResponse<int?> response = new ItemResponse<int?>();
            response.Item = ProposalService.Update(model);
           
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("Search"), HttpGet]
        public HttpResponseMessage Search([FromUri]ProposalSearchRequest model)
        {
            ItemsResponse<Proposal> response = new ItemsResponse<Proposal>();
            response.Items = ProposalService.Search(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            ItemResponse<Proposal> response = new ItemResponse<Proposal>();
            response.Item = ProposalService.SelectById(id);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            ItemsResponse<Proposal> response = new ItemsResponse<Proposal>();

            response.Items = ProposalService.SelectAll();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            ProposalService.Delete(id);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}