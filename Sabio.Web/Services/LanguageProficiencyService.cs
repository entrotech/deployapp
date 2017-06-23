
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Sabio.Web.Domain;
using System.Data;
using Sabio.Data;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests;

namespace Sabio.Web.Services
{
    public class LanguageProficiencyService : BaseService
    {
        
        public static int Insert(LanguageProficiencyAddRequest model)
        {
            int id = 0;
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.LanguageProficiency_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Name", model.Name);
                    paramCollection.AddWithValue("@Code", model.Code);
                    paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
                    paramCollection.AddWithValue("@DisplayOrder", model.DisplayOrder);
                    paramCollection.AddWithValue("@Inactive", model.Inactive);


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

        public static void Update(LanguageProficiencyUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.LanguageProficiency_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    // map common parameters and remove following two lines:
                    paramCollection.AddWithValue("@Name", model.Name);
                    paramCollection.AddWithValue("@Code", model.Code);
                    paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
                    paramCollection.AddWithValue("@DisplayOrder", model.DisplayOrder);
                    paramCollection.AddWithValue("@Inactive", model.Inactive);
                }
            );

            return;
        }

        public static void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.LanguageProficiency_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );
            return;
        }

        public static LanguageProficiency SelectById(int id)
        {
            LanguageProficiency languageproficiency = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.LanguageProficiency_SelectById",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                },
                map: delegate (IDataReader reader, short set)
                {
                    languageproficiency = new LanguageProficiency();
                    int startingIndex = 0;

                    languageproficiency.Key = reader.GetSafeString(startingIndex++);
                    languageproficiency.Name = reader.GetSafeString(startingIndex++);
                    languageproficiency.Code = reader.GetSafeString(startingIndex++);
                    languageproficiency.DisplayOrder = reader.GetSafeInt32(startingIndex++);
                    languageproficiency.Inactive = reader.GetSafeBool(startingIndex++);
                },

                returnParameters: null,  // added this

                cmdModifier: null       // added this

                );
            return languageproficiency;
        }

        public static List<LanguageProficiency> SelectAll()
        {
            List<LanguageProficiency> list = new List<LanguageProficiency>();


            DataProvider.ExecuteCmd(GetConnection, "dbo.LanguageProficiency_GetAll",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                },
                map: delegate (IDataReader reader, short set)
                {
                    LanguageProficiency p = new LanguageProficiency();
                    int startingIndex = 0;    // this number is dependant on the columns one decides to include.
                    p.Key = reader.GetSafeString(startingIndex++);  
                    p.Code = reader.GetSafeString(startingIndex++);
                    p.Description = reader.GetSafeString(startingIndex++);
                    p.DisplayOrder = reader.GetSafeInt32(startingIndex++);
                    p.Name = reader.GetSafeString(startingIndex++);

        list.Add(p);
                },

                returnParameters: null, 

                cmdModifier: null     

                );
            return list;
        }

    }
}
