//using Sabio.Web.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Sabio.Data;
using System.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests;

namespace Sabio.Web.Services
{
    public class ProjectPersonService : BaseService
    {
        public static void Post(ProjectPersonAddRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.ProjectPerson_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameters(model, paramCollection);

                }, returnParameters: null
                );

            return;
        }

        public static void Update(ProjectPersonAddRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.ProjectPerson_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameters(model, paramCollection);

                }, returnParameters: null
                );

            return;
        }

        public static List<ProjectPersonBase> SelectByPersonId(int personId)
        {
            List<ProjectPersonBase> ppbList = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.ProjectPerson_SelectByPersonId",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@PersonId", personId);
                }
                 , map: delegate (IDataReader reader, short set)
                 {                                   
                     switch (set)
                     {
                         case 0:

                             ProjectPersonBase ppb = MapProjectPerson(reader);
                             if (ppbList == null)
                             {
                                 ppbList = new List<ProjectPersonBase>();
                             }
                             ppbList.Add(ppb);

                             break;
                     }
                 });
            return ppbList;
        }

        private static ProjectPersonBase MapProjectPerson(IDataReader reader)
        {
            int ord = 0;
            ProjectPersonBase ppb = new ProjectPersonBase();

            ppb.PersonId = reader.GetSafeInt32(ord++);
            ppb.ProjectId = reader.GetSafeInt32(ord++);
            ppb.ProjectName = reader.GetSafeString(ord++);
            ppb.StatusId = reader.GetSafeInt32(ord++);
            ppb.ProjectPersonStatus = reader.GetSafeString(ord++);
            ppb.IsLeader = reader.GetSafeBool(ord++);
            ppb.HourlyRate = reader.GetSafeDecimal(ord++);

            return ppb;
        }

        private static void MapCommonParameters(ProjectPersonAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@ProjectId", model.ProjectId);
            paramCollection.AddWithValue("@PersonId", model.PersonId);
            paramCollection.AddWithValue("@IsLeader", model.IsLeader);
            paramCollection.AddWithValue("@StatusId", model.StatusId);
            paramCollection.AddWithValue("@HourlyRate", model.HourlyRate);
            paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
        }
    }
}