using Sabio.Web.Models.Requests;
using System;
using System.Data;
using System.Data.SqlClient;
using Sabio.Data;
using Sabio.Web.Domain;
using System.Collections.Generic;
using Sabio.Web.Requests;

namespace Sabio.Web.Services
{
    public class LanguageService : BaseService, ILanguageService
    {

        public int Insert(LanguageAddRequest model)
        {
            int id = 0;
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Language_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    // map common parameters and remove following three lines:
                    paramCollection.AddWithValue("@Name", model.Name);
                    paramCollection.AddWithValue("@Code", model.Code);
                    paramCollection.AddWithValue("@DisplayOrder", model.DisplayOrder);
                    paramCollection.AddWithValue("@Inactive", model.Inactive);
                    paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());

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

        public void Update(LanguageUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Language_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    paramCollection.AddWithValue("@Name", model.Name);
                    paramCollection.AddWithValue("@Code", model.Code);                   
                    paramCollection.AddWithValue("@DisplayOrder", model.DisplayOrder);
                    paramCollection.AddWithValue("@Inactive", model.Inactive);
                    paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
                }
            );

            return;
        }

        public void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Language_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );
            return;
        }

        public Language SelectById(int id)
        {
            Language language = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Language_SelectById",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                },
                map: delegate (IDataReader reader, short set)
                {
                    language = new Language();
                    int startingIndex = 0;

                    language.Id = reader.GetSafeInt32(startingIndex++);
                    language.Name = reader.GetSafeString(startingIndex++);
                    language.Code = reader.GetSafeString(startingIndex++);
                    language.DisplayOrder = reader.GetSafeInt32(startingIndex++);
                    language.Inactive = reader.GetSafeBool(startingIndex++);
                },

                returnParameters: null,  // added this

                cmdModifier: null       // added this

                );
            return language;
        }

        public List<Language> SelectAll()
        {
            List<Language> list = new List<Language>();


            DataProvider.ExecuteCmd(GetConnection, "dbo.Language_SelectAll",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                },
                map: delegate (IDataReader reader, short set)
                {
                    Language p = new Language();
                    int startingIndex = 0;    // this number is dependant on the columns one decides to include.

                    p.Id = reader.GetSafeInt32(startingIndex++);
                    p.Name = reader.GetSafeString(startingIndex++);
                    p.Code = reader.GetSafeString(startingIndex++);
                    p.DisplayOrder = reader.GetSafeInt32(startingIndex++);
                    p.Inactive = reader.GetSafeBool(startingIndex++);


                    list.Add(p);
                },

                returnParameters: null,  // added this

                cmdModifier: null       // added this

                );
            return list;
        }

    }
}
       