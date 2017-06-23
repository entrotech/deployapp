using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Sabio.Web.Models.Requests;
using Sabio.Web.Domain;
using Sabio.Data;
using System.Data;
using System.Data.SqlClient;
using Twilio;
using Twilio.Types;
using Twilio.Rest.Api.V2010.Account;
using System.Configuration;
using Sabio.Web.Requests;

namespace Sabio.Web.Services
{
    public class SmsService : BaseService, ISmsService
    {       
        public void SendSms(string phoneNumber, string messageText)
        {
            string accountSid = ConfigurationManager.AppSettings["TwilioAccountSid"];
            string authToken = ConfigurationManager.AppSettings["TwilioAuthToken"];
            TwilioClient.Init(accountSid, authToken);

            var to = new PhoneNumber(phoneNumber);
            var message = MessageResource.Create(
                to,
                from: new PhoneNumber(ConfigurationManager.AppSettings["TwilioPhoneNumber"]),
                body: messageText);

            Console.WriteLine(message.Sid);
        }
    }
}