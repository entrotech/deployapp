using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Sabio.Web.Services
{
    public class BlogServiceAdo : BaseService, IBlogService
    {
        public void Delete(int id)
        {
            string connectiongString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectiongString))
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.blog_delete";
                    SqlParameterCollection paramCollection = cmd.Parameters;
                    paramCollection.AddWithValue("@Id",id);
                    cmd.ExecuteNonQuery();

                }
            }
        }

        public int Insert(BlogAddRequest model)
        {
            int id = 0;
            string connectiongString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectiongString))
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.blog_insert";
                    SqlParameterCollection paramCollection = cmd.Parameters;
                    BlogService.MapCommonParameters(model, paramCollection);
                    SqlParameter p = new SqlParameter("@id", SqlDbType.Int);
                    p.Direction = ParameterDirection.Output;
                    paramCollection.Add(p);
                    
                    


                    cmd.ExecuteNonQuery();
                    id = Convert.ToInt32(paramCollection["@id"].Value);
                }
            }
            return id;
        }

        public List<Blog> Search(string searchStr)
        {
            List<Blog> blogs = null;
            string connectiongString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectiongString))
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.blog_search2";
                    SqlParameterCollection paramCollection = cmd.Parameters;
                    paramCollection.AddWithValue("@searchStr", searchStr);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Blog blog = BlogService.MapBlog(reader);
                        if (blogs == null)
                        {
                            blogs = new List<Blog>();
                        }

                        blogs.Add(blog);


                    }
                    reader.NextResult();
                    while (reader.Read())
                    {
                        int blogId = 0;
                        BlogTag tag = BlogService.MapBlogTag(reader, out blogId);
                        Blog d = blogs.Find(item => item.Id == blogId);
                        if (d.Tags == null)
                        {
                            d.Tags = new List<BlogTag>();

                        }
                        d.Tags.Add(tag);

                    }
                    reader.NextResult();
                    while (reader.Read())
                    {
                        int blogId = 0;
                        BlogPhoto photo = BlogService.MapBlogPhoto(reader, out blogId);
                        Blog bl = blogs.Find(item => item.Id == blogId);
                        if (bl.Photos == null)
                        {
                            bl.Photos = new List<BlogPhoto>();
                        }
                        bl.Photos.Add(photo);
                    }
                }

            }



            return blogs;
        }

        public List<Blog> SelectAll()
        {
            List<Blog> blogs = null;
            string connectiongString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectiongString))
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.blog_selectAll";
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Blog blog = BlogService.MapBlog(reader);
                        if (blogs == null)
                        {
                            blogs = new List<Blog>();
                        }

                        blogs.Add(blog);


                    }
                    reader.NextResult();
                    while (reader.Read())
                    {
                        int blogId = 0;
                        BlogTag tag = BlogService.MapBlogTag(reader, out blogId);
                        Blog d = blogs.Find(item => item.Id == blogId);
                        if (d.Tags == null)
                        {
                            d.Tags = new List<BlogTag>();

                        }
                        d.Tags.Add(tag);

                    }
                    reader.NextResult();
                    while (reader.Read())
                    {
                        int blogId = 0;
                        BlogPhoto photo = BlogService.MapBlogPhoto(reader, out blogId);
                        Blog bl = blogs.Find(item => item.Id == blogId);
                        if (bl.Photos == null)
                        {
                            bl.Photos = new List<BlogPhoto>();
                        }
                        bl.Photos.Add(photo);
                    }
                }

            }



            return blogs;
        }

        public List<Blog> SelectAllByUserId()
        {
            List<Blog> blogs = null;
            Blog blog = null;
            string connectiongString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectiongString))
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.Blog_SelectAllByUserId";
                    SqlParameterCollection paramCollection = cmd.Parameters;
                    paramCollection.AddWithValue("@UseridCreated", UserService.GetCurrentUserId());
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        blog = BlogService.MapBlog(reader);
                        if (blogs == null)
                        {
                            blogs = new List<Blog>();
                        }

                        blogs.Add(blog);


                    }
                    reader.NextResult();
                    while (reader.Read())
                    {
                        int blogId = 0;
                        BlogTag tag = BlogService.MapBlogTag(reader, out blogId);
                         blog = blogs.Find(item => item.Id == blogId);
                        if (blog.Tags == null)
                        {
                            blog.Tags = new List<BlogTag>();

                        }
                        blog.Tags.Add(tag);

                    }
                    reader.NextResult();
                    while (reader.Read())
                    {
                        int blogId = 0;
                        BlogPhoto photo = BlogService.MapBlogPhoto(reader, out blogId);
                       blog = blogs.Find(item => item.Id == blogId);
                        if (blog.Photos == null)
                        {
                            blog.Photos = new List<BlogPhoto>();
                        }
                        blog.Photos.Add(photo);
                    }
                }

            }



            return blogs;
        }

        public Blog SelectById(int id)
        {
            Blog blog = null;
            string connectiongString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectiongString))
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.blog_selectById";
                    SqlParameterCollection paramCollection = cmd.Parameters;
                    paramCollection.AddWithValue("@Id", id);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        blog = BlogService.MapBlog(reader);
                        if (blog == null)
                        {
                            blog = new Blog();
                        }
                        

                    }
                    reader.NextResult();
                    while (reader.Read())
                    {
                        int blogId = 0;
                        BlogTag tag = BlogService.MapBlogTag(reader, out blogId);
                      
                        if (blog.Tags == null)
                        {
                            blog.Tags = new List<BlogTag>();

                        }
                        blog.Tags.Add(tag);

                    }
                    reader.NextResult();
                    while (reader.Read())
                    {
                        int blogId = 0;
                        BlogPhoto photo = BlogService.MapBlogPhoto(reader, out blogId);
                      
                        if (blog.Photos == null)
                        {
                            blog.Photos = new List<BlogPhoto>();
                        }
                        blog.Photos.Add(photo);
                    }
                }

            }
            return blog;

        }

        public void Update(BlogUpdateRequest model)
        {
            string connectiongString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectiongString))
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.blog_update";
                    SqlParameterCollection paramCollection = cmd.Parameters;
                    BlogService.MapCommonParameters(model, paramCollection);
                    paramCollection.AddWithValue("@Id", model.Id);
                    cmd.ExecuteNonQuery();

                }
            }
        }
    }
}