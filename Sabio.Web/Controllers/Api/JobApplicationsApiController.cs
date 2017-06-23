using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/jobapplications")]
    public class JobApplicationsApiController : ApiController
    {
        public IJobApplicationService _jobApplicationService;
        public INotificationService _notificationService;

        public JobApplicationsApiController(IJobApplicationService jobApplicationService, INotificationService notificationService)
        {
            _jobApplicationService = jobApplicationService;
            _notificationService = notificationService;
        }

        [Route, HttpPost]
        public async Task<HttpResponseMessage> Add(JobApplicationAddRequest model)
        {
            if(!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = _jobApplicationService.Insert(model);
            await _notificationService.NewJobApplication(response.Item);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(JobApplicationUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            _jobApplicationService.Update(model);

            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _jobApplicationService.Delete(id);

            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{jobPostingId:int}/{statusId:int}"), HttpGet]
        public HttpResponseMessage SelectByStatusId(int jobPostingId, int statusId)
        {
            ItemsResponse<JobApplicationEmployer> response = new ItemsResponse<JobApplicationEmployer>();
            response.Items = _jobApplicationService.SelectByStatusId(jobPostingId, statusId);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectByPersonId(int id)
        {
            ItemsResponse<JobApplicationUser> response = new ItemsResponse<JobApplicationUser>();
            response.Items = _jobApplicationService.SelectByPersonId(id);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("statuses"), HttpGet]
        public HttpResponseMessage SelectAllStatuses()
        {
            ItemsResponse<JobApplicationStatus> response = new ItemsResponse<JobApplicationStatus>();
            response.Items = _jobApplicationService.SelectAllStatuses();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
