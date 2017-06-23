using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests.Interfaces;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;


namespace Sabio.Web.Requests
{
    public class TestimonialService : BaseService, ITestimonialService
    {
        public int Post(TestimonialAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Testimonial_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameters(model, paramCollection);
                    //paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
                    paramCollection.AddWithValue("@PersonId", model.PersonId);
                    SqlParameter p = new SqlParameter("@Id", System.Data.SqlDbType.Int);
                    p.Direction = ParameterDirection.Output;
                    paramCollection.Add(p);
                }, returnParameters: delegate (SqlParameterCollection param)
                {
                    Int32.TryParse(param["@Id"].Value.ToString(), out id);
                }
                );
            return id;
        }
        public void Update(TestimonialUpdateRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Testimonial_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    paramCollection.AddWithValue("@Inactive", model.Inactive);

                    MapCommonParameters(model, paramCollection);
                }
                );

            return;
        }

        private static void MapCommonParameters(TestimonialAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@Testimonial", model.Content);
        }

        public void Delete(int id)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Testimonial_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );

            return;
        }
        public Testimonial SelectById(int id)
        {
            Testimonial testimonial = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Testimonial_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           testimonial = MapTestimonial(reader);
                           break;
                   }
               }
               );

            return testimonial;
        }
        public List<Testimonial> SelectAll()
        {
            List<Testimonial> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Testimonial_SelectAll"
               , inputParamMapper: null
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           Testimonial p = MapTestimonial(reader);
                           if (list == null)
                           {
                               list = new List<Testimonial>();
                           }
                           list.Add(p);
                           break;
                   }
               }
               );


            return list;
        }

        private static Testimonial MapTestimonial(IDataReader reader)
        {
            Testimonial p = new Testimonial();
            PersonBase pb = new PersonBase();
            p.Person = pb;

            int ord = 0; //startingOrdinal

            p.Id = reader.GetSafeInt32(ord++);
            p.Content = reader.GetSafeString(ord++);
            p.DateCreated = reader.GetSafeDateTime(ord++);
            p.DateModified = reader.GetSafeDateTime(ord++);
            pb.Id = reader.GetSafeInt32(ord++);
            pb.FirstName = reader.GetSafeString(ord++);
            pb.MiddleName = reader.GetSafeString(ord++);
            pb.LastName = reader.GetSafeString(ord++);
            pb.PhoneNumber = reader.GetSafeString(ord++);
            pb.Email = reader.GetSafeString(ord++);
            pb.JobTitle = reader.GetSafeString(ord++);
            string photo = reader.GetSafeString(ord++);
            pb.ProfilePicture = "https://sabio-training.s3-us-west-2.amazonaws.com/C31/" + photo;
            p.Inactive = reader.GetSafeBool(ord++);
            return p;
        }
        public List<Testimonial> Search(TestimonialSearchRequest model)
        {
            List<Testimonial> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Testimonial_Search"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Inactive", model.Inactive);
               }
               , map: delegate (IDataReader reader, short set)
               {

                   {
                       Testimonial p = new Testimonial();
                       PersonBase pb = new PersonBase();
                       p.Person = pb;
                       int ord = 0; //startingOrdinal

                       p.Id = reader.GetSafeInt32(ord++);
                       p.Content = reader.GetSafeString(ord++);
                       p.DateCreated = reader.GetSafeDateTime(ord++);
                       p.DateModified = reader.GetSafeDateTime(ord++);
                       pb.Id = reader.GetSafeInt32(ord++);
                       pb.FirstName = reader.GetSafeString(ord++);
                       pb.MiddleName = reader.GetSafeString(ord++);
                       pb.LastName = reader.GetSafeString(ord++);
                       pb.PhoneNumber = reader.GetSafeString(ord++);
                       pb.Email = reader.GetSafeString(ord++);
                       pb.JobTitle = reader.GetSafeString(ord++);
                       string photo = reader.GetSafeString(ord++);
                       pb.ProfilePicture = "https://sabio-training.s3-us-west-2.amazonaws.com/C31/" + photo;
                       p.Inactive = reader.GetSafeBool(ord++);

                       if (list == null)
                       {
                           list = new List<Testimonial>();
                       }
                       list.Add(p);
                   }

               }
               );

            return list;
        }
    }
}