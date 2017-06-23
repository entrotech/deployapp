using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/timecardentry")]
    public class TimecardEntryApiController : ApiController
    {
        private ITimecardEntryService _timecardEntry = null;

        public TimecardEntryApiController(ITimecardEntryService timecardEntryService)
        {
            _timecardEntry = timecardEntryService;
        }

        [Route("Search"), HttpGet]
        public HttpResponseMessage Search([FromUri]TimecardEntrySearchRequest model)
        {
            ItemsResponse<TimecardEntry> response = new ItemsResponse<TimecardEntry>();
            response.Items = _timecardEntry.Search(model);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectByProjectId(int Id)
        {
            ItemsResponse<TimecardEntry> response = new ItemsResponse<TimecardEntry>();
            response.Items =  _timecardEntry.SelectByProjectId(Id);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpPost]
        public HttpResponseMessage Post(TimecardEntryAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = _timecardEntry.Insert(model);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Put(TimecardEntryUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            _timecardEntry.Update(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
       
        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _timecardEntry.Delete(id);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
