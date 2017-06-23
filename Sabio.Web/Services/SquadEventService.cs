using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Data;
using System.Data;
using System.Data.SqlClient;
using Sabio.Web.Services;

namespace Sabio.Web.Requests
{
    public class SquadEventService : BaseService, ISquadEventService
    {

        private void MapCommonParameters(SquadEventAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@Name", model.Name);
            paramCollection.AddWithValue("@EventStart", model.EventStart);
            paramCollection.AddWithValue("@EventEnd", model.EventEnd);
            paramCollection.AddWithValue("@Description", model.Description);
            paramCollection.AddWithValue("@Location", model.Location);
            paramCollection.AddWithValue("@SquadId", model.SquadId);
            paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
            paramCollection.AddWithValue("@Color", model.Color);
            paramCollection.AddWithValue("@Timezone", model.Timezone);
        }

        public SquadEvent SelectById(int id)
        {
            SquadEvent squadEvent = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.SquadEvent_SelectById",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                },
                map: delegate (IDataReader reader, short set)
                {


                    int squadEventId = 0;
                    squadEvent = MapSquadEvent(reader, out squadEventId);

                }
                );
            return squadEvent;
        }

        public List<SquadEvent> SelectBySquadId(int squadId)
        {
            List<SquadEvent> list = new List<SquadEvent>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.SquadEvent_SelectbySquadId",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@SquadId", squadId);
                },
                map: delegate (IDataReader reader, short set)
                {
                    switch (set)
                        {
                        case 0:

                            int squadEventId = 0;
                            SquadEvent squadEvent = MapSquadEvent(reader, out squadEventId);
                            if (list == null)
                            {
                                list = new List<SquadEvent>();
                            }
                            list.Add(squadEvent);

                            break;

                        }
                });
            return list;
        }

        private static SquadEvent MapSquadEvent(IDataReader reader, out int squadId)
        {
            SquadEvent sqe = new SquadEvent();
            int ord = 0;


            sqe.Id = reader.GetSafeInt32(ord++);
            sqe.Name = reader.GetSafeString(ord++);
            sqe.DateCreated = reader.GetSafeDateTime(ord++);
            sqe.DateModified = reader.GetSafeDateTime(ord++);
            sqe.UserIdCreated = reader.GetSafeString(ord++);
            sqe.EventStart = reader.GetSafeDateTime(ord++);
            sqe.EventEnd = reader.GetSafeDateTime(ord++);
            sqe.Description = reader.GetSafeString(ord++);
            sqe.Location = reader.GetSafeString(ord++);
            sqe.SquadId = reader.GetSafeInt32(ord++);
            squadId = sqe.SquadId;
            sqe.Color = reader.GetSafeString(ord++);
            sqe.Timezone = reader.GetSafeString(ord++);
            return sqe;
        }

        public List<SquadEvent> SelectAll()
        {
            List<SquadEvent> list = new List<SquadEvent>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.SquadEvent_SelectAll",
                inputParamMapper: null,
                map: delegate (IDataReader reader, short set)
                {
                    switch (set)
                    {
                        case 0:

                            int squadEventId = 0;
                            SquadEvent squadEvent = MapSquadEvent(reader, out squadEventId);
                            if (list == null)
                            {
                                list = new List<SquadEvent>();
                            }
                            list.Add(squadEvent);

                            break;

                    }
                }
                );
            return list;
        }

    public int Insert(SquadEventAddRequest model)
    {
        int id = 0;

        DataProvider.ExecuteNonQuery(GetConnection, "dbo.SquadEvent_Insert",
            inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                MapCommonParameters(model, paramCollection);

                SqlParameter p = new SqlParameter("@Id", SqlDbType.Int);
                p.Direction = ParameterDirection.Output;

                paramCollection.Add(p);
            },
            returnParameters: delegate (SqlParameterCollection param)
            {
                Int32.TryParse(param["@Id"].Value.ToString(), out id);
            }
            );
        return id;
    }

    public void Update(SquadEventUpdateRequest model)
    {
        DataProvider.ExecuteNonQuery(GetConnection, "dbo.SquadEvent_Update",
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
        DataProvider.ExecuteNonQuery(GetConnection, "dbo.SquadEvent_Delete",
            inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
            }
            );
        return;
    }

        public List<SquadEvent> SquadEventSearch(SquadEventSearchRequest model, out int totalRows)
        {
            List<SquadEvent> list = null;
            int r = 0;

            DataProvider.ExecuteCmd(GetConnection, "dbo.SquadEvent_Search",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@SearchStr", model.SearchString);
                   paramCollection.AddWithValue("@CurrentPage", model.CurrentPage);
                   paramCollection.AddWithValue("@ItemsPerPage", model.ItemsPerPage);
                   paramCollection.AddWithValue("@SquadId", model.SquadId);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:

                           SquadEvent sqe = new SquadEvent();
                           int ord = 0;

                           sqe.Id = reader.GetSafeInt32(ord++);
                           sqe.Name = reader.GetSafeString(ord++);
                           sqe.DateCreated = reader.GetSafeDateTime(ord++);
                           sqe.DateModified = reader.GetSafeDateTime(ord++);
                           sqe.UserIdCreated = reader.GetSafeString(ord++);
                           sqe.EventStart = reader.GetSafeDateTime(ord++);
                           sqe.EventEnd = reader.GetSafeDateTime(ord++);
                           sqe.Description = reader.GetSafeString(ord++);
                           sqe.Location = reader.GetSafeString(ord++);
                           sqe.SquadId = reader.GetSafeInt32(ord++);
                           sqe.Color = reader.GetSafeString(ord++);
                           sqe.Timezone = reader.GetSafeString(ord++);

                           r = reader.GetSafeInt32(ord++);

                           if (list == null)
                           {
                               list = new List<SquadEvent>();
                           }

                           list.Add(sqe);
                           break;
                   }
               });
            totalRows = r;
            return list;
        }

    }
}