using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models;
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
    public class GlobalEventService : BaseService, IGlobalEventService
    {
        public int Insert(GlobalEventAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.GlobalEvent_Insert"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   MapCommonParameters(model, paramCollection);

                   SqlParameter p = new SqlParameter("@id", System.Data.SqlDbType.Int);
                   p.Direction = System.Data.ParameterDirection.Output;

                   paramCollection.Add(p);

               }, returnParameters: delegate (SqlParameterCollection param)
               {
                   int.TryParse(param["@id"].Value.ToString(), out id);
               }
            );

            return id;
        }

        public void Update(GlobalEventUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.GlobalEvent_Update"
                , inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@id", model.Id);
                    MapCommonParameters(model, paramCollection);
                }
            );

            return;
        }

        public GlobalEvent SelectById(int id)
        {
            GlobalEvent globalEvent = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.GlobalEvent_SelectById",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@id", id);
                }
                , map: delegate (IDataReader reader, short set)
                {
                    switch (set)
                    {
                        case 0:
                            globalEvent = MapGlobalEvent(reader);
                            break;
                    }
                }
            );

            return globalEvent;
        }

        public List<GlobalEvent> SelectAll()
        {
            {
                List<GlobalEvent> list = null;

                DataProvider.ExecuteCmd(GetConnection, "dbo.GlobalEvent_SelectAll"
                   , inputParamMapper: null
                   , map: delegate (IDataReader reader, short set)
                   {
                       switch (set)
                       {
                           case 0:
                               GlobalEvent globalEvent = MapGlobalEvent(reader);

                               if (list == null)
                               {
                                   list = new List<GlobalEvent>();
                               }

                               list.Add(globalEvent);
                               break;
                       }
                   }
                );

                return list;
            }
        }

        public List<GlobalEvent> SelectAllCalendar()
        {
            {
                List<GlobalEvent> list = null;

                DataProvider.ExecuteCmd(GetConnection, "dbo.GlobalEvent_CalendarSelectAll"
                   , inputParamMapper: null
                   , map: delegate (IDataReader reader, short set)
                   {
                       switch (set)
                       {
                           case 0:
                               GlobalEvent globalEvent = MapGlobalEvent(reader);

                               if (list == null)
                               {
                                   list = new List<GlobalEvent>();
                               }

                               list.Add(globalEvent);
                               break;
                       }
                   }
                );

                return list;
            }
        }

        public List<GlobalEvent> SearchByRadius(GlobalEventSearchRadiusRequest model)
        {
            List<GlobalEvent> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.GlobalEvent_SearchRadius"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@userLat", model.Lat);
                   paramCollection.AddWithValue("@userLng", model.Lng);
                   paramCollection.AddWithValue("@radius", model.Radius);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           GlobalEvent globalEvent = MapGlobalEvent(reader);

                           if (list == null)
                           {
                               list = new List<GlobalEvent>();
                           }

                           list.Add(globalEvent);
                           break;
                   }
               }
               );
            return list;
        }

        public List<GlobalEvent> Search(GlobalEventSearchRequest model)
        {
            List<GlobalEvent> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.GlobalEvent_Search"
                , inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@searchStr", model.SearchStr);

                }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           GlobalEvent globalEvent = MapGlobalEvent(reader);

                           if (list == null)
                           {
                               list = new List<GlobalEvent>();
                           }

                           list.Add(globalEvent);
                           break;
                   }
               }
            );

            return list;
        }

        public void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.GlobalEvent_Delete",
            inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@id", id);
            }
            );

            return;
        }

        public void Cancel(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.GlobalEvent_Cancel"
                , inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@id", id);
                }
            );

            return;
        }

        private void MapCommonParameters(GlobalEventAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@name", model.Name);
            paramCollection.AddWithValue("@address", model.Address);
            paramCollection.AddWithValue("@city", model.City);
            paramCollection.AddWithValue("@state", model.State);
            paramCollection.AddWithValue("@zipCode", model.ZipCode);
            paramCollection.AddWithValue("@country", model.Country);
            paramCollection.AddWithValue("@dateStart", model.DateStart);
            paramCollection.AddWithValue("@dateEnd", model.DateEnd);
            paramCollection.AddWithValue("@startTime", model.StartTime);
            paramCollection.AddWithValue("@endTime", model.EndTime);
            paramCollection.AddWithValue("@description", model.Description);
            paramCollection.AddWithValue("@latitude", model.Latitude);
            paramCollection.AddWithValue("@longitude", model.Longitude);
            paramCollection.AddWithValue("@userId", UserService.GetCurrentUserId());
        }

        private GlobalEvent MapGlobalEvent(IDataReader reader)
        {
            GlobalEvent globalEvent = new GlobalEvent();
            int ord = 0;

            globalEvent.Id = reader.GetSafeInt32(ord++);
            globalEvent.Name = reader.GetSafeString(ord++);
            globalEvent.Address = reader.GetSafeString(ord++);
            globalEvent.City = reader.GetSafeString(ord++);
            globalEvent.State = reader.GetSafeString(ord++);
            globalEvent.ZipCode = reader.GetSafeInt32(ord++);
            globalEvent.Country = reader.GetSafeString(ord++);
            globalEvent.DateStart = reader.GetSafeDateTime(ord++);
            globalEvent.DateEnd = reader.GetSafeDateTime(ord++);
            globalEvent.StartTime = ((SqlDataReader)reader).GetSafeTimeSpan(ord++);
            globalEvent.EndTime = ((SqlDataReader)reader).GetSafeTimeSpan(ord++);
            globalEvent.Description = reader.GetSafeString(ord++);
            globalEvent.Latitude = reader.GetSafeDecimal(ord++);
            globalEvent.Longitude = reader.GetSafeDecimal(ord++);
            globalEvent.DateCreated = reader.GetSafeDateTime(ord++);
            globalEvent.PersonFirstName = reader.GetSafeString(ord++);
            globalEvent.PersonLastName = reader.GetSafeString(ord++);
            globalEvent.IsCanceled = reader.GetSafeBool(ord++);
            return globalEvent;
        }
    }
}