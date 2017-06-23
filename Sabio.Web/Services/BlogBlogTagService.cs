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
    public class BlogBlogTagService : BaseService
    {
        public static List<BlogTag> SelectBlogTags(int id)
        {
            List<BlogTag> list = new List<BlogTag>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.BlogBlogTag_SelectByBlogId",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@BlogId", id);

               },
               map: (Action<IDataReader, short>)delegate (IDataReader reader, short set)
               {
                   BlogTag blogTag = new BlogTag();
                   int startingIndex = 0; //startingOrdinal

                   blogTag.Id = reader.GetInt32(startingIndex++);
                   blogTag.Keyword = reader.GetString(startingIndex++);

                   list.Add(blogTag);

               }
               );

            return list;
        }
        public static List<Blog> SelectBlogs(int id)
        {
            List<Blog> list = new List<Blog>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.BlogBlogTag_SelectByBlogTagId",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@BlogTagId", id);

               },
               map: (Action<IDataReader, short>)delegate (IDataReader reader, short set)
               {
                   Blog blog = new Blog();
                   int startingIndex = 0; //startingOrdinal

                   blog.Id = reader.GetSafeInt32(startingIndex++);
                   blog.UserIdCreated = reader.GetSafeString(startingIndex++);
                   blog.Title = reader.GetSafeString(startingIndex++);
                   blog.Body = reader.GetSafeString(startingIndex++);
                   blog.BlogCategory = reader.GetSafeString(startingIndex++);
                   blog.Private = reader.GetSafeBool(startingIndex++);
                   list.Add(blog);

               }
               );

            return list;
        }
        public static void Insert(BlogBlogTagAddRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.BlogBlogTag_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@BlogId", model.BlogId);
                    paramCollection.AddWithValue("@BlogTagId", model.BlogTagId);

                }, returnParameters: null
                );

            return;
        }
    }
}
