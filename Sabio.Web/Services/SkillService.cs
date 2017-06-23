using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Sabio.Web.Requests
{
    public class SkillService : BaseService, ISkillService
    {
        public int Post(SkillAddRequest model)
        {
            int id = 0;
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Skill_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameters(model, paramCollection);
                    SqlParameter p = new SqlParameter("@Id", System.Data.SqlDbType.Int);
                    p.Direction = ParameterDirection.Output;
                    paramCollection.Add(p);
                }, returnParameters: delegate (SqlParameterCollection param)
                {
                    Int32.TryParse(param["@Id"].Value.ToString(), out id);
                }
                );
            return id;
        }

        public void Update(SkillUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Skill_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    MapCommonParameters(model, paramCollection);
                }
                );
            return;
        }

        private void MapCommonParameters(SkillAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@Name", model.Name);
            paramCollection.AddWithValue("@Code", model.Code);
            paramCollection.AddWithValue("@DisplayOrder", model.DisplayOrder);
        }

        public void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Skill_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );

            return;
        }

        public Skill SelectById(int id)
        {
            Skill skill = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Skill_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           skill = MapSkill(reader);
                           break;
                   }
               }
               );

            return skill;
        }

        private Skill MapSkill(IDataReader reader)
        {
            Skill skill = new Skill();
            int ord = 0;
            skill.Id = reader.GetSafeInt32(ord++);
            skill.Name = reader.GetSafeString(ord++);
            skill.Code = reader.GetSafeString(ord++);
            skill.DisplayOrder = reader.GetSafeInt32(ord++);
            return skill;
        }

        public List<Skill> SelectAll()
        {
            List<Skill> list = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.Skill_SelectAll"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection) { }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           Skill p = MapSkill(reader);

                           if (list == null)
                           {
                               list = new List<Skill>();
                           }
                           list.Add(p);
                           break;
                   }
               }
               );
            return list;
        }
    }
}