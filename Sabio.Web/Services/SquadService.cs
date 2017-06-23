using Sabio.Web.Models.Requests;
using Sabio.Web.Domain;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Sabio.Data;
using Sabio.Web.Requests.Interfaces;
using Sabio.Web.Services;
using Sabio.Web.Classes;

namespace Sabio.Web.Requests
{
    public class SquadService : BaseService, ISquadService
    {
        private void MapCommonParameters(SquadAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@Name", model.Name);
            paramCollection.AddWithValue("@Mission", model.Mission);
            paramCollection.AddWithValue("@Notes", model.Notes);
            paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
            DataTable SquadTagIdArray = new DataTable();
            SquadTagIdArray.Columns.Add("SquadTagId", typeof(Int32));
            if (model.SquadTagIds != null)
            {
                for (int i = 0; i < model.SquadTagIds.Length; i++)
                {
                    SquadTagIdArray.Rows.Add(model.SquadTagIds[i]);
                }
            }
            SqlParameter SquadTagIdTable = new SqlParameter();
            SquadTagIdTable.ParameterName = "@SquadTagIds";
            SquadTagIdTable.SqlDbType = System.Data.SqlDbType.Structured;
            SquadTagIdTable.Value = SquadTagIdArray;
            paramCollection.Add(SquadTagIdTable);
        }

