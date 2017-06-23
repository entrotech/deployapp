using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Sabio.Data;
using Sabio.Web.Models.Requests;
using Sabio.Web.Domain;
using Sabio.Web.Requests;

namespace Sabio.Web.Services
{

    public class EducationLevelService : BaseService, IEducationLevelService
    {   
        //ADD
        public int Add(EducationLevelAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.EducationLevel_Insert", inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                MapCommonParameters(model, paramCollection);

                SqlParameter p = new SqlParameter("@Id", SqlDbType.Int);
                p.Direction = ParameterDirection.Output;
                paramCollection.Add(p);

            }, returnParameters: delegate (SqlParameterCollection param)
            {
                Int32.TryParse(param["@Id"].Value.ToString(), out id);
            }
            );

            return id;
        }

        //UPDATE
        public void Update(EducationLevelUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.EducationLevel_Update", inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", model.Id);
                MapCommonParameters(model, paramCollection);
            }
            );
            return;
        }

        private void MapCommonParameters(EducationLevelAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@Code", model.Code);
            paramCollection.AddWithValue("@Name", model.Name);
            paramCollection.AddWithValue("@Inactive", model.Inactive);
            paramCollection.AddWithValue("@DisplayOrder", model.DisplayOrder);
            paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
        }

        //DELETE
        public void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.EducationLevel_Delete", inputParamMapper: delegate (SqlParameterCollection paramCollection)
             {
                 paramCollection.AddWithValue("@Id", id);
             }
            );
            return;
        }

        //GET BY ID
        public EducationLevel SelectById(int id)
        {
            EducationLevel eLevel = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.EducationLevel_SelectById", inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
            }

                , map: delegate (IDataReader reader, short set)
             {
                 eLevel = new EducationLevel();

                 int ord = 0;

                 eLevel.Id = reader.GetInt32(ord++);
                 eLevel.Code = reader.GetString(ord++);
                 eLevel.Name = reader.GetString(ord++);
                 eLevel.Inactive = reader.GetBoolean(ord++);
                 eLevel.DisplayOrder = reader.GetInt32(ord++);
                 eLevel.DateCreated = reader.GetDateTime(ord++);
                 eLevel.DateCreated = reader.GetDateTime(ord++);
             }
            );
            return eLevel;
        }

        //SELECT ALL
        public List<EducationLevel> SelectAll()
        {
            List<EducationLevel> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.EducationLevel_SelectAll"
               , inputParamMapper: null

                , map: delegate (IDataReader reader, short set)
               {
                   EducationLevel eLevel = new EducationLevel();

                   int ord = 0; //startingOrdinal

                   eLevel.Id = reader.GetSafeInt32(ord++);                 
                   eLevel.Code = reader.GetSafeString(ord++);
                   eLevel.Name = reader.GetSafeString(ord++);
                   eLevel.Inactive = reader.GetBoolean(ord++);
                   eLevel.DisplayOrder = reader.GetInt32(ord++);
                   eLevel.DateCreated = reader.GetDateTime(ord++);
                   eLevel.DateModified = reader.GetDateTime(ord++);

                   if (list == null)
                   {
                       list = new List<EducationLevel>();
                   }

                   list.Add(eLevel);
               }
               );
            return list;
        }

    }

}
