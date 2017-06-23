using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Services
{
    public class JobApplicationService : BaseService, IJobApplicationService
    {
        public int Insert(JobApplicationAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.JobApplication_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@PersonId", model.PersonId);
                    paramCollection.AddWithValue("@JobPostingId", model.JobPostingId);
                    paramCollection.AddWithValue("@CoverLetter", model.CoverLetter ?? String.Empty);

                    SqlParameter p = new SqlParameter("@Id", SqlDbType.Int);
                    p.Direction = ParameterDirection.Output;

                    paramCollection.Add(p);
                }, returnParameters: delegate (SqlParameterCollection param)
                {
                    int.TryParse(param["@Id"].Value.ToString(), out id);
                }
                );
            return id;
        }
        public void Update(JobApplicationUpdateRequest model)
        {
            model.Notes = model.Notes ?? String.Empty;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.JobApplication_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    paramCollection.AddWithValue("@StatusId", model.StatusId);
                    paramCollection.AddWithValue("@Notes", model.Notes);
                }
                );
            return;
        }
        public void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.JobApplication_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );
            return;
        }
        public List<JobApplicationEmployer> SelectByStatusId(int jobPostingId, int statusId)
        {
            List<JobApplicationEmployer> jaList = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.JobApplication_SelectByStatusId",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@JobPostingId", jobPostingId);
                    paramCollection.AddWithValue("@StatusId", statusId);
                }
                , map: delegate (IDataReader reader, short set)
                {
                    switch (set)
                    {
                        case 0:
                            JobApplicationEmployer jpa = new JobApplicationEmployer();

                            int ord = 0;

                            jpa.Id = reader.GetSafeInt32(ord++);
                            jpa.PersonId = reader.GetSafeInt32(ord++);
                            jpa.FirstName = reader.GetSafeString(ord++);
                            jpa.LastName = reader.GetSafeString(ord++);
                            jpa.JobTitle = reader.GetSafeString(ord++);
                            jpa.Resume = reader.GetSafeString(ord++);
                            jpa.CoverLetter = reader.GetSafeString(ord++);
                            jpa.ApplicationStatus = reader.GetSafeString(ord++);
                            jpa.Notes = reader.GetSafeString(ord++);
                            jpa.DateCreated = reader.GetSafeDateTime(ord++);

                            if (jaList == null)
                            {
                                jaList = new List<JobApplicationEmployer>();
                            }
                            jaList.Add(jpa);
                            break;
                    }
                }
                );
            return jaList;
        }
        public List<JobApplicationUser> SelectByPersonId(int id)
        {
            List<JobApplicationUser> jaList = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.JobApplication_SelectByPersonId",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@PersonId", id);
                }
                , map: delegate (IDataReader reader, short set)
                {
                    switch (set)
                    {
                        case 0:
                            JobApplicationUser ja = MapJobApplication(reader);

                            if (jaList == null)
                            {
                                jaList = new List<JobApplicationUser>();
                            }
                            jaList.Add(ja);
                            break;

                        case 1:
                            JobPosting jp = MapJobPosting(reader);
                            JobApplicationUser jobApp = jaList.Find(app => app.JobPostingId == jp.Id);
                            jobApp.JobPosting = jp;
                            break;
                    }
                }
                );
            return jaList;
        }

        public List<JobApplicationStatus> SelectAllStatuses()
        {
            List<JobApplicationStatus> statusList = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.JobApplicationStatus_SelectAll",
                inputParamMapper: null,
                map: delegate (IDataReader reader, short set)
                {
                    JobApplicationStatus status = new JobApplicationStatus();

                    int ord = 0;

                    status.Id = reader.GetSafeInt32(ord++);
                    status.Name = reader.GetSafeString(ord++);

                    if (statusList == null)
                    {
                        statusList = new List<JobApplicationStatus>();
                    }
                    statusList.Add(status);
                }
                );

            return statusList;
        }

        private static JobApplicationUser MapJobApplication(IDataReader reader)
        {
            JobApplicationUser ja = new JobApplicationUser();
            int ord = 0;

            ja.Id           = reader.GetSafeInt32(ord++);
            ja.PersonId     = reader.GetSafeInt32(ord++);
            ja.JobPostingId = reader.GetSafeInt32(ord++);
            ja.CoverLetter  = reader.GetSafeString(ord++);
            ja.Status       = reader.GetSafeString(ord++);
            ja.DateCreated  = reader.GetSafeDateTime(ord++);
            ja.DateModified = reader.GetSafeDateTime(ord++);
            return ja;
        }

        private static JobPosting MapJobPosting(IDataReader reader)
        {
            int ord = 0;
            JobPosting jp = new JobPosting();
            jp.Id                  = reader.GetSafeInt32(ord++);
            jp.CompanyId           = reader.GetSafeInt32(ord++);
            jp.CompanyName         = reader.GetSafeString(ord++);
            jp.PositionName        = reader.GetSafeString(ord++);
            jp.StreetAddress       = reader.GetSafeString(ord++);
            jp.City                = reader.GetSafeString(ord++);
            jp.StateProvinceId     = reader.GetSafeInt32(ord++);
            jp.CountryId           = reader.GetSafeInt32(ord++);
            jp.Compensation        = reader.GetSafeInt32(ord++);
            jp.CompensationRateId  = reader.GetSafeInt32(ord++);
            jp.FullPartId          = reader.GetSafeInt32(ord++);
            jp.ContractPermanentId = reader.GetSafeInt32(ord++);
            jp.ExperienceLevelId   = reader.GetSafeInt32(ord++);
            jp.Description         = reader.GetSafeString(ord++);
            jp.Responsibilities    = reader.GetSafeString(ord++);
            jp.Requirements        = reader.GetSafeString(ord++);
            jp.ContactInformation  = reader.GetSafeString(ord++);
            jp.JobPostingStatusId  = reader.GetSafeInt32(ord++);
            jp.DateCreated         = reader.GetDateTime(ord++);
            jp.DateModified        = reader.GetDateTime(ord++);
            jp.CountryName         = reader.GetSafeString(ord++);
            jp.StateProvinceName   = reader.GetSafeString(ord++);
            jp.Latitude            = reader.GetSafeDouble(ord++);
            jp.Longitude           = reader.GetSafeDouble(ord++);
            return jp;
        }
    }
}