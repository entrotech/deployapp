using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface IFileUploadService
    {
        string GetPhoto();
        string GetResume();
        void UpdatePhoto(string PhotoKey);
        void UpdateResume(string Resume);
        int InsertBlogPhoto(BlogPhotoAddRequest model);
        string Delete(int id);


    }
}