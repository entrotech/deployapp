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

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/squadmembers")]
    public class SquadMembersApiController : ApiController
    {
        [Route, HttpPost]
        public HttpResponseMessage Add(SquadMemberAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = SquadMemberService.Add(model);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage  Update(SquadMemberUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            SquadMemberService.Update(model);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            ItemResponse<SquadMember> response = new ItemResponse<SquadMember>();
            response.Item = SquadMemberService.SelectById(id);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            ItemsResponse<SquadMember> response = new ItemsResponse<SquadMember>();
            response.Items = SquadMemberService.SelectAll();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }


        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            SquadMemberService.Delete(id);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
