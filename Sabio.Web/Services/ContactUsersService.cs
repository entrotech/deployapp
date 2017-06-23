using Sabio.Data;
using Sabio.Web.Classes;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
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
    public class ContactUsersService : BaseService, IContactUsersService
    {
        public IEmailService _emailService = null;

        public ContactUsersService(IEmailService emailService)
        {
            _emailService = emailService;
        }

        public async Task Send(UsersEmailSendRequest model)
        {
            List<PersonBase> personList = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.PersonNotificationPreference_GetContactUsersPeople",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@AspNetUserRoleId", model.AspNetUserRoleId ?? String.Empty);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           PersonBase prsn = new PersonBase();

                           int ord = 0;
                           prsn.Id = reader.GetSafeInt32(ord++);
                           prsn.FirstName = reader.GetSafeString(ord++);
                           prsn.MiddleName = reader.GetSafeString(ord++);
                           prsn.LastName = reader.GetSafeString(ord++);
                           prsn.PhoneNumber = reader.GetSafeString(ord++);
                           prsn.Email = reader.GetSafeString(ord++);

                           if (personList == null)
                           {
                               personList = new List<PersonBase>();
                           }
                           personList.Add(prsn);
                           break;
                   }
               }
               );
            if (personList != null)
            {
                foreach (PersonBase prsn in personList)
                {
                    string path = HttpContext.Current.Server.MapPath("~/HTML_Templates/ContactUsersEmail.html");
                    string emailBody = System.IO.File.ReadAllText(path);
                    string finalEmailHtml = emailBody.Replace("{{title}}", model.Title)
                                                .Replace("{{body}}", model.Body);

                    await _emailService.Send(SiteConfig.SiteAdminEmailAddress, "Operation Code", prsn.FullName, prsn.Email, model.Subject, model.PlainText, finalEmailHtml);
                }
            }

        }

        public List<UserRole> GetUserRoles()
        {
            List<UserRole> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.AspNetRoles_GetAll",
               inputParamMapper: null,
               map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           UserRole userRole = new UserRole();
                           int ord = 0;

                           userRole.Id = reader.GetSafeString(ord++);
                           userRole.Name = reader.GetSafeString(ord++);

                           if (list == null)
                           {
                               list = new List<UserRole>();
                           }
                           list.Add(userRole);
                           break;
                   }
               }
               );

            return list;
        }
    }
}