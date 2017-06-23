using Sabio.Web.Models.Requests;
using Sabio.Web.Requests;
using System;
using System.Data;
using System.Data.SqlClient;

namespace Sabio.Web.Services
{
    public class FileUploadService : BaseService, IFileUploadService
    {
        public void UpdatePhoto(string PhotoKey)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Person_InsertPhotoKey",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@PhotoKey", PhotoKey);
                    paramCollection.AddWithValue("@ASPNetUserId", UserService.GetCurrentUserId());
                }
                );
            return;
        }

        public int InsertBlogPhoto(BlogPhotoAddRequest model)
        {
            int id = 0;
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Blog_InsertPhotoKey",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@PhotoKey", model.BlogPhotoKey);
                    paramCollection.AddWithValue("@BlogId", model.BlogId);
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

        public string GetPhoto()
        {
            string photoKey = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.Person_GetPhotoKey",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@ASPNetUserId", UserService.GetCurrentUserId());
                }
                 , map: delegate (IDataReader reader, short set)
                 {
                     int startingIndex = 0;

                     photoKey = reader.GetString(startingIndex++);
                 }

                );
            return photoKey;
        }

        public void UpdateResume(string Resume)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Person_Resume",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Resume", Resume);
                    paramCollection.AddWithValue("@ASPNetUserId", UserService.GetCurrentUserId());
                }
                );
            return;
        }

        public string Delete(int id)
        {
            string fileName = null;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Blog_DeletePhoto",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                  
                    SqlParameter p = new SqlParameter("@fileName", SqlDbType.NVarChar, 150);
                    p.Direction = ParameterDirection.Output;
                    paramCollection.Add(p);
                }, returnParameters: delegate (SqlParameterCollection param)
                {
                    fileName = (string)(param["@fileName"].Value.ToString());

                });
            return fileName;
        }

        public string GetResume()
        {
            string Resume = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.Person_GetResume",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@ASPNetUserId", UserService.GetCurrentUserId());
                }
                 , map: delegate (IDataReader reader, short set)
                 {
                     int startingIndex = 0;

                     Resume = reader.GetString(startingIndex++);
                 }

                );
            return Resume;
        }
    }
}