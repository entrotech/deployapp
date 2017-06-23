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
    [RoutePrefix("api/squadmemberstatus")]
    public class SquadMeberStatusApiController : ApiController
    {

        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            ItemsResponse<SquadMemberStatus> response = new ItemsResponse<SquadMemberStatus>();
            response.Items = SquadMemberStatusService.SelectAll();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

    }
}
