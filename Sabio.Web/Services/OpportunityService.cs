using Amazon.Auth.AccessControlPolicy;
using Sabio.Web.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Sabio.Web.Domain;
using Sabio.Data;
using Sabio.Web.Requests;
using Sabio.Web.Requests.Interfaces;

namespace Sabio.Web.Services
{
    public class OpportunityService : BaseService, IOpportunityService
    {
        public int Insert(OpportunityAddRequest model)
        {
            int id = 0;
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Opportunity_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameters(model, paramCollection);

                    SqlParameter p = new SqlParameter("@Id", SqlDbType.Int);
                    p.Direction = ParameterDirection.Output;
                    paramCollection.Add(p);


                }, returnParameters: delegate (SqlParameterCollection param)
                {
                    int.TryParse(param["@Id"].Value.ToString(), out id);  // if this is skipped usually means the stored proc failed.  this time Insert and Update procs needed "=null" added.
                }
                );

            return id;
        }


        public void Update(OpportunityUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Opportunity_Update",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", model.Id);
                   paramCollection.AddWithValue("@Name", model.Name);
                   paramCollection.AddWithValue("@Description", model.Description);
                   paramCollection.AddWithValue("@ContactPersonFirstName", model.ContactPersonFirstName);
                   paramCollection.AddWithValue("@ContactPersonLastName", model.ContactPersonLastName);
                   paramCollection.AddWithValue("@Email", model.Email);
                   paramCollection.AddWithValue("@Phone", model.Phone);
                   paramCollection.AddWithValue("@Address1", model.Address1);
                   paramCollection.AddWithValue("@Address2", model.Address2);
                   paramCollection.AddWithValue("@City", model.City);
                   paramCollection.AddWithValue("@StateProvinceId", model.StateProvinceId);
                   paramCollection.AddWithValue("@PostalCode", model.PostalCode);
                   paramCollection.AddWithValue("@CountryId", model.CountryId);
                   paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
                   paramCollection.AddWithValue("@DateTimePickerStart", model.DateTimeStart);  
                   paramCollection.AddWithValue("@DateTimePickerEnd", model.DateTimeEnd);      
               }
           );

            return;
        }

        public Opportunity SelectById(int id)
        {
            Opportunity opportunity = null;  // update variable name to opportunity

            DataProvider.ExecuteCmd(GetConnection, "dbo.Opportunity_SelectById",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                },
                map: delegate (IDataReader reader, short set)
                {
                    opportunity = new Opportunity();
                    int startingIndex = 0;

                    opportunity.Id = reader.GetSafeInt32(startingIndex++);  
                    opportunity.Name = reader.GetSafeString(startingIndex++);
                    opportunity.Description = reader.GetSafeString(startingIndex++);
                    opportunity.ContactPersonFirstName = reader.GetSafeString(startingIndex++);
                    opportunity.ContactPersonLastName = reader.GetSafeString(startingIndex++);
                    opportunity.Email = reader.GetSafeString(startingIndex++);
                    opportunity.Phone = reader.GetSafeString(startingIndex++);
                    opportunity.Address1 = reader.GetSafeString(startingIndex++);
                    opportunity.Address2 = reader.GetSafeString(startingIndex++);
                    opportunity.City = reader.GetSafeString(startingIndex++);
                    int stateProvinceId = reader.GetSafeInt32(startingIndex++);
                    if (stateProvinceId > 0)
                    {
                        opportunity.StateProvince = new StateProvinceBase();
                        opportunity.StateProvince.Id = stateProvinceId;
                        opportunity.StateProvince.Code = reader.GetSafeString(startingIndex++);
                        opportunity.StateProvince.Name = reader.GetSafeString(startingIndex++);
                    }
                    else
                    {
                        opportunity.StateProvince = new StateProvinceBase();
                        startingIndex += 2;  
                    }
                    opportunity.PostalCode = reader.GetSafeString(startingIndex++);
                    int countryId = reader.GetSafeInt32(startingIndex++);
                    if (countryId > 0)
                    {
                        opportunity.Country = new Country();
                        opportunity.Country.Id = countryId;
                        opportunity.Country.Name = reader.GetSafeString(startingIndex++);
                        opportunity.Country.Code = reader.GetSafeString(startingIndex++);
                        opportunity.Country.LongCode = reader.GetSafeString(startingIndex++);
                    }
                    else
                    {
                        opportunity.Country = new Country();
                        startingIndex += 3;
                    }
                    opportunity.DateTimeStart = reader.GetSafeUtcDateTime(startingIndex++);
                    opportunity.DateTimeEnd = reader.GetSafeUtcDateTime(startingIndex++);
                },

                returnParameters: null,  // added this

                cmdModifier: null       // added this

                );
            return opportunity;//
        }

        public List<Opportunity> SelectAll()
        {
            List<Opportunity> list = new List<Opportunity>();
            int r = 0; // added for get rows

            DataProvider.ExecuteCmd(GetConnection, "dbo.Opportunity_SelectAll",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                },
                map: delegate (IDataReader reader, short set)
                {
                    //Opportunity p = MapOpportunity(reader);
                    Opportunity p = MapOpportunity(reader, out r);

                    list.Add(p);
                },

                returnParameters: null,  // added this

                cmdModifier: null       // added this

                );

            return list;//
        }

        public void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Opportunity_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );
            return;
        }

        public List<Opportunity> Search(OpportunitySearchRequest model, out int totalRows)
        {
            List<Opportunity> list = null;
            int r = 0;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Opportunity_Search"
                , inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@SearchString", model.SearchString);
                    paramCollection.AddWithValue("@CurrentPage", model.CurrentPage);
                    paramCollection.AddWithValue("@ItemsPerPage", model.ItemsPerPage);
                    paramCollection.AddWithValue("@BeginDate", model.BeginDate);
                    paramCollection.AddWithValue("@EndDate", model.EndDate);
                    paramCollection.AddWithValue("@SortByColumn", model.SortByColumn);
                    paramCollection.AddWithValue("@Descending", model.Descending);
                }
                , map: delegate (IDataReader reader, short set)
                {
                    switch (set)
                    {
                        case 0:

                            Opportunity o = MapOpportunity(reader, out r);

                            if (list == null)
                            {
                                list = new List<Opportunity>();
                            }
                            list.Add(o);
                            break;
                    }
                });
            totalRows = r;
            return list;
        }

        private static void MapCommonParameters(OpportunityAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@Name", model.Name);
            paramCollection.AddWithValue("@Description", model.Description);
            paramCollection.AddWithValue("@ContactPersonFirstName", model.ContactPersonFirstName);
            paramCollection.AddWithValue("@ContactPersonLastName", model.ContactPersonLastName);
            paramCollection.AddWithValue("@Email", model.Email);
            paramCollection.AddWithValue("@Phone", model.Phone);
            paramCollection.AddWithValue("@Address1", model.Address1);
            paramCollection.AddWithValue("@Address2", model.Address2);
            paramCollection.AddWithValue("@City", model.City);
            paramCollection.AddWithValue("@StateProvinceId", model.StateProvinceId);
            paramCollection.AddWithValue("@PostalCode", model.PostalCode);
            paramCollection.AddWithValue("@CountryId", model.CountryId);
            string aspnetuserid = UserService.GetCurrentUserId();
            paramCollection.AddWithValue("@UserIdCreated", aspnetuserid);
            paramCollection.AddWithValue("@DateTimePickerStart", model.DateTimeStart);
            paramCollection.AddWithValue("@DateTimePickerEnd", model.DateTimeEnd);
        }
      
        private static Opportunity MapOpportunity(IDataReader reader, out int r)
        {
            //int r = 0;
            r = 0;

            Opportunity p = new Opportunity();
            int startingIndex = 0;    // this number is dependant on the columns one decides to include.

            p.Id = reader.GetSafeInt32(startingIndex++);
            p.Name = reader.GetSafeString(startingIndex++);
            p.Description = reader.GetSafeString(startingIndex++);
            p.ContactPersonFirstName = reader.GetSafeString(startingIndex++);
            p.ContactPersonLastName = reader.GetSafeString(startingIndex++);
            p.Email = reader.GetSafeString(startingIndex++);
            p.Phone = reader.GetSafeString(startingIndex++);
            p.Address1 = reader.GetSafeString(startingIndex++);
            p.Address2 = reader.GetSafeString(startingIndex++);
            p.City = reader.GetSafeString(startingIndex++);
            int stateProvinceId = reader.GetSafeInt32(startingIndex++);
            if (stateProvinceId > 0)
            {
                p.StateProvince = new StateProvinceBase();
                p.StateProvince.Id = stateProvinceId;
                p.StateProvince.Code = reader.GetSafeString(startingIndex++);
                p.StateProvince.Name = reader.GetSafeString(startingIndex++);
            }
            else
            {
                //p.StateProvince = new StateProvinceBase();
                startingIndex += 2;
            }
            p.PostalCode = reader.GetSafeString(startingIndex++);
            int countryId = reader.GetSafeInt32(startingIndex++);
            if (countryId > 0)
            {
                p.Country = new Country();
                p.Country.Id = countryId;
                p.Country.Name = reader.GetSafeString(startingIndex++);
                p.Country.Code = reader.GetSafeString(startingIndex++);
                p.Country.LongCode = reader.GetSafeString(startingIndex++);
            }
            else
            {
                p.Country = new Country();
                startingIndex += 3;
            }
            p.DateTimeStart = reader.GetSafeDateTime(startingIndex++);
            p.DateTimeEnd = reader.GetSafeDateTime(startingIndex++);

            r = reader.GetSafeInt32(startingIndex++);


            return p;
        }

    }
}