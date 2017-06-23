using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Services
{
    public class SquadMemberEventService : BaseService
    {
        public static List<SquadMemberEvent> SelectAll()
        {
            List<SquadMemberEvent> list = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.SquadMemberEvent_SelectAll"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   string loggedInUser = UserService.GetCurrentUserId();
                   if (loggedInUser == null)
                   {
                       loggedInUser = "";
                       paramCollection.AddWithValue("@userId", loggedInUser);
                   }
                   else
                   {
                       paramCollection.AddWithValue("@userId", loggedInUser);
                   }
               }
               , map: delegate (IDataReader reader, short set)
               {
                   SquadMemberEvent p = new SquadMemberEvent();
                   int startingIndex = 0;
                   p.PersonId = reader.GetSafeInt32(startingIndex++);
                   p.SquadId = reader.GetSafeInt32(startingIndex++);
                   p.SquadEventId = reader.GetSafeInt32(startingIndex++);
                   p.SquadEventName = reader.GetSafeString(startingIndex++);
                   p.SquadEventStart = reader.GetSafeDateTime(startingIndex++);
                   p.SquadEventEnd = reader.GetSafeDateTime(startingIndex++);
                   p.SquadEventDescription = reader.GetSafeString(startingIndex++);
                   p.SquadEventLocation = reader.GetSafeString(startingIndex++);

                   if (list == null)
                   {
                       list = new List<SquadMemberEvent>();
                   }

                   list.Add(p);
               });

            return list;
        }
    }
}