using Sabio.Data;
using Sabio.Web.Classes;
using Sabio.Web.Domain;
using Sabio.Web.Enums;
using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace Sabio.Web.Services
{
    public class NotificationService : BaseService, INotificationService
    {
        public IEmailService _emailService = null;
        public ISmsService _smsService = null;

        public NotificationService(IEmailService emailService, ISmsService smsService)
        {
            _emailService = emailService;
            _smsService = smsService;
        }

        public async Task NewJobApplication(int applicationId)
        {
            List<PersonNotification> personList = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.PersonNotificationPreference_GetJobApplicationNotifyPeople",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@ApplicationId", applicationId);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           PersonNotification prsn = MapPersonNotification(reader);

                           if (personList == null)
                           {
                               personList = new List<PersonNotification>();
                           }
                           personList.Add(prsn);
                           break;
                   }
               }
               );
            if (personList != null)
            {
                string url = System.Web.Configuration.WebConfigurationManager.AppSettings["BaseUrl"] + "/jobpostings/" + personList[0].LinkId + "/edit";
                string emailTitle = "New Application";
                string emailMainMessage = "Your Job Posting has received a new application";
                string emailPleaseClickMessage = "Click the link below to view and manage applications";
                string emailSubject = "Your Job Posting has received a new application";
                string emailMessageText = "Click the following link to view and manage applications: " + url;
                string smsMessageText = "Your Job Posting on Deploy has received a new application! Click the following link to view and manage applications: " + url;

                await SendMessages(personList, url, emailTitle, emailMainMessage, emailPleaseClickMessage, emailSubject, emailMessageText, smsMessageText);
            }
        }
        public async Task GlobalEvent(int eventId, EventActionType eventActionType)
        {
            List<PersonNotification> personList = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.PersonNotificationPreference_GetGlobalEventNotificationPeople",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@EventActionTypeId", (int)eventActionType);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           PersonNotification prsn = MapPersonNotification(reader);

                           if (personList == null)
                           {
                               personList = new List<PersonNotification>();
                           }
                           personList.Add(prsn);
                           break;
                   }
               }
               );
            string eventActionString = String.Empty;
            switch (eventActionType)
            {
                case EventActionType.Created:
                    eventActionString = "created";
                    break;
                case EventActionType.Modified:
                    eventActionString = "modified";
                    break;
                case EventActionType.Cancelled:
                    eventActionString = "cancelled";
                    break;
            }
            if (personList != null)
            {
                string url = System.Web.Configuration.WebConfigurationManager.AppSettings["BaseUrl"] + "/globalevents/" + eventId;
                string emailTitle = "Global event news";
                string emailMainMessage = "An Operation Code event has been " + eventActionString;
                string emailPleaseClickMessage = "Click the link below to view event details";
                string emailSubject = "A Global Event has been " + eventActionString;
                string emailMessageText = "Click the following link to view event details: " + url;
                string smsMessageText = "An Operation Code event has been " + eventActionString + "! Click the following link to view event details: " + url;

                await SendMessages(personList, url, emailTitle, emailMainMessage, emailPleaseClickMessage, emailSubject, emailMessageText, smsMessageText);
            }
        }
        public async Task SquadEvent(int eventId, EventActionType eventActionType)
        {
            List<PersonNotification> personList = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.PersonNotificationPreference_GetSquadEventNotificationPeople",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@EventActionTypeId", (int)eventActionType);
                   paramCollection.AddWithValue("@EventId", eventId);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           PersonNotification prsn = MapPersonNotification(reader);

                           if (personList == null)
                           {
                               personList = new List<PersonNotification>();
                           }
                           personList.Add(prsn);
                           break;
                   }
               }
               );
            string eventActionString = String.Empty;
            switch (eventActionType)
            {
                case EventActionType.Created:
                    eventActionString = "created";
                    break;
                case EventActionType.Modified:
                    eventActionString = "modified";
                    break;
                case EventActionType.Cancelled:
                    eventActionString = "cancelled";
                    break;
            }
            if (personList != null)
            {
                string url = System.Web.Configuration.WebConfigurationManager.AppSettings["BaseUrl"] + "/eventdetails/" + eventId;
                string emailTitle = personList[0].GroupName + " squad event news";
                string emailMainMessage = "An event for the " + personList[0].GroupName + " squad has been " + eventActionString;
                string emailPleaseClickMessage = "Click the link below to view event details";
                string emailSubject = "A Squad Event has been " + eventActionString;
                string emailMessageText = "Click the following link to view event details: " + url;
                string smsMessageText = "An event for the " + personList[0].GroupName + " squad has been " + eventActionString + "! Click the following link to view event details: " + url;

                await SendMessages(personList, url, emailTitle, emailMainMessage, emailPleaseClickMessage, emailSubject, emailMessageText, smsMessageText);
            }
        }

        private static PersonNotification MapPersonNotification(IDataReader reader)
        {
            PersonNotification prsn = new PersonNotification();
            int ord = 0;

            prsn.Id = reader.GetSafeInt32(ord++);
            prsn.FirstName = reader.GetSafeString(ord++);
            prsn.MiddleName = reader.GetSafeString(ord++);
            prsn.LastName = reader.GetSafeString(ord++);
            prsn.PhoneNumber = reader.GetSafeString(ord++);
            prsn.Email = reader.GetSafeString(ord++);
            prsn.SendEmail = reader.GetSafeBool(ord++);
            prsn.SendText = reader.GetSafeBool(ord++);
            prsn.LinkId = reader.GetSafeInt32(ord++);
            prsn.GroupName = reader.GetSafeString(ord++);
            return prsn;
        }

        private async Task SendMessages(List<PersonNotification> personList, string url, string emailTitle, string emailMainMessage, string emailPleaseClickMessage, string emailSubject, string emailMessageText, string smsMessageText)
        {
            foreach (PersonNotification prsn in personList)
            {
                if (prsn.SendEmail)
                {
                    string path = HttpContext.Current.Server.MapPath("~/HTML_Templates/EventNotificationEmail.html");
                    string emailBody = System.IO.File.ReadAllText(path);
                    string finalEmailHtml = emailBody.Replace("{{emailTitle}}", emailTitle)
                                                .Replace("{{mainMessage}}", emailMainMessage)
                                                .Replace("{{pleaseClickMessage}}", emailPleaseClickMessage)
                                                .Replace("{{url}}", url);
                    string subject = emailSubject;
                    string messageText = emailMessageText;

                    await _emailService.Send(SiteConfig.SiteAdminEmailAddress, "Operation Code", prsn.FullName, prsn.Email, subject, messageText, finalEmailHtml);
                }
                if (prsn.SendText)
                {
                    string messageText = smsMessageText;

                    _smsService.SendSms(prsn.PhoneNumber, messageText);
                }
            }
        }
    }
}