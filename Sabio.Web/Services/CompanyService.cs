using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Requests
{
    public class CompanyService : BaseService, ICompanyService
    {

        public int Insert(CompanyAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Company_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameters(model, paramCollection);


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
        public void Update(CompanyUpdateRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Company_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    MapCommonParameters(model, paramCollection);
                }
                );

            return;
        }
        public void Delete(int id)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Company_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);

                });

            return;
        }
        public List<Company> SelectAll()
        {
            List<Company> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Company_SelectAll"
               , inputParamMapper: null
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:                  
                           Company company = new Company();
                           company = MapCompany(reader);

                           if (list == null)
                           {
                               list = new List<Company>();
                           }
                           list.Add(company);
                           break;

                       case 1:
                           int companyId = 0;

                           JobPosting jobPosting = MapJobPostingList(reader, out companyId);
                           Company co = list.Find(item => item.Id == companyId);

                           if (co.JobPostings == null)
                           {
                               co.JobPostings = new List<JobPosting>();
                           }
                           co.JobPostings.Add(jobPosting);
                           break;

                       default:
                           break;
                   }


               });
            return list;
        }
        public Company SelectById(int id)
        {
            Company company = null;
            List<JobPosting> jpList = null;
            List<PersonBase> pList = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Company_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           company = MapCompany(reader);
                           break;

                       case 1:
                           int companyId = 0;

                           JobPosting jobPosting = MapJobPostingList(reader, out companyId);

                           if (jpList == null)
                           {
                               jpList = new List<JobPosting>();
                           }
                           jpList.Add(jobPosting);
                           break;
                       case 2:
                           int jobPostingId = 0;
                           JobTag jobTag = MapJobTagList(reader, out jobPostingId);
                           JobPosting jp = jpList.Find(item => item.Id == jobPostingId);
                           if (jp.JobTags == null)
                           {
                               jp.JobTags = new List<JobTag>();
                           }
                           jp.JobTags.Add(jobTag);
                           break;
                       case 3:
                           PersonBase person = new PersonBase();
                           int ord = 0;

                           person.Id = reader.GetSafeInt32(ord++);
                           person.FirstName = reader.GetSafeString(ord++);
                           person.LastName = reader.GetSafeString(ord++);
                           person.Email = reader.GetSafeString(ord++);

                           if (pList == null)
                           {
                               pList = new List<PersonBase>();
                           }
                           pList.Add(person);
                           break;
                   }
                   

               });
            company.JobPostings = jpList;
            company.People = pList;
            return company;
        }
        public List<Company> Search(string searchString)
        {
            List<Company> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Company_Search"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@SearchString", searchString);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           Company company = new Company();
                           company = MapCompany(reader);

                           if (list == null)
                           {
                               list = new List<Company>();
                           }
                           list.Add(company);
                           break;

                       case 1:
                           int companyId = 0;

                           JobPosting jobPosting = MapJobPostingList(reader, out companyId);
                           Company co = list.Find(item => item.Id == companyId);

                           if (co.JobPostings == null)
                           {
                               co.JobPostings = new List<JobPosting>();
                           }
                           co.JobPostings.Add(jobPosting);
                           break;

                       default:
                           break;
                   }


               });
            return list;
        }
        private static JobPosting MapJobPostingList(IDataReader reader, out int companyId)
        {
            JobPosting jp = new JobPosting();
            int ord = 0;
            companyId = reader.GetSafeInt32(ord++);
            jp.Id = reader.GetSafeInt32(ord++);
            jp.CompanyId = companyId;
            jp.CompanyName = reader.GetSafeString(ord++);
            jp.PositionName = reader.GetSafeString(ord++);
            jp.StreetAddress = reader.GetSafeString(ord++);
            jp.City = reader.GetSafeString(ord++);
            jp.StateProvinceId = reader.GetSafeInt32(ord++);
            jp.CountryId = reader.GetSafeInt32(ord++);
            jp.Compensation = reader.GetSafeInt32(ord++);
            jp.CompensationRateId = reader.GetSafeInt32(ord++);
            jp.FullPartId = reader.GetSafeInt32(ord++);
            jp.ContractPermanentId = reader.GetSafeInt32(ord++);
            jp.ExperienceLevelId = reader.GetSafeInt32(ord++);
            jp.Description = reader.GetSafeString(ord++);
            jp.Responsibilities = reader.GetSafeString(ord++);
            jp.Requirements = reader.GetSafeString(ord++);
            jp.ContactInformation = reader.GetSafeString(ord++);
            jp.JobPostingStatusId = reader.GetSafeInt32(ord++);
            jp.DateCreated = reader.GetDateTime(ord++);
            jp.DateModified = reader.GetDateTime(ord++);
            jp.CountryName = reader.GetSafeString(ord++);
            jp.StateProvinceName = reader.GetSafeString(ord++);
            return jp;
        }

        private static Company MapCompany(IDataReader reader)
        {
            Company company = new Company();
            int startingIndex = 0; //startingOrdinal
            company.Id = reader.GetSafeInt32(startingIndex++);
            company.DateCreated = reader.GetSafeDateTime(startingIndex++);
            company.DateModified = reader.GetSafeDateTime(startingIndex++);
            company.Name = reader.GetSafeString(startingIndex++);
            company.PhoneNumber = reader.GetSafeString(startingIndex++);
            company.Email = reader.GetSafeString(startingIndex++);
            company.Address1 = reader.GetSafeString(startingIndex++);
            company.Address2 = reader.GetSafeString(startingIndex++);
            company.City = reader.GetSafeString(startingIndex++);
            int stateProvinceId = reader.GetSafeInt32(startingIndex++);
            if (stateProvinceId > 0)
            {
                company.StateProvince = new StateProvinceBase();
                company.StateProvince.Id = stateProvinceId;
                company.StateProvince.Code = reader.GetSafeString(startingIndex++);
                company.StateProvince.Name = reader.GetSafeString(startingIndex++);

            }
            else
            {
                startingIndex += 2;
            }
            int countryId = reader.GetSafeInt32(startingIndex++);
            if (countryId > 0)
            {
                company.Country = new Country();
                company.Country.Id = countryId;
                company.Country.LongCode = reader.GetSafeString(startingIndex++);
                company.Country.Code = reader.GetSafeString(startingIndex++);
                company.Country.Name = reader.GetSafeString(startingIndex++);
            }
            else
            {
                startingIndex += 3;
            }
            company.PostalCode = reader.GetSafeString(startingIndex++);
            company.Inactive = reader.GetSafeBool(startingIndex++);
            company.IsDeploy = reader.GetSafeBool(startingIndex++);
            return company;
        }
        private static JobTag MapJobTagList(IDataReader reader, out int jobPostingId)
        {
            JobTag jt = new JobTag();
            int ord = 0;
            jobPostingId = reader.GetSafeInt32(ord++);
            jt.Id = reader.GetSafeInt32(ord++);
            jt.Keyword = reader.GetSafeString(ord++);
            jt.DisplayOrder = reader.GetSafeInt32(ord++);
            return jt;
        }
        private void MapCommonParameters(CompanyAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@CompanyName", model.Name);
            paramCollection.AddWithValue("@CompanyPhoneNumber", model.PhoneNumber);
            paramCollection.AddWithValue("@CompanyEmail", model.Email);
            paramCollection.AddWithValue("@Address1", model.Address1);
            paramCollection.AddWithValue("@Address2", model.Address2);
            paramCollection.AddWithValue("@City", model.City);
            paramCollection.AddWithValue("@StateProvinceId", model.StateProvinceId);
            paramCollection.AddWithValue("@CountryId", model.CountryId);
            paramCollection.AddWithValue("@CompanyIdCreated", UserService.GetCurrentUserId());
            paramCollection.AddWithValue("@PostalCode", model.PostalCode);
            paramCollection.AddWithValue("@Inactive", model.Inactive);
            paramCollection.AddWithValue("@IsDeploy", model.IsDeploy);
            paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
        }
    }
}

