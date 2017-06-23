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
    [RoutePrefix("api/jobpostingsjobtags")]
    public class JobPostingsJobTagsApiController : ApiController
    {
        public IJobPostingJobTagService _jobPostingJobTagService;

        public JobPostingsJobTagsApiController(IJobPostingJobTagService jobPostingJobTagService)
        {
            _jobPostingJobTagService = jobPostingJobTagService;
        }

        [Route("jobposting/{id:int}"), HttpGet]
        public HttpResponseMessage SelectJobTagsByJobPosting(int id)
        {
            ItemsResponse<JobTag> response = new ItemsResponse<JobTag>();

            response.Items = _jobPostingJobTagService.SelectJobTags(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("jobtag/{id:int}"), HttpGet]
        public HttpResponseMessage SelectJobPostingsByJobTag(int id)
        {
            ItemsResponse<JobPosting> response = new ItemsResponse<JobPosting>();

            response.Items = _jobPostingJobTagService.SelectJobPostings(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }   
}

