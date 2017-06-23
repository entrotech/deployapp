using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
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
    [RoutePrefix("api/homestatistics")]
    public class HomeStatisticsApiController : ApiController
    {
        IHomeStatisticsService _homeStatisticsService = null;

        public HomeStatisticsApiController(IHomeStatisticsService homeStatisticsService)
        {
            _homeStatisticsService = homeStatisticsService;
        }

        [Route, HttpPut]
        public HttpResponseMessage Update(HomeStatisticsUpdateRequest model)
        {
            if(!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, model);
            }

            _homeStatisticsService.Update(model);

            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpGet]
        public HttpResponseMessage GetAll()
        {
            ItemsResponse<HomeStatistic> response = new ItemsResponse<HomeStatistic>();
            response.Items = _homeStatisticsService.SelectAll();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
