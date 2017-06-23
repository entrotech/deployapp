using System;
using Microsoft.AspNet.Identity;
using context = System.Web.HttpContext;
using System.Data;
using Sabio.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Services
{
    public class ExceptionLoggingService : BaseService
    {
        public static void Insert(Exception ex)
        {
            string apiUrl = String.Empty;
            if(context.Current.Request.Url != null)
            {
                apiUrl = context.Current.Request.Url.ToString();
            }

            string viewUrl = String.Empty;
            if (context.Current.Request.UrlReferrer != null)
            {
                viewUrl = context.Current.Request.UrlReferrer.ToString();
            }

            string userId = String.Empty;
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                userId = HttpContext.Current.User.Identity.GetUserId();
            }

            string body = String.Empty;
            if (HttpContext.Current.Request.Form.Count > 0)
            {
                body = HttpContext.Current.Request.Form.ToString();
            }
            if (context.Current.Request.HttpMethod != null)
            {
                body += " (Method: " + context.Current.Request.HttpMethod + ")";
            }

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.ExceptionLog_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Message", ex.Message.ToString());
                    paramCollection.AddWithValue("@Type", ex.GetType().Name.ToString());
                    paramCollection.AddWithValue("@ApiUrl", apiUrl);
                    paramCollection.AddWithValue("@ViewUrl", viewUrl);
                    paramCollection.AddWithValue("@RequestBody", body);
                    if (ex.StackTrace != null)
                    {
                        paramCollection.AddWithValue("@StackTrace", ex.StackTrace.ToString());
                    }
                    else
                    {
                        paramCollection.AddWithValue("@StackTrace", String.Empty);
                    }
                    paramCollection.AddWithValue("@AspNetUserId", userId);

                }, returnParameters: null
                );
            return;
        }
        public static List<Domain.Exception> SelectAll(out int totalResults)
        {
            List<Domain.Exception> list = null;
            int totalRows = 0;

            DataProvider.ExecuteCmd(GetConnection, "dbo.ExceptionLog_SelectAll",
               inputParamMapper: null,
               map: (Action<IDataReader, short>)delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           Domain.Exception ex = MapException(reader, out totalRows);

                           if (list == null)
                           {
                               list = new List<Domain.Exception>();
                           }
                           list.Add(ex);
                           break;
                   }
               }
               );
            totalResults = totalRows;
            return list;
        }
        public static List<Domain.Exception> Search(ExceptionSearchRequest request, out int totalResults)
        {
            List<Domain.Exception> list = null;
            int totalRows = 0;

            DataProvider.ExecuteCmd(GetConnection, "dbo.ExceptionLog_Search",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Type", request.Type ?? String.Empty);
                   paramCollection.AddWithValue("@Message", request.Message ?? String.Empty);
                   paramCollection.AddWithValue("@StackTrace", request.StackTrace ?? String.Empty);
                   paramCollection.AddWithValue("@Url", request.Url ?? String.Empty);
                   paramCollection.AddWithValue("@Person", request.Person ?? String.Empty);
                   paramCollection.AddWithValue("@StartDate", request.StartDate);
                   paramCollection.AddWithValue("@EndDate", request.EndDate);
                   paramCollection.AddWithValue("@CurrentPage", request.CurrentPage);
                   paramCollection.AddWithValue("@ItemsPerPage", request.ItemsPerPage);
               },
               map: (Action<IDataReader, short>)delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           Domain.Exception ex = MapException(reader, out totalRows);

                           if (list == null)
                           {
                               list = new List<Domain.Exception>();
                           }
                           list.Add(ex);
                           break;
                   }
               }
               );
            totalResults = totalRows;
            return list;
        }

        private static Domain.Exception MapException(IDataReader reader, out int rows)
        {
            Domain.Exception ex = new Domain.Exception();

            int ord = 0;

            ex.Id = reader.GetSafeInt32(ord++);
            ex.Message = reader.GetSafeString(ord++);
            ex.Type = reader.GetSafeString(ord++);
            ex.StackTrace = reader.GetSafeString(ord++);
            ex.ApiUrl = reader.GetSafeString(ord++);
            ex.ViewUrl = reader.GetSafeString(ord++);
            ex.RequestBody = reader.GetSafeString(ord++);
            ex.AspNetUserId = reader.GetSafeString(ord++);
            int? personId = reader.GetSafeInt32Nullable(ord++);
            ex.Person = new Domain.PersonBase();
            if(personId != null)
            {
                ex.Person.Id = (int)personId;
            }
            else
            {
                ex.Person.Id = -1;
            }
            ex.Person.FirstName = reader.GetSafeString(ord++);
            ex.Person.MiddleName = reader.GetSafeString(ord++);
            ex.Person.LastName = reader.GetSafeString(ord++);
            ex.Person.PhoneNumber = reader.GetSafeString(ord++);
            ex.Person.Email = reader.GetSafeString(ord++);
            ex.Person.JobTitle = reader.GetSafeString(ord++);
            ex.LogDate = reader.GetSafeDateTime(ord++);
            rows = reader.GetSafeInt32(ord++);
            return ex;
        }
    }
}