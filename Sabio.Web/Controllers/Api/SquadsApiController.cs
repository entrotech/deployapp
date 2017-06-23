using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Sabio.Web.Domain;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using System.Web.Http.ModelBinding;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests.Interfaces;
using Sabio.Web.Models;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/squads")]
    public class SquadsApiController : ApiController
    {

        private ISquadService _squadService = null;
        private IPersonService _personService = null;
            public SquadsApiController(ISquadService squadService, IPersonService personService)
        {
            _squadService = squadService;
            _personService = personService;
        }

        // ADD 
        [Route, HttpPost]
        public HttpResponseMessage Add(SquadAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            ItemResponse<int> response = new ItemResponse<int>();

            response.Item = _squadService.Insert(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        // UPDATE 
        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(SquadUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            _squadService.Update(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        } 

        // GET BY ID
        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            ItemResponse<Squad> response = new ItemResponse<Squad>();

            response.Item = _squadService.SelectById(id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        // GET ALL 
        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            List<Squad> squads = _squadService.SelectAll();
            ItemsResponse<Squad>
                response = new ItemsResponse<Squad>();
            response.Items = squads;

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        // SEARCH 
        [Route("search"), HttpGet]
        public HttpResponseMessage Search([FromUri]SquadSearchRequest model) 
        {
            List<Squad> squads = _squadService.Search(model);
            SearchResponse<Squad>
                response = new SearchResponse<Squad>();
            response.Items = squads;

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("PersonSearch"), HttpGet]
        public HttpResponseMessage PersonSearch([FromUri]PersonSearchRequest model)
        {
            int rows = 0;
            List<PersonBase> persons = _personService.PersonBaseSearch(model, out rows);
            SearchResponse<PersonBase>
                response = new SearchResponse<PersonBase>();
            response.Items = persons;
            response.ResultCount = rows;

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        // DELETE
        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _squadService.Delete(id);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        
    }
}
