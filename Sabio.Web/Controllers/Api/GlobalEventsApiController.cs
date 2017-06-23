using Sabio.Web.Domain;
using Sabio.Web.Models;
using Sabio.Web.Models.Requests;
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
    [RoutePrefix("api/globalevents")]
    public class GlobalEventsApiController : ApiController
    {
        IGlobalEventService _globalEventService = null;
        INotificationService _notificationService = null;
        public GlobalEventsApiController(IGlobalEventService globalEventService, INotificationService notificationService)
        {
            _globalEventService = globalEventService;
            _notificationService = notificationService;
        }

        [Route, HttpPost]
        public HttpResponseMessage Create(GlobalEventAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<int> response = new ItemResponse<int>();

            response.Item = _globalEventService.Insert(model);
            _notificationService.GlobalEvent(response.Item, Enums.EventActionType.Created);

            return Request.CreateResponse(HttpStatusCode.Created, response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(GlobalEventUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            _globalEventService.Update(model);
            _notificationService.GlobalEvent(model.Id, Enums.EventActionType.Modified);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage ReadById(int id)
        {
            ItemResponse<GlobalEvent> response = new ItemResponse<GlobalEvent>();

            response.Item = _globalEventService.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpGet]
        public HttpResponseMessage ReadAll()
        {
            ItemsResponse<GlobalEvent> response = new ItemsResponse<GlobalEvent>();

            response.Items = _globalEventService.SelectAll();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("c"), HttpGet]
        public HttpResponseMessage ReadAllCalendar()
        {
            ItemsResponse<GlobalEvent> response = new ItemsResponse<GlobalEvent>();

            response.Items = _globalEventService.SelectAllCalendar();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _globalEventService.Delete(id);
            _notificationService.GlobalEvent(id, Enums.EventActionType.Cancelled);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("cancel/{id:int}"), HttpPut]
        public HttpResponseMessage Cancel(int id)
        {
            _globalEventService.Cancel(id);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("radius"), HttpGet]
        public HttpResponseMessage SearchByRadius([FromUri]GlobalEventSearchRadiusRequest model)
        {
            ItemsResponse<GlobalEvent> response = new ItemsResponse<GlobalEvent>();

            response.Items = _globalEventService.SearchByRadius(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("search"), HttpGet]
        public HttpResponseMessage Search([FromUri]GlobalEventSearchRequest model)
        {
            ItemsResponse<GlobalEvent> response = new ItemsResponse<GlobalEvent>();

            response.Items = _globalEventService.Search(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
