using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api.ServiceBranchesAPI
{

    [RoutePrefix("api/ServiceBranches")]
    public class ServiceBranchesAPIController : ApiController
    {
        private IServiceBranchService _branch= null; 
             public ServiceBranchesAPIController(IServiceBranchService serviceBranchService)
        {
            _branch = serviceBranchService;
        }
       
        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
           
            ItemResponse<ServiceBranch> response = new ItemResponse<ServiceBranch>();

            response.Item = _branch.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
      [Route()]  [HttpGet]
        public HttpResponseMessage SelectAll()
        {
           
            ItemsResponse<ServiceBranch> response = new ItemsResponse<ServiceBranch>();

            response.Items = _branch.SelectAll();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route, HttpPost]
        public HttpResponseMessage Add(ServiceBranchAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<int> response = new ItemResponse<int>();

            response.Item = _branch.Insert(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage delete(int id)
        {
            ItemsResponse<int> response = new ItemsResponse<int>();

           _branch.delete(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(ServiceBranchUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

         _branch.Update(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("Rank"), HttpGet]
        public HttpResponseMessage Search([FromUri]Branch model)
        {
            List<Rank> ranks = _branch.GetRankByService(model);
            ItemsResponse<Rank> response = new ItemsResponse<Rank>();
            response.Items = ranks;

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
 