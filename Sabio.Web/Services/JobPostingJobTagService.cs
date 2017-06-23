using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Services
{
    public class JobPostingJobTagService : BaseService, IJobPostingJobTagService
    {
        public List<JobTag> SelectJobTags(int id)
        {
            List<JobTag> list = new List<JobTag>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.JobPostingJobTag_SelectByJobPostingId",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@JobPostingId", id);

               },
               map: (Action<IDataReader, short>)delegate (IDataReader reader, short set)
               {
                   JobTag jobTag = new JobTag();
                   int startingIndex = 0; //startingOrdinal

                   jobTag.Id = reader.GetInt32(startingIndex++);
                   jobTag.Keyword = reader.GetString(startingIndex++);

                   list.Add(jobTag);

               }
               );

            return list;
        }
        public List<JobPosting> SelectJobPostings(int id)
        {
            List<JobPosting> list = new List<JobPosting>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.JobPostingJobTag_SelectByJobTagId",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@JobTagId", id);

               },
               map: (Action<IDataReader, short>)delegate (IDataReader reader, short set)
               {
                   JobPosting jobPosting = new JobPosting();
                   int startingIndex = 0; //startingOrdinal

                   jobPosting.Id = reader.GetInt32(startingIndex++);
                   jobPosting.CompanyName = reader.GetString(startingIndex++);
                   jobPosting.PositionName = reader.GetString(startingIndex++);
                   jobPosting.City = reader.GetString(startingIndex++);
                   jobPosting.StateProvinceId = reader.GetInt32(startingIndex++);
                   jobPosting.CountryId = reader.GetInt32(startingIndex++);
                   jobPosting.Compensation = reader.GetSafeInt32(startingIndex++);
                   jobPosting.CompensationRateId = reader.GetSafeInt32(startingIndex++);
                   jobPosting.FullPartId = reader.GetSafeInt32(startingIndex++);
                   jobPosting.ContractPermanentId = reader.GetSafeInt32(startingIndex++);
                   jobPosting.ExperienceLevelId = reader.GetSafeInt32(startingIndex++);
                   jobPosting.Description = reader.GetString(startingIndex++);
                   jobPosting.Responsibilities = reader.GetString(startingIndex++);
                   jobPosting.Requirements = reader.GetString(startingIndex++);
                   jobPosting.ContactInformation = reader.GetString(startingIndex++);
                   jobPosting.JobPostingStatusId = reader.GetInt32(startingIndex++);

                   list.Add(jobPosting);

               }
               );

            return list;
        }
        public void Insert(JobPostingJobTagAddRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.JobPostingJobTag_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@JobPostingId", model.JobPostingId);
                    paramCollection.AddWithValue("@JobTagId", model.JobTagId);

                }, returnParameters: null
                );

            return;
        }
    }
}