using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Sabio.Web.Services
{
    
    public class ServiceBranchService : BaseService, IServiceBranchService
    {
       
        public  int Insert(ServiceBranchAddRequest model)
        {
            int id = 0;
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.ServiceBranch_Insert",
                 inputParamMapper: delegate (SqlParameterCollection paramCollection)
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
        public  void delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.ServiceBranch_delete", inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
            }
            );
            return;

        }
        public   ServiceBranch SelectById(int id)
        {
            ServiceBranch branch = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.ServiceBranch_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   branch = MapServiceBranch(reader);

               }
               );

            return branch;
        }



        public  List<ServiceBranch> SelectAll()
        {
            List<ServiceBranch> branchlist = new List<ServiceBranch>();


            DataProvider.ExecuteCmd(GetConnection, "dbo.ServiceBranch_SelectAll",
               inputParamMapper: null

               , map: delegate (IDataReader reader, short set)
               {
                   ServiceBranch branch = MapServiceBranch(reader);

                   branchlist.Add(branch);
               }
               );

            return branchlist;
        }
        public  void Update(ServiceBranchUpdateRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.ServiceBranch_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    MapCommonParameters(model, paramCollection);
                }
                );

            return;
        }
        public List<Rank> GetRankByService(Branch model)
        {
            List<Rank> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Rank_selectByBranch"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Branch", model.branch);
                   

               }
               , map: delegate (IDataReader reader, short set)
               {
                   Rank p = new Rank();
                   int startingIndex = 0; //startingOrdinal
                   p.rank = reader.GetSafeString(startingIndex++);
                   p.Code = reader.GetSafeString(startingIndex++);
                   p.Grade = reader.GetSafeString(startingIndex++);
                   p.ServiceBranch = reader.GetSafeString(startingIndex++);
                  
                   if (list == null)
                   {
                       list = new List<Rank>();
                   }

                   list.Add(p);
                  

               });
            return list;
        }



        private static  void MapCommonParameters(ServiceBranchAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@Code", model.Code);
            paramCollection.AddWithValue("@Name", model.Name);
            paramCollection.AddWithValue("@Inactive", model.Inactive);
            paramCollection.AddWithValue("@DisplayOrder", model.DisplayOrder);
            paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
        }
        private static ServiceBranch MapServiceBranch(IDataReader reader)
        {
            ServiceBranch branch = new ServiceBranch();
            int ord = 0;

            branch.Id = reader.GetInt32(ord++);
            branch.Code = reader.GetString(ord++);
            branch.Name = reader.GetString(ord++);
            branch.Inactive = reader.GetBoolean(ord++);
            branch.DisplayOrder = reader.GetInt32(ord++);
            branch.DateCreated = reader.GetDateTime(ord++);
            branch.DateModified = reader.GetDateTime(ord++);
            branch.UserIdCreated = reader.GetString(ord++);
            return branch;
        }
    }
}