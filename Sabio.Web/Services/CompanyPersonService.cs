using Sabio.Data;
using Sabio.Web.Domain;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Services
{
    public class CompanyPersonService : BaseService, ICompanyPersonService
    {
        public void Insert(int CompanyId, int PersonId)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.CompanyPerson_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@CompanyId", CompanyId);
                    paramCollection.AddWithValue("@PersonId", PersonId);
                }
                );

            return;
        }
        public void Delete(int CompanyId, int PersonId)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.CompanyPerson_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@CompanyId", CompanyId);
                    paramCollection.AddWithValue("@PersonId", PersonId);
                }
                );

            return;
        }
        public static bool Verify(int CompanyId, string AspNetUserId)
        {
            bool IsVerified = false;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.CompanyPerson_Verify",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@CompanyId", CompanyId);
                   paramCollection.AddWithValue("@AspNetUserId", AspNetUserId);

                   SqlParameter p = new SqlParameter("@IsVerified", SqlDbType.Bit);
                   p.Direction = ParameterDirection.Output;

                   paramCollection.Add(p);
               }, returnParameters: delegate (SqlParameterCollection param)
               {
                   Boolean.TryParse(param["@IsVerified"].Value.ToString(), out IsVerified);
               }
               );

            return IsVerified;
        }
        public static bool VerifyHasCompany(string AspNetUserId)
        {
            bool IsVerified = false;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.CompanyPerson_VerifyHasCompany",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@AspNetUserId", AspNetUserId);

                   SqlParameter p = new SqlParameter("@IsVerified", SqlDbType.Bit);
                   p.Direction = ParameterDirection.Output;

                   paramCollection.Add(p);
               }, returnParameters: delegate (SqlParameterCollection param)
               {
                   Boolean.TryParse(param["@IsVerified"].Value.ToString(), out IsVerified);
               }
               );

            return IsVerified;
        }
        public List<CompanyBase> GetCompanies(string AspNetUserId)
        {
            List<CompanyBase> cList = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.CompanyPerson_GetCompanies",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@AspNetUserId", AspNetUserId);
               }, map: delegate (IDataReader reader, short set)
               {
                   CompanyBase company = new CompanyBase();
                   int ord = 0;

                   company.Id = reader.GetSafeInt32(ord++);
                   company.Name = reader.GetSafeString(ord++);
                   company.PhoneNumber = reader.GetSafeString(ord++);
                   company.Email = reader.GetSafeString(ord++);

                   if (cList == null)
                   {
                       cList = new List<CompanyBase>();
                   }
                   cList.Add(company);
               }
               );
            return cList;
        }
    }
}