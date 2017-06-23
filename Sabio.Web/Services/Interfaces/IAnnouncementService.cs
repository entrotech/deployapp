using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface IAnnouncementService  // 1.  Create THIS IS THE INTERFACE.
    {
        void Delete(int id);
        int Insert(AnnouncementAddRequest model);
        List<Announcement> SelectAll();
        Announcement SelectById(int id);
        void Update(AnnouncementUpdateRequest model);
        void ImageUpload(string photoKey, int id);
        void DeleteImage(int id);
        AnnouncementAndCategory SelectAllAnnouncementsAndCategories();
    }
}