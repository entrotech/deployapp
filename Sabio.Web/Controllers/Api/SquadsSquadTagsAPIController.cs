using Sabio.Web.Domain;
using Sabio.Web.Models.Responses;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/squadssquadTags")]
    public class SquadsSquadTagsAPIController : ApiController
    {
        [Route("squads/{id:int}"), HttpGet]
        public HttpResponseMessage SelectSquadTagBySquad(int id)
        {
            ItemsResponse<SquadTag> res = new ItemsResponse<SquadTag>();
            res.Items = SquadSquadTagService.SelectSquadTags(id);
            return Request.CreateResponse(HttpStatusCode.OK, res);
        }
        [Route("squadTags/{id:int}"), HttpGet]
        public HttpResponseMessage SelectSquadBySquadTag(int id)
        {
            ItemsResponse<Squad> res = new ItemsResponse<Squad>();
            res.Items = SquadSquadTagService.SelectSquads(id);
            return Request.CreateResponse(HttpStatusCode.OK, res);
        }

    }
}
