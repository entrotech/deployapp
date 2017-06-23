using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Enums;

namespace Sabio.Web.Requests
{
    public interface IJobPostingService
    {
        void Delete(int id);
        int Insert(JobPostingAddRequest model);
        List<JobPosting> SelectAll();
        List<JobPosting> SearchByKeyword(JobPostingSearchRequest searchRequest);
        JobPosting SelectById(int id);
        void Update(JobPostingUpdateRequest model);
        void ClickLog(JobSearchEngine jobSearchEngine);
    }
}