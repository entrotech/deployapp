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
    [RoutePrefix("api/companiespeople")]
    public class CompaniesPeopleApiController : ApiController
    {
        private ICompanyPersonService _companyPerson = null;
        private IPersonService _person = null;

        public CompaniesPeopleApiController(ICompanyPersonService companyPersonService, IPersonService personService)
        {
            _companyPerson = companyPersonService;
            _person = personService;
        }

        [Route("{companyId:int}/{personId:int}"), HttpPost]
        public HttpResponseMessage Insert(int CompanyId, int PersonId)
        {
            _companyPerson.Insert(CompanyId, PersonId);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{companyId:int}/{personId:int}"), HttpDelete]
        public HttpResponseMessage Delete(int CompanyId, int PersonId)
        {
            _companyPerson.Delete(CompanyId, PersonId);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{personId:int}"), HttpGet]
        public HttpResponseMessage GetCompanies(int PersonId)
        {
            Person user = _person.PublicSelect(PersonId);
            string AspNetUserId = user.AspNetUserId;
            List<CompanyBase> companies = _companyPerson.GetCompanies(AspNetUserId);

            ItemsResponse<CompanyBase> response = new ItemsResponse<CompanyBase>();
            response.Items = companies;
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
