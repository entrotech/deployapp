using Sabio.Web.Models.Requests;
using Sabio.Web.Domain;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Sabio.Data;
using Sabio.Web.Requests;

namespace Sabio.Web.Services
{
    public class FaqService : BaseService, IFaqService
    {
        public  int Insert(FaqAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Faq_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {

                    paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
                    paramCollection.AddWithValue("@Question", model.Question);
                    paramCollection.AddWithValue("@Answer", model.Answer);
                    paramCollection.AddWithValue("@FaqCategoryId", model.FaqCategoryId);

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
        public  void Update(FaqUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Faq_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
                    paramCollection.AddWithValue("@Question", model.Question);
                    paramCollection.AddWithValue("@Answer", model.Answer);
                    paramCollection.AddWithValue("@FaqCategoryId", model.FaqCategoryId);
                }
                );
            return;
        }

        private  void MapCommonParameters(FaqAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@DateCreated", model.DateCreated);
            paramCollection.AddWithValue("@DateModified", model.DateModified);
            paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
            paramCollection.AddWithValue("@Question", model.Question);
            paramCollection.AddWithValue("@Answer", model.Answer);
            paramCollection.AddWithValue("@FaqCategoryId", model.FaqCategoryId);
        }

        public  void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Faq_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );

            return;
        }

        public  Faq SelectById(int id)
        {
            Faq faq = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Faq_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   faq = new Faq();
                   int startingIndex = 0;

                   faq.Id = reader.GetInt32(startingIndex++);
                   faq.DateCreated = reader.GetDateTime(startingIndex++);
                   faq.DateModified = reader.GetDateTime(startingIndex++);
                   faq.UserIdCreated = reader.GetString(startingIndex++);
                   faq.Question = reader.GetString(startingIndex++);
                   faq.Answer = reader.GetString(startingIndex++);
                   FaqCategory fc = new FaqCategory();
                   fc.Id = reader.GetSafeInt32(startingIndex++);
                   fc.Name = reader.GetSafeString(startingIndex++);
                   faq.FaqCategory = fc;
               }
               );
            return faq;
        }

        public  List<Faq> SelectAll()
        {
            List<Faq> listFaq = new List<Faq>();
            Faq faq = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Faq_SelectAll",
                  inputParamMapper: null
                  , map: delegate (IDataReader reader, short set)
                  {                         
                      faq = new Faq();
                      int startingIndex = 0; //startingOrdinal

                      faq.Id = reader.GetInt32(startingIndex++);
                      faq.DateCreated = reader.GetDateTime(startingIndex++);
                      faq.DateModified = reader.GetDateTime(startingIndex++);
                      faq.UserIdCreated = reader.GetString(startingIndex++);
                      faq.Question = reader.GetString(startingIndex++);
                      faq.Answer = reader.GetString(startingIndex++);
                      FaqCategory fc= new FaqCategory();
                      fc.Id= reader.GetSafeInt32(startingIndex++);
                      fc.Name = reader.GetSafeString(startingIndex++);
                      faq.FaqCategory = fc;
                   
                      if (faq == null)
                      {
                          listFaq = new List<Faq>();
                      }

                      listFaq.Add(faq);
                  }
               );

            return listFaq;
        }
    }
}

