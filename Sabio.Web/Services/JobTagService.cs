using Sabio.Data;
using Sabio.Web.Domain;
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
    public class JobTagService : BaseService, IJobTagService
    {
        public int Insert(JobTagAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.JobTag_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameters(model, paramCollection);

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
        public void Update(JobTagUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.JobTag_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    MapCommonParameters(model, paramCollection);
                }
                );
            return;
        }
        public JobTag SelectById(int id)
        {
            JobTag jobTag = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.JobTag_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           jobTag = MapJobTag(reader);
                           break;
                   }
               }
               );
            return jobTag;
        }
        public List<JobTag> SelectAll()
        {
            List<JobTag> list = new List<JobTag>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.JobTag_SelectAll",
               inputParamMapper: null,
               map: (Action<IDataReader, short>)delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           JobTag jobTag = MapJobTag(reader);
                           list.Add(jobTag);
                           break;
                   }
               }
               );
            return list;
        }
        public void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.JobTag_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );
            return;
        }
        private static void MapCommonParameters(JobTagAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@Keyword", model.Keyword);
            paramCollection.AddWithValue("@DisplayOrder", model.DisplayOrder);
        }
        private static JobTag MapJobTag(IDataReader reader)
        {
            JobTag jobTag = new JobTag();
            int ord = 0;

            jobTag.Id = reader.GetSafeInt32(ord++);
            jobTag.Keyword = reader.GetSafeString(ord++);
            jobTag.DisplayOrder = reader.GetSafeInt32(ord++);
            return jobTag;
        }
    }
}