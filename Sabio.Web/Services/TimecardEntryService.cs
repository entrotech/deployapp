using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System;

namespace Sabio.Web.Services
{
    public class TimecardEntryService : BaseService, ITimecardEntryService
    {

        public List<TimecardEntry> Search(TimecardEntrySearchRequest model)
        {
            List<TimecardEntry> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.TimecardEntry_Search",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", model.Id);
                   paramCollection.AddWithValue("@ProjectId", model.ProjectId);
                   paramCollection.AddWithValue("@PersonId", model.PersonId);
                   paramCollection.AddWithValue("@TimecardStatusId", model.TimecardStatusId);
                   paramCollection.AddWithValue("@StartDateTimeUtc", model.StartDateTimeUtc);
                   paramCollection.AddWithValue("@StartDateTimeLocal", model.StartDateTimeLocal);
                   paramCollection.AddWithValue("@EndDateTimeUtc", model.EndDateTimeUtc);
                   paramCollection.AddWithValue("@EndDateTimeLocal", model.EndDateTimeLocal);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:

                           TimecardEntry a = new TimecardEntry();
                           int ord = 0; //startingOrdinal

                           a.Id = reader.GetSafeInt32(ord++);
                           a.ProjectId = reader.GetSafeInt32(ord++);
                           a.ProjectName = reader.GetSafeString(ord++);
                           a.FirstName = reader.GetSafeString(ord++);
                           a.LastName = reader.GetSafeString(ord++);
                           a.PersonId = reader.GetSafeInt32(ord++);
                           a.TimecardStatusId = reader.GetSafeInt32(ord++);
                           a.Status = reader.GetSafeString(ord++);
                           a.ProjectStatus = reader.GetSafeString(ord++);
                           a.StartDateTimeUtc = reader.GetSafeUtcDateTime(ord++);
                           a.StartDateTimeLocal = reader.GetSafeDateTime(ord++);
                           a.EndDateTimeUtc = reader.GetSafeUtcDateTime(ord++);
                           a.EndDateTimeLocal = reader.GetSafeDateTime(ord++);
                           if (list == null)
                           {
                               list = new List<TimecardEntry>();
                           }

                           list.Add(a);
                           break;
                   }
               }
               );

            return list;
        }

        public int Insert(TimecardEntryAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.TimecardEntry_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameters(model, paramCollection);

                    SqlParameter p = new SqlParameter("@Id", SqlDbType.Int);
                    p.Direction = ParameterDirection.Output;

                    paramCollection.Add(p);
                },
                returnParameters: delegate (SqlParameterCollection param)
                {
                    int.TryParse(param["@Id"].Value.ToString(), out id);
                }
                );
            return id;
        }

        private static void MapCommonParameters(TimecardEntryAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@ProjectId", model.ProjectId);
            paramCollection.AddWithValue("@PersonId", model.PersonId);
            paramCollection.AddWithValue("@TimecardStatusId", model.TimecardStatusId);
            paramCollection.AddWithValue("@InvoiceId", model.InvoiceId);
            paramCollection.AddWithValue("@StartDateTimeUtc", model.StartDateTimeUtc);
            paramCollection.AddWithValue("@StartDateTimeLocal", model.StartDateTimeLocal);
            paramCollection.AddWithValue("@EndDateTimeUtc", model.EndDateTimeUtc);
            paramCollection.AddWithValue("@EndDateTimeLocal", model.EndDateTimeLocal);
        }

        public void Update(TimecardEntryUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.TimecardEntry_Update",
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
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.TimecardEntry_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );
            return;
        }

        public List<TimecardEntry>SelectByProjectId(int id)
        {
            List<TimecardEntry> list = new List<TimecardEntry>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.TimecardEntry_SelectByProjectId", inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@ProjectId", id);
            }
            , map: delegate (IDataReader reader, short set)
            {
                MapProjectTimecardParameters(reader, list);
            }
        );
            return list;
        }
        private static void MapProjectTimecardParameters(IDataReader reader, List<TimecardEntry> list)
        {
            TimecardEntry _timecard = new TimecardEntry();
            int ord = 0; //startingOrdinal
            //_timecard.ProjectName = reader.GetSafeString(ord++);
            _timecard.Id = reader.GetSafeInt32(ord++);
            _timecard.ProjectId = reader.GetSafeInt32(ord++);
            _timecard.ProjectName = reader.GetSafeString(ord++);
            _timecard.LastName = reader.GetSafeString(ord++);
            _timecard.EarningsOnProj = reader.GetSafeDecimal(ord++);


            list.Add(_timecard);
        }

    }

}