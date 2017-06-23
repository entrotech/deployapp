using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Sabio.Web.Domain;
using Sabio.Web.Enums;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Web;
using System.Web.Http;
using System.Xml;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/jobpostings")]
    public class JobPostingsApiController : ApiController
    {
        public IJobPostingService _jobPostingService;

        public JobPostingsApiController(IJobPostingService jobPostingService)
        {
            _jobPostingService = jobPostingService;
        }

        [Route, HttpPost]
        public HttpResponseMessage Add(JobPostingAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<int> response = new ItemResponse<int>();

            response.Item = _jobPostingService.Insert(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(JobPostingUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            _jobPostingService.Update(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {

            ItemResponse<JobPosting> response = new ItemResponse<JobPosting>();

            response.Item = _jobPostingService.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route(), HttpGet]
        public HttpResponseMessage SelectAll()
        {

            ItemsResponse<JobPosting> response = new ItemsResponse<JobPosting>();

            response.Items = _jobPostingService.SelectAll();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("search"), HttpGet]
        public HttpResponseMessage SearchByKeyword([FromUri]JobPostingSearchRequest searchRequest)
        {
            ItemsResponse<JobPosting> response = new ItemsResponse<JobPosting>();
            response.Items = _jobPostingService.SearchByKeyword(searchRequest);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("indeedsearch"), HttpGet]
        public HttpResponseMessage IndeedSearch([FromUri] JobPostingIndeedSearchRequest searchRequest)
        {
            var requestArray = new List<string>();
            foreach (PropertyDescriptor property in TypeDescriptor.GetProperties(searchRequest))
            {
                requestArray.Add(HttpUtility.UrlEncode(property.Name) + "=" + HttpUtility.UrlEncode(Convert.ToString(property.GetValue(searchRequest))));
            }

            string encodedParameters = string.Join("&", requestArray);

            string url = "http://api.indeed.com/ads/apisearch?" + encodedParameters;

            string str = "";

            using (WebClient client = new WebClient())
            {
                str = client.DownloadString(url);
            }

            JObject results = JObject.Parse(str);

            ItemResponse<JObject> response = new ItemResponse<JObject>();

            response.Item = results;

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        //[Route("monstersearch"), HttpGet]
        //public HttpResponseMessage MonsterSearch([FromUri] JobPostingMonsterSearchRequest searchRequest)
        //{
        //    var requestArray = new List<string>();
        //    foreach (PropertyDescriptor property in TypeDescriptor.GetProperties(searchRequest))
        //    {
        //        requestArray.Add(HttpUtility.UrlEncode(property.Name) + "=" + HttpUtility.UrlEncode(Convert.ToString(property.GetValue(searchRequest))));
        //    }

        //    string encodedParameters = string.Join("&", requestArray);

        //    string url = "http://jsx.monster.com/query.ashx?" + encodedParameters;

        //    string str = "";

        //    using (WebClient client = new WebClient())
        //    {
        //        str = client.DownloadString(url);
        //    }

        //    XmlDocument xml = new XmlDocument();
        //    xml.LoadXml(str);
        //    string jsonText = JsonConvert.SerializeXmlNode(xml);
        //    JObject results = JObject.Parse(jsonText);

        //    ItemResponse<JObject> response = new ItemResponse<JObject>();

        //    response.Item = results;

        //    return Request.CreateResponse(HttpStatusCode.OK, response);
        //}
        [Route("usajobssearch"), HttpGet]
        public HttpResponseMessage UsaJobsSearch([FromUri] JobPostingUsaJobsSearchRequest searchRequest)
        {
            var requestArray = new List<string>();
            foreach (PropertyDescriptor property in TypeDescriptor.GetProperties(searchRequest))
            {
                requestArray.Add(HttpUtility.UrlEncode(property.Name) + "=" + HttpUtility.UrlEncode(Convert.ToString(property.GetValue(searchRequest))));
            }

            string encodedParameters = string.Join("&", requestArray);

            string url = "https://data.usajobs.gov/api/Search?" + encodedParameters;

            string str = "";

            using (WebClient client = new WebClient())
            {
                client.Headers.Add("Host", "data.usajobs.gov");
                client.Headers.Add("User-Agent", "Philip.percesepe@hotmail.com");
                client.Headers.Add("Authorization-Key", "/tK6Wr1r5rlHWHs1b3DIzWaRtwe/49Wlo8/GhS4yTDA=");
                str = client.DownloadString(url);
            }

            JObject results = JObject.Parse(str);

            ItemResponse<JObject> response = new ItemResponse<JObject>();

            response.Item = results;

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _jobPostingService.Delete(id);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("clicklog/{engineId:int}"), HttpPost]
        public HttpResponseMessage Add(int engineId)
        {
            JobSearchEngine jobSearchEngine = (JobSearchEngine)engineId;
            _jobPostingService.ClickLog(jobSearchEngine);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
