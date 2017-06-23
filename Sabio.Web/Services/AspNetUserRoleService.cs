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
    public class AspNetUserRoleService : BaseService, IAspNetUserRoleService
    {
        public void Post(AspNetUserRoleAddRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.AspNetUserRoles_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@UserId", model.UserId);
                    paramCollection.AddWithValue("@Role", model.Role);
                   
                }
                );

            return;
        }

        public void Delete(AspNetUserRoleAddRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.AspNetUserRoles_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@UserId", model.UserId);
                    paramCollection.AddWithValue("@Role", model.Role);
                }
                );

            return;
        }

        public List<AspNetUserRole> Search(AspNetUserRoleSearchRequest model)
        {
            List<AspNetUserRole> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.AspNetUserRoles_Search",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Name", model.Name);
                   paramCollection.AddWithValue("@Role", model.Role);
                   paramCollection.AddWithValue("@CurrentPage", model.CurrentPage);
                   paramCollection.AddWithValue("@ItemsPerPage", model.ItemsPerPage);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:

                           AspNetUserRole a = new AspNetUserRole();
                           int ord = 0; //startingOrdinal

                           a.FirstName = reader.GetSafeString(ord++);
                           a.LastName = reader.GetSafeString(ord++);
                           a.Email = reader.GetSafeString(ord++);
                           a.AspNetUserId = reader.GetSafeString(ord++);
                           a.TotalRows = reader.GetSafeInt32(ord++);
                           a.hasUsr = reader.GetSafeBool(ord++);
                           a.hasMgr = reader.GetSafeBool(ord++);
                           a.hasAdm = reader.GetSafeBool(ord++);
                          
                           if (list == null)
                           {
                               list = new List<AspNetUserRole>();
                           }

                           list.Add(a);
                           break;
                   }
               }
               );

            return list;
        }

        public AspNetUserRole SelectByAspNetUserId(string userId)
        {
            AspNetUserRole roles = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.AspNetUserRoles_SelectByUserId",
              inputParamMapper: delegate (SqlParameterCollection paramCollection)
              {
                  paramCollection.AddWithValue("@UserId", userId);
              }
              , map: delegate (IDataReader reader, short set)
               {
                   roles = new AspNetUserRole();
                   int ord = 0; //startingOrdinal
                   roles.AspNetUserId = reader.GetSafeString(ord++);
                   roles.hasUsr = reader.GetSafeBool(ord++);
                   roles.hasMgr = reader.GetSafeBool(ord++);
                   roles.hasAdm = reader.GetSafeBool(ord++);
               });
            return roles;
        }
        public AspNetUserRole SelectByCompanyRep(string userId)
        {
            AspNetUserRole roles = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.AspNetUserRoles_SelectByUserId",
              inputParamMapper: delegate (SqlParameterCollection paramCollection)
              {
                  paramCollection.AddWithValue("@UserId", userId);
              }
              , map: delegate (IDataReader reader, short set)
              {
                  roles = new AspNetUserRole();
                  int ord = 0; //startingOrdinal
                  roles.AspNetUserId = reader.GetSafeString(ord++);
                  roles.hasUsr = reader.GetSafeBool(ord++);
                  roles.hasMgr = reader.GetSafeBool(ord++);
                  roles.hasAdm = reader.GetSafeBool(ord++);
              });
            return roles;
        }
    }
}
