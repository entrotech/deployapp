using Sabio.Web.Domain;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Twilio.Types;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/smsservice")]
    public class SmsApiController : ApiController
    {
        private ISmsService _smsService = null;
        public SmsApiController(ISmsService smsService)
        {
            _smsService = smsService;
        }
        [Route("{phoneNumber}/{messageText}"), HttpPost]
        public HttpResponseMessage SelectById(string phoneNumber, string messageText)
        {
            _smsService.SendSms(phoneNumber, messageText);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}
