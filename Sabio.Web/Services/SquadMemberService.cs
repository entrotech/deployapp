using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Sabio.Data;
using Sabio.Web.Models.Requests;
using Sabio.Web.Domain;
using Sabio.Web.Services;

namespace Sabio.Web.Requests
{
    public class SquadMemberService : BaseService
    {
        public static int Add(SquadMemberAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.SquadMember_Insert", inputParamMapper: delegate (SqlParameterCollection paramCollection)
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

        public static void Update(SquadMemberUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.SquadMember_Update", inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", model.Id);
                MapCommonParameters(model, paramCollection);
            }
            );
            return;
        }

        private static void MapCommonParameters(SquadMemberAddRequest model, SqlParameterCollection paramCollection)
        {
            
           
            paramCollection.AddWithValue("@SquadId", model.SquadId);
            paramCollection.AddWithValue("@PersonId", model.PersonId);
            paramCollection.AddWithValue("@LeaderComment", model.LeaderComment);
            paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
            paramCollection.AddWithValue("@MemberStatusId", model.MemberStatusId);
            paramCollection.AddWithValue("@IsLeader", model.IsLeader);
        }

        public static void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.SquadMember_Delete", inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("Id", id);
            }
            );
            return;
        }

        public static SquadMember SelectById(int id)
        {
            SquadMember sm = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.SquadMember_SelectById", inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("Id", id);
            }
            ,   map: delegate (IDataReader reader, short set)
            {
                sm = new SquadMember();
                int ord = 0;

                SquadMemberStatus sms = new SquadMemberStatus();
                sm.Id = reader.GetSafeInt32(ord++);
                sm.SquadId = reader.GetSafeInt32(ord++);
                PersonBase pb = new PersonBase();
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
                sm.IsLeader = reader.GetBoolean(ord++);
                sm.Person = pb;
                sm.Status = sms;

            }
            );
            return sm;
        }

        public static List<SquadMember> SelectAll()
        {
            List<SquadMember> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.SquadMember_SelectAll",
                inputParamMapper: null 

            , map: delegate (IDataReader reader, short set)
            {
                SquadMember sm = new SquadMember();
                int ord = 0;

                SquadMemberStatus sms = new SquadMemberStatus();
                sm.Id = reader.GetSafeInt32(ord++);
                sm.SquadId = reader.GetSafeInt32(ord++);
                PersonBase pb = new PersonBase();
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
                sm.IsLeader = reader.GetBoolean(ord++);
                sm.Person = pb;
                sm.Status = sms;

                if (list == null)
                {
                    list = new List<SquadMember>();
                }

                list.Add(sm);
            }
            );
            return list;
        }
    }
}

