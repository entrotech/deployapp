using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Sabio.Web.Requests
{
    public class SquadMemberStatusService : BaseService
    {
        public static List<SquadMemberStatus> SelectAll()
        {
            List<SquadMemberStatus> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.SquadMemberStatus_SelectAll",
               inputParamMapper: null

               , map: delegate (IDataReader reader, short set)
               {
                   SquadMemberStatus status = new SquadMemberStatus();

                   int ord = 0;

                   status.Id = reader.GetSafeInt32(ord++);
                   status.Name = reader.GetSafeString(ord++);

                   if (list == null)
                   {
                       list = new List<SquadMemberStatus>();
                   }

                   list.Add(status);
               }

        );
            return list;
        }
    }
}