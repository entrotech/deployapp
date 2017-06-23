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
    [RoutePrefix("api/geography")]
    public class GeographyApiController : ApiController
    {
        [Route("countries"), HttpGet]
        public HttpResponseMessage SelectAllCountries()
        {
            ItemsResponse<Country> response = new ItemsResponse<Country>();

            response.Items = GeographyService.SelectAllCountries();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("stateprovinces"), HttpGet]
        public HttpResponseMessage SelectAllStateProvinces()
        {
            ItemsResponse<StateProvince> response = new ItemsResponse<StateProvince>();

            response.Items = GeographyService.SelectAllStateProvinces();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("stateprovinces/{id:int}"), HttpGet]
        public HttpResponseMessage SelectStateProvinceByCountryId(int id)
        {

            ItemsResponse<StateProvince> response = new ItemsResponse<StateProvince>();

            response.Items = GeographyService.SelectStateProvinceByCountryId(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
