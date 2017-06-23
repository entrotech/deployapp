using Sabio.Web.Domain;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/calendar")]
    public class CalendarApiController : ApiController
    {
        [Route, HttpGet]
        public HttpResponseMessage SelectEventBySquadMember()
        {
            ItemsResponse<SquadMemberEvent> response = new ItemsResponse<SquadMemberEvent>();

            response.Items = SquadMemberEventService.SelectAll();

            if (response.Items == null)
            {
                return Request.CreateResponse(HttpStatusCode.NoContent);
            }

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
