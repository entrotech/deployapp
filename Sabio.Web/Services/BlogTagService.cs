using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Services
{
    public class BlogTagService : BaseService
    {
        public static int Insert(BlogTagAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.BlogTag_Insert",
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
        public static void Update(BlogTagUpdateRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.BlogTag_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    MapCommonParameters(model, paramCollection);
                }
                );

            return;
        }
        private static void MapCommonParameters(BlogTagAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@keyword", model.Keyword.ToUpper());
        }

        public static BlogTag SelectById(int id)
        {
            BlogTag blogTag = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.BlogTag_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           blogTag = MapBlogTag(reader);
                           break;
                   }
               }
               );

            return blogTag;
        }

        public static List<BlogTag> search(string searchString)
        {


            List<BlogTag> list = new List<BlogTag>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.BlogTag_Search",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@searchString", searchString);

               },
               map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           BlogTag bt = MapBlogTag(reader);
                           if (list == null)
                           {
                               list = new List<BlogTag>();
                           }
                           list.Add(bt);
                           break;
                   }
               }
               );

            return list;
        }
        private static BlogTag MapBlogTag(IDataReader reader)
        {
            BlogTag blogTag = new BlogTag();
            int startingIndex = 0; //startingOrdinal

            blogTag.Id = reader.GetSafeInt32(startingIndex++);
            blogTag.Keyword = reader.GetSafeString(startingIndex++);
            return blogTag;
        }

        public static void Delete(int id)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.BlogTag_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );

            return;
        }
        public static List<BlogTag> SelectAll()
        {

            List<BlogTag> list = new List<BlogTag>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.BlogTag_SelectAll",
               inputParamMapper: null,
               map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           BlogTag bt = MapBlogTag(reader);
                           if (list == null)
                           {
                               list = new List<BlogTag>();
                           }
                           list.Add(bt);
                           break;
                   }
               }
               );

            return list;
        }

    }
}