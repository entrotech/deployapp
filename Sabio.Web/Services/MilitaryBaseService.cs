using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Services
{
    public class MilitaryBaseService : BaseService
    {
        public static int Post(MilitaryBaseAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.MilitaryBase_Insert",
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
        public static void Update(MilitaryBaseUpdateRequest model)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.MilitaryBase_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    MapCommonParameters(model, paramCollection);
                }
                );

            return;
        }

        private static void MapCommonParameters(MilitaryBaseAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@MilitaryBase", model.MilitaryBaseName);
        }

        public static void Delete(int id)
        {

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.MilitaryBase_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );
            return;
        }
        public static MilitaryBase SelectById(int id)
        {
            MilitaryBase militaryBase = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.MilitaryBase_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           militaryBase = MapMilitaryBase(reader);
                           break;
                   }
               }
               );

            return militaryBase;
        }
        public static List<MilitaryBase> SelectAll()
        {
            List<MilitaryBase> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.MilitaryBase_SelectAll"
               , inputParamMapper: null
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           MilitaryBase p = MapMilitaryBase(reader);

                           if (list == null)
                           {
                               list = new List<MilitaryBase>();
                           }

                           list.Add(p);
                           break;
                   }
               }
               );
            return list;
        }

        private static MilitaryBase MapMilitaryBase(IDataReader reader)
        {
            MilitaryBase p = new MilitaryBase();
            int ord = 0; //startingOrdinal

            p.Id = reader.GetInt32(ord++);
            p.MilitaryBaseName = reader.GetString(ord++);
            p.ServiceBranchId = reader.GetInt32(ord++);
            p.ServiceBranchName = reader.GetSafeString(ord++);
            return p;
        }
    }
}