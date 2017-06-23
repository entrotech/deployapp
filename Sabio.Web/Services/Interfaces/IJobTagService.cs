using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface IJobTagService
    {
        void Delete(int id);
        int Insert(JobTagAddRequest model);
        List<JobTag> SelectAll();
        JobTag SelectById(int id);
        void Update(JobTagUpdateRequest model);
    }
}