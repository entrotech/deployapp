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
    [RoutePrefix("api/contactusers")]
    public class ContactUsersApiController : ApiController
    {
        IContactUsersService _contactUsersService = null;

        public ContactUsersApiController(IContactUsersService contactUsersService)
        {
            _contactUsersService = contactUsersService;
        }

        [Route, HttpPost]
        public HttpResponseMessage Send(UsersEmailSendRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            _contactUsersService.Send(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route, HttpGet]
        public HttpResponseMessage GetUserRoles()
        {
            ItemsResponse<UserRole> response = new ItemsResponse<UserRole>();

            response.Items = _contactUsersService.GetUserRoles();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
