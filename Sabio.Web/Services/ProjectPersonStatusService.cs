using Sabio.Data;
using Sabio.Web.Domain;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Sabio.Web.Services
{
    public class ProjectPersonStatusService : BaseService
    {

        public static List<ProjectPersonStatus> SelectAll()
        {
            List<ProjectPersonStatus> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.ProjectPersonStatus_SelectAll",
               inputParamMapper: null

               , map: delegate (IDataReader reader, short set)
               {
                   ProjectPersonStatus pps = new ProjectPersonStatus();

                   int ord = 0;

                   pps.Id = reader.GetSafeInt32(ord++);
                   pps.Status = reader.GetSafeString(ord++);

                   if (list == null)
                   {
                       list = new List<ProjectPersonStatus>();
                   }

                   list.Add(pps);
               }

        );
            return list;
        }
    }
}
