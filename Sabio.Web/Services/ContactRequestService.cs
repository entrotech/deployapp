using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Request;
using Sabio.Web.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Services
{
    public class ContactRequestService : BaseService
    {

        // INSERT 

        public static int Insert(ContactUsAddRequest model)
        {
            {
                int id = 0;

                DataProvider.ExecuteNonQuery(GetConnection, "dbo.ContactRequest_Insert",
                            inputParamMapper: delegate (SqlParameterCollection paramCollection)
                            {

                                paramCollection.AddWithValue("@Name", model.Name);
                                paramCollection.AddWithValue("@Email", model.Email);
                                paramCollection.AddWithValue("@Message", model.Message);


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
        }

        // UPDATE
        public static void Update(ContactRequestUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.ContactRequest_Update",
            inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", model.Id);
                paramCollection.AddWithValue("@Name", model.Name);
                paramCollection.AddWithValue("@Email", model.Email);
                paramCollection.AddWithValue("@Message", model.Message);
                paramCollection.AddWithValue("@ContactRequestStatusId", model.ContactRequestStatusId);
                paramCollection.AddWithValue("@Notes", model.Notes);
                //MapCommonParameters(model, paramCollection);
            }
            );
            return;
        }

        // GET ALL 
        public static List<ContactRequest> SelectAll()
        {
            List<ContactRequest> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.ContactRequest_SelectAll"
               , inputParamMapper: null
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           ContactRequest p = new ContactRequest();
                           int startingIndex = 0; //startingOrdinal

                           p.Id = reader.GetInt32(startingIndex++);
                           p.Name = reader.GetSafeString(startingIndex++); //extension method
                           p.Email = reader.GetSafeString(startingIndex++);
                           p.Message = reader.GetSafeString(startingIndex++);
                           p.DateCreated = reader.GetDateTime(startingIndex++);
                           p.ContactRequestStatusId = reader.GetInt32(startingIndex++);
                           p.Notes = reader.GetSafeString(startingIndex++);

                           if (list == null)
                           {
                               list = new List<ContactRequest>();
                           }

                           list.Add(p);
                           break;
                   }

               }
               );


            return list;
        }

        // SELECT BY ID

        public static ContactRequest SelectById(int id)
        {
            ContactRequest contactRequest = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.ContactRequest_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);

               },
                    map: delegate (IDataReader reader, short set)
               {

                   contactRequest = new ContactRequest();
                   int startingIndex = 0;

                   contactRequest.Id = reader.GetInt32(startingIndex++);
                   contactRequest.Name = reader.GetString(startingIndex++);
                   contactRequest.Email = reader.GetString(startingIndex++);
                   contactRequest.Message = reader.GetString(startingIndex++);
                   contactRequest.DateCreated = reader.GetDateTime(startingIndex++);
                   contactRequest.ContactRequestStatusId = reader.GetInt32(startingIndex++);
                   contactRequest.Notes = reader.GetSafeString(startingIndex++);

               }
               );

            return contactRequest;
        }

        // SEARCH 

        public static List<ContactRequest> Search(ContactRequestSearchRequest model, out int totalRows)
        {
            List<ContactRequest> list = null;
            int r = 0;

            DataProvider.ExecuteCmd(GetConnection, "dbo.ContactRequest_Search"
                   , inputParamMapper: delegate (SqlParameterCollection paramCollection)
                   {
                       paramCollection.AddWithValue("@SearchStr", model.SearchString);
                       paramCollection.AddWithValue("@CurrentPage", model.CurrentPage);
                       paramCollection.AddWithValue("@ItemsPerPage", model.ItemsPerPage);
                       

                   }
                   , map: delegate (IDataReader reader, short set)
                   {
                       switch (set)
                       {
                           case 0: //first result set
                               ContactRequest p = new ContactRequest();
                               int startingIndex = 0; //startingOrdinal

                               p.Id = reader.GetInt32(startingIndex++);
                               p.Name = reader.GetSafeString(startingIndex++); //extension method
                               p.Email = reader.GetSafeString(startingIndex++);
                               p.Message = reader.GetSafeString(startingIndex++);
                               p.Notes = reader.GetSafeString(startingIndex++);
                               r = reader.GetSafeInt32(startingIndex++);


                               if (list == null)
                               {
                                   list = new List<ContactRequest>();
                               }

                               list.Add(p);
                               break;

                       }

                   }
                   );
            totalRows = r;

            return list;
        }
    }
}
