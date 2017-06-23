using Sabio.Web.Domain;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Sabio.Data;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models;
using Sabio.Web.Requests;

namespace Sabio.Web.Services
{
   
    public class ProposalService: BaseService
    {
        public static int Post(ProposalAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Proposal_Insert"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Description", model.Description);
                   paramCollection.AddWithValue("@Budget", model.Budget);
                   paramCollection.AddWithValue("@Deadline", model.Deadline);
                   paramCollection.AddWithValue("@ProjectType", model.ProjectType);
                   paramCollection.AddWithValue("@FirstName", model.FirstName);
                   paramCollection.AddWithValue("@LastName", model.LastName);
                   paramCollection.AddWithValue("@Company", model.Company);
                   paramCollection.AddWithValue("@PhoneNumber", model.PhoneNumber);
                   paramCollection.AddWithValue("@Email", model.Email);
                   paramCollection.AddWithValue("@Notes", model.Notes);
                   paramCollection.AddWithValue("@Status", model.StatusId);
                   

                   SqlParameter p = new SqlParameter("@Id", id);
                   p.Direction = ParameterDirection.Output;

                   paramCollection.Add(p);

               }, returnParameters: delegate (SqlParameterCollection param)
               {
                   Int32.TryParse(param["@Id"].Value.ToString(), out id);
               });

            return id;
        }


        public static int? Update(ProposalUpdateRequest model)
        {
            int? projectId = null;
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Proposal_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    paramCollection.AddWithValue("@Description", model.Description);
                    paramCollection.AddWithValue("@Budget", model.Budget);
                    paramCollection.AddWithValue("@Deadline", model.Deadline);
                    paramCollection.AddWithValue("@ProjectType", model.ProjectType);
                    paramCollection.AddWithValue("@FirstName", model.FirstName);
                    paramCollection.AddWithValue("@LastName", model.LastName);
                    paramCollection.AddWithValue("@Company", model.Company);
                    paramCollection.AddWithValue("@PhoneNumber", model.PhoneNumber);
                    paramCollection.AddWithValue("@Email", model.Email);
                    paramCollection.AddWithValue("@Notes", model.Notes);
                    paramCollection.AddWithValue("@Status", model.Status.Id);
                    paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
                    SqlParameter p = new SqlParameter("@ProjectId", SqlDbType.Int);
                    p.Direction = ParameterDirection.Output;
                    paramCollection.Add(p);

                }, returnParameters: delegate (SqlParameterCollection param)
                {
                    var projectIdParam = param["@ProjectId"].Value;
                    if (projectIdParam is DBNull)
                        projectId = null;
                    else
                        projectId = (int)projectIdParam;
                }   );

            return projectId;

        }

        private static void MapCommonParameters(ProposalAddRequest model, SqlParameterCollection paramCollection)
        {

            paramCollection.AddWithValue("@Description", model.Description);
            paramCollection.AddWithValue("@Budget", model.Budget);
            paramCollection.AddWithValue("@Deadline", model.Deadline);
            paramCollection.AddWithValue("@ProjectType", model.ProjectType);
            paramCollection.AddWithValue("@FirstName", model.FirstName);
            paramCollection.AddWithValue("@LastName", model.LastName);
            paramCollection.AddWithValue("@Company", model.Company);
            paramCollection.AddWithValue("@PhoneNumber", model.PhoneNumber);
            paramCollection.AddWithValue("@Email", model.Email);
            paramCollection.AddWithValue("@Notes", model.Notes);
            paramCollection.AddWithValue("@Status", model.StatusId);
        }

        public static void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Proposal_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );

            return;
        }

        public static List<Proposal> SelectAll()
        {
            List<Proposal> list = new List<Proposal>();
          
            DataProvider.ExecuteCmd(GetConnection, "dbo.Proposal_SelectAll"
               , inputParamMapper: null
               , map: delegate (IDataReader reader, short set)
               {
                   Proposal p = new Proposal();
                   int startingIndex = 0;

                   p.Id = reader.GetSafeInt32(startingIndex++);
                   p.Description = reader.GetSafeString(startingIndex++);
                   p.Budget = reader.GetSafeInt32(startingIndex++);
                   p.Deadline = reader.GetSafeString(startingIndex++);
                   p.ProjectType = reader.GetSafeString(startingIndex++);
                   p.FirstName = reader.GetSafeString(startingIndex++);
                   p.LastName = reader.GetSafeString(startingIndex++);
                   p.Company = reader.GetSafeString(startingIndex++);
                   p.PhoneNumber = reader.GetSafeString(startingIndex++);
                   p.Email = reader.GetSafeString(startingIndex++);
                   p.Notes= reader.GetSafeString(startingIndex++);               
                  ProposalStatusCategory ps = new ProposalStatusCategory();
                   ps.Id = reader.GetSafeInt32(startingIndex++);
                   ps.Name = reader.GetSafeString(startingIndex++);
                   p.Status = ps;

                   list.Add(p);
               }
               );
            return list;
        }

        public static Proposal SelectById(int id)
        {
            Proposal p = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Proposal_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   p = new Proposal();
                   int startingIndex = 0; //startingOrdinal
                   p.Id = reader.GetSafeInt32(startingIndex++);
                   p.Description = reader.GetSafeString(startingIndex++);
                   p.Budget = reader.GetSafeInt32(startingIndex++);
                   p.Deadline = reader.GetSafeString(startingIndex++);
                   p.ProjectType = reader.GetSafeString(startingIndex++);
                   p.FirstName = reader.GetSafeString(startingIndex++);
                   p.LastName = reader.GetSafeString(startingIndex++);
                   p.Company = reader.GetSafeString(startingIndex++);
                   p.PhoneNumber = reader.GetSafeString(startingIndex++);
                   p.Email = reader.GetSafeString(startingIndex++);
                   p.Notes = reader.GetSafeString(startingIndex++);
                   ProposalStatusCategory ps = new ProposalStatusCategory();
                   ps.Id = reader.GetSafeInt32(startingIndex++);
                   ps.Name = reader.GetSafeString(startingIndex++);
                   p.Status = ps;
               }
               );

            return p;
        }
        public static List<Proposal> Search(ProposalSearchRequest model)
        {
            List<Proposal> list = null;
           
            DataProvider.ExecuteCmd(GetConnection, "dbo.Proposal_Search"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Name", model.Name);
               }
               , map: delegate (IDataReader reader, short set)
               {

                   {

                       Proposal p = new Proposal();
                       int startingIndex = 0; //startingOrdinal

                       p.Id = reader.GetSafeInt32(startingIndex++);
                       p.Description = reader.GetSafeString(startingIndex++);
                       p.Budget = reader.GetSafeInt32(startingIndex++);
                       p.Deadline = reader.GetSafeString(startingIndex++);
                       p.ProjectType = reader.GetSafeString(startingIndex++);
                       p.FirstName = reader.GetSafeString(startingIndex++);
                       p.LastName = reader.GetSafeString(startingIndex++);
                       p.Company = reader.GetSafeString(startingIndex++);
                       p.PhoneNumber = reader.GetSafeString(startingIndex++);
                       p.Email = reader.GetSafeString(startingIndex++);
                       p.Notes = reader.GetSafeString(startingIndex++);
                       ProposalStatusCategory ps = new ProposalStatusCategory();
                       ps.Id = reader.GetSafeInt32(startingIndex++);
                       ps.Name = reader.GetSafeString(startingIndex++);
                       p.Status = ps;

                       if (list == null)
                       {
                           list = new List<Proposal>();
                       }

                       list.Add(p);


                   }

               }
               );

            return list;
        }

    }
}
