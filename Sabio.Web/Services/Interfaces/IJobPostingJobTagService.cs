using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface IJobPostingJobTagService
    {
        void Insert(JobPostingJobTagAddRequest model);
        List<JobPosting> SelectJobPostings(int id);
        List<JobTag> SelectJobTags(int id);
    }
}