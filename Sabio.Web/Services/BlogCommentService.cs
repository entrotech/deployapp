using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using System.Collections.Generic;
using System.Data;
using System;
using System.Data.SqlClient;
using Sabio.Web.Requests;

namespace Sabio.Web.Services
{
    public class BlogCommentService : BaseService
    {
        public static List<BlogComment> SelectAll(int id)
        {
            List<BlogComment> list = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.BlogComment_SelectAll"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   BlogComment p = MapBlogComment(reader);
                   if (list == null)
                   {
                       list = new List<BlogComment>();
                   }
                   list.Add(p);


               });


            return list;
        }
        public static BlogComment SelectAllByBlogId(int id)
        {
            BlogComment blogComment = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.BlogComment_SelectById"
                , inputParamMapper: delegate (SqlParameterCollection paramCollection)
                 {
                     paramCollection.AddWithValue("@Id", id);

                 }
               , map: delegate (IDataReader reader, short set)
               {
                   blogComment = new BlogComment();
                   blogComment = MapBlogComment(reader);

               });
            return blogComment;
        }
        public static List<BlogComment> SelectById(int id)
        {
            List<BlogComment> list = null;
            Dictionary<int, BlogComment> commentDictionary = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.BlogComment_SelectByBlogId",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);

                },
                map: delegate (IDataReader reader, short set)
                {

                    BlogComment p = MapBlogComment(reader);
                    if (commentDictionary == null)
                    {
                        commentDictionary = new Dictionary<int, BlogComment>();
                    }
                    commentDictionary.Add(p.Id, p);

                }
                );
            if (commentDictionary != null)
            {
                list = new List<BlogComment>();

                foreach (BlogComment comment in commentDictionary.Values)
                {
                    if (comment.ParentId == null)
                    {
                        list.Add(comment);
                    }
                    else
                    {

                        BlogComment parent = commentDictionary[comment.ParentId.Value];
                        if (parent != null)
                        {
                            if (parent.Replies == null)
                            {
                                parent.Replies = new List<BlogComment>();
                            }
                            parent.Replies.Add(comment);

                        }
                    }
                }
            }


            return list;
        }

        private static BlogComment MapBlogComment(IDataReader reader)
        {
            BlogComment p = new BlogComment();
            int ord = 0; //startingOrdinal

            p.Id = reader.GetInt32(ord++);
            p.Comment = reader.GetSafeString(ord++);
            p.DateCreated = reader.GetDateTime(ord++);
            p.BlogId = reader.GetSafeInt32(ord++);
            string userId = reader.GetSafeString(ord++);
            p.FirstName = reader.GetString(ord++);
            p.LastName = reader.GetSafeString(ord++);
            p.Email = reader.GetSafeString(ord++);
            p.PhotoKey = reader.GetSafeString(ord++);
            p.ParentId = reader.GetSafeInt32Nullable(ord++);
            p.Level = reader.GetSafeInt32(ord++);
            p.IsApproved = reader.GetSafeBool(ord++);



            return p;
        }

        public static int Post(BlogCommentAddRequest model)
        {
            int id = 0;
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.BlogComment_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameter(model, paramCollection);

                    SqlParameter p = new SqlParameter("@Id", System.Data.SqlDbType.Int);

                    p.Direction = ParameterDirection.Output;

                    paramCollection.Add(p);

                },
           returnParameters: delegate (SqlParameterCollection param)
           {
               int.TryParse(param["@Id"].Value.ToString(), out id);
               //id = (int)param["@Id"].Value;
           }
                );
            return id;

        }

        private static void MapCommonParameter(BlogCommentAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@Comment", model.Comment);
            paramCollection.AddWithValue("@BlogId", model.BlogId);
            paramCollection.AddWithValue("@ParentId", model.ParentId);
            paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
        }

        public static void Update(BlogCommentUpdateRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.BlogComment_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    MapCommonParameter(model, paramCollection);
                }
                );

            return;
        }

        public static void ApproveComment(int id)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.BlogComment_Approve",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                    
                }
                );

            return;
        }

        public static void Delete(int id)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.BlogComment_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@id", id);

                }
                );

            return;
        }

    }
}