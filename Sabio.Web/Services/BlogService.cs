using System;
using System.Collections.Generic;
using System.Linq;
using Sabio.Web.Models.Requests;
using System.Data.SqlClient;
using Sabio.Web.Models.Responses;
using Sabio.Web.Domain;
using System.Web;
using System.Data;
using Sabio.Data;
using Sabio.Web.Services;

namespace Sabio.Web.Requests
{
    public class BlogService : BaseService, IBlogService
    {
        public int Insert(BlogAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Blog_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameters(model, paramCollection);

                    SqlParameter p = new SqlParameter("@id", SqlDbType.Int);
                    p.Direction = ParameterDirection.Output;

                    paramCollection.Add(p);
                }, returnParameters: delegate (SqlParameterCollection param)
                {
                    Int32.TryParse(param["@id"].Value.ToString(), out id);
                }
                );

            return id;
        }
        public void Update(BlogUpdateRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Blog_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@id", model.Id);
                    MapCommonParameters(model, paramCollection);
                }
                );

            return;
        }

        public Blog SelectById(int id)
        {
            Blog blog = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Blog_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@id", id);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           blog = MapBlog(reader);
                           break;
                       case 1:
                           int blogId = 0;
                           BlogTag tag = MapBlogTag(reader, out blogId);
                           if (blog.Tags == null)
                           {
                               blog.Tags = new List<BlogTag>();
                           }
                           blog.Tags.Add(tag);
                           break;
                       case 2:
                          //  int blogId = 0;
                           BlogPhoto photo = MapBlogPhoto(reader, out blogId);
                           if (blog.Photos == null)
                           {
                               blog.Photos = new List<BlogPhoto>();
                           }
                           blog.Photos.Add(photo);
                           break;

                   }
               }
               );
            return blog;
        }

        public List<Blog> SelectAll()
        {

            List<Blog> list = new List<Blog>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.Blog_SelectAll",
               inputParamMapper: null,
               map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           Blog b = MapBlog(reader);
                           if (list == null)
                           {
                               list = new List<Blog>();
                           }
                           list.Add(b);
                           break;
                       case 1:
                           int blogId = 0;
                           BlogTag tag = MapBlogTag(reader, out blogId);
                           Blog d = list.Find(item => item.Id == blogId);
                           if (d.Tags == null)
                           {
                               d.Tags = new List<BlogTag>();
                              
                           }
                           d.Tags.Add(tag);
                           break;
                       case 2:
                            
                           BlogPhoto photo = MapBlogPhoto(reader, out blogId);
                           Blog bl = list.Find(item => item.Id == blogId);
                           if (bl.Photos == null)
                           {
                               bl.Photos = new List<BlogPhoto>();
                           }
                           bl.Photos.Add(photo);
                           break;
                   }
               }
               );

            return list;
        }
        public List<Blog> Search(string searchStr)
        {

            List<Blog> list = new List<Blog>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.Blog_Search2",
               inputParamMapper:  delegate (SqlParameterCollection paramCollection) {
                paramCollection.AddWithValue("@searchStr", searchStr);
            },
    
               map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           Blog b = MapBlog(reader);
                           if (list == null)
                           {
                               list = new List<Blog>();
                           }
                           list.Add(b);
                           break;
                       case 1:
                           int blogId = 0;
                           BlogTag tag = MapBlogTag(reader, out blogId);
                           Blog d = list.Find(item => item.Id == blogId);
                           if (d.Tags == null)
                           {
                               d.Tags = new List<BlogTag>();

                           }
                           d.Tags.Add(tag);
                           break;
                       case 2:

                           BlogPhoto photo = MapBlogPhoto(reader, out blogId);
                           Blog bl = list.Find(item => item.Id == blogId);
                           if (bl.Photos == null)
                           {
                               bl.Photos = new List<BlogPhoto>();
                           }
                           bl.Photos.Add(photo);
                           break;
                   }
               }
               );

            return list;
        }
        public void Delete(int id)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Blog_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@id", id);

                }
                );

            return;
        }

        public List<Blog> SelectAllByUserId()
        {

            List<Blog> list = new List<Blog>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.Blog_SelectAllByUserId",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@UseridCreated", UserService.GetCurrentUserId());

                },
               map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           Blog b = MapBlog(reader);
                           if (list == null)
                           {
                               list = new List<Blog>();
                           }
                           list.Add(b);
                           break;
                       case 1:
                           int blogId = 0;
                           BlogTag tag = MapBlogTag(reader, out blogId);
                           Blog d = list.Find(item => item.Id == blogId);
                           if (d.Tags == null)
                           {
                               d.Tags = new List<BlogTag>();

                           }
                           d.Tags.Add(tag);
                           break;
                       case 2:

                           BlogPhoto photo = MapBlogPhoto(reader, out blogId);
                           Blog bl = list.Find(item => item.Id == blogId);
                           if (bl.Photos == null)
                           {
                               bl.Photos = new List<BlogPhoto>();
                           }
                           bl.Photos.Add(photo);
                           break;
                   }
               }
               );

            return list;
        }
        internal static void MapCommonParameters(BlogAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@userIdCreated", UserService.GetCurrentUserId());
            paramCollection.AddWithValue("@title", model.Title);
            paramCollection.AddWithValue("@body", model.Body);
            paramCollection.AddWithValue("@blogCategory", model.BlogCategory);
            paramCollection.AddWithValue("@private", model.Private);

            DataTable BlogTagIdArray = new DataTable();
            BlogTagIdArray.Columns.Add("BlogTagId", typeof(Int32));
            if (model.BlogTagIds != null)
            {
                for (int i = 0; i < model.BlogTagIds.Count; i++)
                {
                    BlogTagIdArray.Rows.Add(model.BlogTagIds[i]);
                }
            }
            SqlParameter BlogTagIdTable = new SqlParameter();
            BlogTagIdTable.ParameterName = "@blogTagIds";
            BlogTagIdTable.SqlDbType = System.Data.SqlDbType.Structured;
            BlogTagIdTable.Value = BlogTagIdArray;
            paramCollection.Add(BlogTagIdTable);
        }

        internal static Blog MapBlog(IDataReader reader)
        {
            Blog blog = new Blog();
            int startingIndex = 0; //startingOrdinal

            blog.Id = reader.GetSafeInt32(startingIndex++);
            blog.UserIdCreated = reader.GetSafeString(startingIndex++);
            blog.Title = reader.GetSafeString(startingIndex++);
            blog.Body = reader.GetSafeString(startingIndex++);
            blog.BlogCategory = reader.GetSafeString(startingIndex++);
            blog.Private = reader.GetSafeBool(startingIndex++);
            blog.DateCreated = reader.GetDateTime(startingIndex++);
            blog.DateModified = reader.GetDateTime(startingIndex++);
            blog.Email = reader.GetSafeString(startingIndex++);
            blog.FirstName = reader.GetSafeString(startingIndex++);
            blog.LastName = reader.GetSafeString(startingIndex++);
            blog.PhotoKey = reader.GetSafeString(startingIndex++);


            return blog;
        }
        internal static BlogTag MapBlogTag(IDataReader reader, out int blogId)
        {
            BlogTag blogTag = new Domain.BlogTag();
            int startingIndex = 0;

            blogId = reader.GetSafeInt32(startingIndex++);

            blogTag.Id = reader.GetSafeInt32(startingIndex++);
            blogTag.Keyword = reader.GetSafeString(startingIndex++);

            return blogTag;
        }

        internal static BlogPhoto MapBlogPhoto(IDataReader reader, out int blogId)
        {
            BlogPhoto blogPhoto = new Domain.BlogPhoto();
            int startingIndex = 0;

            blogId = reader.GetSafeInt32(startingIndex++);
           blogPhoto.Id = reader.GetSafeInt32(startingIndex++);
            blogPhoto.BlogPhotoKey = reader.GetSafeString(startingIndex++);

            return blogPhoto;
        }
        //public List<Blogs> Search_deprecated(BlogSearchRequest model)
        //{
        //    List<Blogs> list = null;

        //    DataProvider.ExecuteCmd(GetConnection, "dbo.blog_Search",
        //       inputParamMapper: delegate (SqlParameterCollection paramCollection)
        //       {
        //           paramCollection.AddWithValue("@SearchStr", model.SearchStr);
        //           paramCollection.AddWithValue("@Category", model.Category);
        //           paramCollection.AddWithValue("@CurrentPage", model.CurrentPage);
        //           paramCollection.AddWithValue("@ItemsPerPage", model.ItemsPerPage);
        //       }
        //       , map: delegate (IDataReader reader, short set)
        //       {
        //           switch (set)
        //           {
        //               case 0:

        //                   Blogs blog = new Blogs();
        //                   int startingIndex = 0; //startingOrdinal
        //                   blog.Id = reader.GetSafeInt32(startingIndex++);
        //                   blog.UserIdCreated = reader.GetSafeString(startingIndex++);
        //                   blog.Title = reader.GetSafeString(startingIndex++);
        //                   blog.Body = reader.GetSafeString(startingIndex++);
        //                   blog.BlogCategory = reader.GetSafeString(startingIndex++);
        //                   blog.Private = reader.GetSafeBool(startingIndex++);
        //                   blog.DateCreated = reader.GetDateTime(startingIndex++);
        //                   blog.DateModified = reader.GetDateTime(startingIndex++);
        //                   blog.noOfRows = reader.GetSafeInt32(startingIndex++);


        //                   if (list == null)
        //                   {
        //                       list = new List<Blogs>();
        //                   }

        //                   list.Add(blog);
        //                   break;
        //           }
        //       }
        //       );

        //    return list;
        //}

    }
}
