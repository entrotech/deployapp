using Sabio.Data;
using Sabio.Web.Domain;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Services
{
    public class SquadSquadTagService : BaseService
    {
        public static List<SquadTag>SelectSquadTags(int id)
        {
            List<SquadTag> stList = new List<SquadTag>();
            DataProvider.ExecuteCmd(GetConnection, "dbo.SquadSquadTag_SelectBySquadId", inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@SquadId", id);

            },

            map: (Action<IDataReader, short>)delegate (IDataReader reader, short set)
             {
                 SquadTag squadTag = new SquadTag();
                 int startingIndex = 0;
                 squadTag.Id = reader.GetSafeInt32(startingIndex++);
                 squadTag.Keyword = reader.GetSafeString(startingIndex++);
                 stList.Add(squadTag);

             });
            return stList;
        }
        public static List<Squad>SelectSquads(int id)
        {
            
            {
                List<Squad> sList = new List<Squad>();
                DataProvider.ExecuteCmd(GetConnection, "dbo.SquadSquadTag_SelectBySquadTagId", inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@squadTagId", id);
                },
                map: (Action<IDataReader, short>)delegate (IDataReader reader, short set)
               {
                   Squad squad = new Squad();
                   int startingIndex = 0;
                   squad.Id = reader.GetSafeInt32(startingIndex++);
                   squad.Name = reader.GetSafeString(startingIndex++);
                   squad.Mission = reader.GetSafeString(startingIndex++);
                   squad.Notes = reader.GetSafeString(startingIndex++);
                   squad.UserIdCreated = reader.GetSafeString(startingIndex++);
                   sList.Add(squad);
               });
                return sList;
            }

        }
        public static void Insert(SquadSquadTagAddRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.SquadSquadTag_Insert", inputParamMapper: delegate (SqlParameterCollection paramCollection)
           {
               paramCollection.AddWithValue("@SquadId", model.SquadId);
               paramCollection.AddWithValue("@SquadTagId", model.SquadTagId);
           },
           returnParameters: null
           );
        }
    }
}