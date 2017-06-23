using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface IBlogService
    {
        void Delete(int id);
        int Insert(BlogAddRequest model);
        List<Blog> SelectAll();
        Blog SelectById(int id);
        void Update(BlogUpdateRequest model);
        List<Blog> Search(string searchStr);
        List<Blog> SelectAllByUserId();
    }
}