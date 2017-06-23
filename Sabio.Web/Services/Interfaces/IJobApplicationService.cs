using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Services
{
    public interface IJobApplicationService
    {
        void Delete(int id);
        int Insert(JobApplicationAddRequest model);
        List<JobApplicationUser> SelectByPersonId(int id);
        List<JobApplicationEmployer> SelectByStatusId(int jobPostingId, int statusId);
        void Update(JobApplicationUpdateRequest model);
        List<JobApplicationStatus> SelectAllStatuses();
    }
}