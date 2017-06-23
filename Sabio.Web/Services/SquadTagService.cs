using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Requests
{
    public class SquadTagService : BaseService, ISquadTagService
    {
        public int Post(SquadTagAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.SquadTag_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameters(model, paramCollection);

                    SqlParameter p = new SqlParameter("@Id", System.Data.SqlDbType.Int);
                    p.Direction = ParameterDirection.Output;

                    paramCollection.Add(p);
                }, returnParameters: delegate (SqlParameterCollection param)
                {
                    Int32.TryParse(param["@Id"].Value.ToString(), out id);
                }
                );

            return id;
        }
        public void Update(SquadTagUpdateRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.SquadTag_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    MapCommonParameters(model, paramCollection);
                }
                );

            return;
        }

        private void MapCommonParameters(SquadTagAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@Keyword", model.Keyword);           
            paramCollection.AddWithValue("@DisplayOrder", model.DisplayOrder);
        }

        public void Delete(int id)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.SquadTag_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );

            return;
        }
        public SquadTag SelectById(int id)
        {
            SquadTag squadTag = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.SquadTag_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   squadTag = new SquadTag();
                   int startingIndex = 0; //startingOrdinal

                   squadTag.Id = reader.GetInt32(startingIndex++);
                   squadTag.Keyword = reader.GetString(startingIndex++);
                   squadTag.DisplayOrder = reader.GetInt32(startingIndex++);


               }
               );

            return squadTag;
        }

        public List<SquadTag> SelectAll()
        {
            List<SquadTag> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.SquadTag_SelectAll"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection) { }
               , map: delegate (IDataReader reader, short set)
               {
                   SquadTag p = new SquadTag();
                   int startingIndex = 0; //startingOrdinal

                   p.Id = reader.GetInt32(startingIndex++);
                   p.Keyword = reader.GetString(startingIndex++);
                   p.DisplayOrder = reader.GetInt32(startingIndex++);

                   if (list == null)
                   {
                       list = new List<SquadTag>();
                   }

                   list.Add(p);
               }
               );


            return list;
        }
    }
}