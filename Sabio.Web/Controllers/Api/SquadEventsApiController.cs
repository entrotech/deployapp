using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Sabio.Web.Requests;
using Sabio.Web.Services;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/SquadEvents")]
    public class SquadEventsApiController : ApiController
    {
        public ISquadEventService _squadEventService;
        public INotificationService _notificationService;

        public SquadEventsApiController(ISquadEventService squadEventService, INotificationService notificationService)
        {
            _squadEventService = squadEventService;
            _notificationService = notificationService;
        }

        [Route, HttpPost]
        public HttpResponseMessage Add(SquadEventAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = _squadEventService.Insert(model);
            _notificationService.SquadEvent(response.Item, Enums.EventActionType.Created);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(SquadEventUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            _squadEventService.Update(model);
            _notificationService.SquadEvent(model.Id, Enums.EventActionType.Modified);

            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            if(!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<SquadEvent> response = new ItemResponse<SquadEvent>();

            response.Item = _squadEventService.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{squadId:int}/squad"), HttpGet]
        public HttpResponseMessage SelectBySquadId(int squadId)
        {

            ItemsResponse<SquadEvent> response = new ItemsResponse<SquadEvent>();

            response.Items = _squadEventService.SelectBySquadId(squadId);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            ItemsResponse<SquadEvent> response = new ItemsResponse<SquadEvent>();

            response.Items = _squadEventService.SelectAll();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _squadEventService.Delete(id);
            _notificationService.SquadEvent(id, Enums.EventActionType.Cancelled);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("search"), HttpGet]
        public HttpResponseMessage SquadEventSearch([FromUri]SquadEventSearchRequest model)
        {
            int rows = 0;
            List<SquadEvent> squadEvents = _squadEventService.SquadEventSearch(model, out rows);
            SearchResponse<SquadEvent>
                response = new SearchResponse<SquadEvent>();
            response.Items = squadEvents;
            response.ResultCount = rows;

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }


}