        public int Insert(SquadAddRequest model)
        {
            {
                int id = 0;

                DataProvider.ExecuteNonQuery(GetConnection, "dbo.Squad_Insert",
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
        }

        public void Update(SquadUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Squad_Update",
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
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Squad_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );

            return;
        }

        public Squad SelectById(int id)
        {
            Squad squad = null;
            List<SquadEvent> sqEventList = null;
            List<SquadMember> squadMemberList = null;
            List<SquadTag> SquadTagList = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.Squad_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           squad = new Squad();
                           int startingIndex = 0;

                           squad.Id = reader.GetInt32(startingIndex++);
                           squad.Name = reader.GetString(startingIndex++);
                           squad.Mission = reader.GetString(startingIndex++);
                           squad.Notes = reader.GetString(startingIndex++);

                           break;
                       case 1:
                           int squadEventId = 0;
                           SquadEvent squadEvent = MapSquadEvent(reader, out squadEventId);
                           if (sqEventList == null)
                           {
                               sqEventList = new List<SquadEvent>();
                           }
                           sqEventList.Add(squadEvent);
                           break;
                       case 2:
                           int squadMemberId = 0;
                           SquadMember squadMember = MapSquadMember(reader, out squadMemberId);
                           if (squadMemberList == null)
                           {
                               squadMemberList = new List<SquadMember>();
                           }
                           squadMemberList.Add(squadMember);
                           break;
                       default:
                           break;
                       case 3:
                           int SquadTagId = 0;
                           SquadTag squadTag = MapSquadTag(reader, out SquadTagId);
                          
                           if (SquadTagList == null)
                           {
                               SquadTagList = new List<SquadTag>();
                           }
                           SquadTagList.Add(squadTag);
                           break;
                   }
               }
               );
            squad.SquadEvents = sqEventList;
            squad.SquadMember = squadMemberList;
            squad.SquadTag = SquadTagList;
            return squad;
        }

        private static SquadEvent MapSquadEvent(IDataReader reader, out int squadId)
        {
            SquadEvent sqe = new SquadEvent();
            int ord = 0;


            sqe.Id = reader.GetSafeInt32(ord++);
            sqe.Name = reader.GetSafeString(ord++);
            sqe.DateCreated = reader.GetSafeDateTime(ord++);
            sqe.DateModified = reader.GetSafeDateTime(ord++);
            ord++; //Skips UserIdCreated Sql Column
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

        private static SquadMember MapSquadMember(IDataReader reader, out int sm_SquadId)
        {
            SquadMember sm = new SquadMember();

            int ord = 0;
            PersonBase pb = new PersonBase();
            SquadMemberStatus sms = new SquadMemberStatus();
            sm.Id = reader.GetSafeInt32(ord++);
            sm.SquadId = reader.GetSafeInt32(ord++);
            sm_SquadId = sm.SquadId;
            pb.Id = reader.GetSafeInt32(ord++);
            sm.LeaderComment = reader.GetSafeString(ord++);
            sm.DateCreated = reader.GetSafeDateTime(ord++);
            sm.DateModified = reader.GetSafeDateTime(ord++);
            sms.Id = reader.GetSafeInt32(ord++);
            sms.Name = reader.GetSafeString(ord++);
            pb.FirstName = reader.GetSafeString(ord++);
            pb.MiddleName = reader.GetSafeString(ord++);
            pb.LastName = reader.GetSafeString(ord++);
            pb.PhoneNumber = reader.GetSafeString(ord++);
            pb.Email = reader.GetSafeString(ord++);
            pb.PhotoKey = reader.GetSafeString(ord++);
            pb.ProfilePicture = SiteConfig.GetUrlFromFileKey(pb.PhotoKey);//this replaces the url
            sm.IsLeader = reader.GetSafeBool(ord++);

            sm.Person = pb;
            sm.Status = sms;

            return sm;
        }
        private static SquadTag MapSquadTag(IDataReader reader, out int squadId)
        {
            SquadTag st = new SquadTag();
            int ord = 0;
            squadId = reader.GetSafeInt32(ord++);
            st.Id = reader.GetSafeInt32(ord++);
            st.Keyword = reader.GetSafeString(ord++);
            st.DisplayOrder = reader.GetSafeInt32(ord++);
            st.Inactive = reader.GetSafeBool(ord++);
            return st;
        }

        public List<Squad> SelectAll()
        {
            List<Squad> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Squad_SelectAll"
               , inputParamMapper: null
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           Squad p = new Squad();
                           int startingIndex = 0; //startingOrdinal

                           p.Id = reader.GetInt32(startingIndex++);
                           p.Name = reader.GetSafeString(startingIndex++); //extension method
                           p.Mission = reader.GetSafeString(startingIndex++);
                           p.Notes = reader.GetSafeString(startingIndex++);

                           if (list == null)
                           {
                               list = new List<Squad>();
                           }

                           list.Add(p);
                           break;

                       case 1:
                           int se_SquadId = 0;
                           SquadEvent squadEvent = MapSquadEvent(reader, out se_SquadId);
                           Squad squad_se = list.Find(item => item.Id == se_SquadId);
                           if (squad_se.SquadEvents == null)
                           {
                               squad_se.SquadEvents = new List<SquadEvent>();
                           }
                           squad_se.SquadEvents.Add(squadEvent);
                           break;

                       case 2:
                           int sm_SquadId = 0;
                           SquadMember squadMember = MapSquadMember(reader, out sm_SquadId);
                           Squad squad_sm = list.Find(item => item.Id == sm_SquadId);
                           if (squad_sm.SquadMember == null)
                           {
                               squad_sm.SquadMember = new List<SquadMember>();
                           }
                           squad_sm.SquadMember.Add(squadMember);
                           break;                                                

                       case 3:
                           int st_SquadId = 0;
                           SquadTag squadTag = MapSquadTag(reader, out st_SquadId);
                           Squad squad_st = list.Find(item => item.Id == st_SquadId);
                           if (squad_st.SquadTag == null)
                           {
                               squad_st.SquadTag = new List<SquadTag>();
                           }
                           squad_st.SquadTag.Add(squadTag);
                           break;
                       default:
                           break;

                   }

               }
               );


            return list;
        }

        public List<Squad> Search(SquadSearchRequest model)
        {
            List<Squad> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Squad_Search"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@SearchStr", model.SearchString);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0: //first result set
                           Squad p = new Squad();
                           int startingIndex = 0; //startingOrdinal

                           p.Id = reader.GetInt32(startingIndex++);
                           p.Name = reader.GetSafeString(startingIndex++); //extension method
                           p.Mission = reader.GetSafeString(startingIndex++);
                           p.Notes = reader.GetSafeString(startingIndex++);
                           

                           if (list == null)
                           {
                               list = new List<Squad>();
                           }

                           list.Add(p);
                           break;
                       case 1:
                           int squadId = 0;
                           SquadEvent squadEvent = MapSquadEvent(reader, out squadId);
                           Squad parentSquad = list.Find(o => o.Id == squadId);
                           if (parentSquad.SquadEvents == null)
                           {
                               parentSquad.SquadEvents = new List<SquadEvent>();
                           }
                           parentSquad.SquadEvents.Add(squadEvent);
                           break;
                   }

               }
               );

            return list;
        }

        public List<PersonBase> PersonBaseSearch(PersonSearchRequest model, out int totalRows)
        {
            List<PersonBase> list = null;
            int r = 0;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Person_Search",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@SearchStr", model.SearchString);
                   paramCollection.AddWithValue("@CurrentPage", model.CurrentPage);
                   paramCollection.AddWithValue("@ItemsPerPage", model.ItemsPerPage);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:

                           PersonBase p = new PersonBase();
                           int ord = 0; //startingOrdinal

                           p.Id = reader.GetSafeInt32(ord++);
                           p.FirstName = reader.GetSafeString(ord++);
                           ord++;
                           p.LastName = reader.GetSafeString(ord++);
                           p.PhoneNumber = reader.GetSafeString(ord++);
                           p.Email = reader.GetSafeString(ord++);
                           ord++;
                           p.PhotoKey = reader.GetSafeString(ord++);
                           r = reader.GetSafeInt32(ord++);
                           if (list == null)
                           {
                               list = new List<PersonBase>();
                           }

                           list.Add(p);
                           break;
                   }
               }
               );
            totalRows = r;
            return list;
        }
    }
}