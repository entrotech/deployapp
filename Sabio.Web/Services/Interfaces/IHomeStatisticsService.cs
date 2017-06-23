using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using System.Collections.Generic;

namespace Sabio.Web.Services
{
    public interface IHomeStatisticsService
    {
        void Update(HomeStatisticsUpdateRequest model);
        List<HomeStatistic> SelectAll();
    }
}