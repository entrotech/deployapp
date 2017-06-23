using Sabio.Data;
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
    public class SecurityTokenService : BaseService
    {
        public static Guid Insert(SecurityTokenAddRequest model)
        {
            Guid guid = new Guid();

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.SecurityToken_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@TokenTypeId", model.TokenTypeId);
                    paramCollection.AddWithValue("@FirstName", model.FirstName);
                    paramCollection.AddWithValue("@LastName", model.LastName);
                    paramCollection.AddWithValue("@Email", model.Email);
                    paramCollection.AddWithValue("@AspNetUserId", model.AspNetUserId);

                    SqlParameter p = new SqlParameter("@TokenGuid", SqlDbType.UniqueIdentifier);
                    p.Direction = ParameterDirection.Output;

                    paramCollection.Add(p);
                }, returnParameters: delegate (SqlParameterCollection param)
                {
                    Guid.TryParse(param["@TokenGuid"].Value.ToString(), out guid);
                }
                );

            return guid;
        }
        public static SecurityToken SelectByGuid(Guid guid)
        {
            SecurityToken securityToken = new SecurityToken();

            DataProvider.ExecuteCmd(GetConnection, "dbo.SecurityToken_GetByGuid",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@TokenGuid", guid);
               }
               , map: (Action<IDataReader, short>)delegate (IDataReader reader, short set)
               {
                   int ord = 0;
                   securityToken.TokenGuid = reader.GetSafeGuid(ord++);
                   securityToken.TokenTypeId = reader.GetSafeInt32(ord++);
                   securityToken.FirstName = reader.GetSafeString(ord++);
                   securityToken.LastName = reader.GetSafeString(ord++);
                   securityToken.Email = reader.GetSafeString(ord++);
                   securityToken.AspNetUserId = reader.GetSafeString(ord++);
                   securityToken.DateCreated = reader.GetSafeDateTime(ord++);
               }
               );
            return securityToken;
        }
    }
}