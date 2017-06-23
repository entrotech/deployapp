using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Services
{
    public class HomeStatisticsService : BaseService, IHomeStatisticsService
    {
        public void Update(HomeStatisticsUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.HomeStatistics_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Title1", model.Title1);
                    paramCollection.AddWithValue("@Number1", model.Number1);
                    paramCollection.AddWithValue("@AutoPopulate1", model.AutoPopulate1);
                    paramCollection.AddWithValue("@Title2", model.Title2);
                    paramCollection.AddWithValue("@Number2", model.Number2);
                    paramCollection.AddWithValue("@AutoPopulate2", model.AutoPopulate2);
                    paramCollection.AddWithValue("@Title3", model.Title3);
                    paramCollection.AddWithValue("@Number3", model.Number3);
                    paramCollection.AddWithValue("@AutoPopulate3", model.AutoPopulate3);
                    paramCollection.AddWithValue("@Title4", model.Title4);
                    paramCollection.AddWithValue("@Number4", model.Number4);
                    paramCollection.AddWithValue("@AutoPopulate4", model.AutoPopulate4);

                }, returnParameters: null
                );

            return;
        }

        public List<HomeStatistic> SelectAll()
        {
            List<HomeStatistic> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.HomeStatistics_SelectAll",
                inputParamMapper: null,
                map: (Action<IDataReader, short>)delegate (IDataReader reader, short set)
                {
                    HomeStatistic stat = new HomeStatistic();
                    int ord = 0;

                    stat.Id = reader.GetSafeInt32(ord++);
                    stat.Title = reader.GetSafeString(ord++);
                    stat.Number = reader.GetSafeString(ord++);
                    stat.AutoPopulate = reader.GetSafeBool(ord++);

                    if (list == null)
                    {
                        list = new List<HomeStatistic>();
                    }
                    list.Add(stat);
                }
                );
            return list;
        }
    }
}