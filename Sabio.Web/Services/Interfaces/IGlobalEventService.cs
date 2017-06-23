using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface IGlobalEventService
    {
        void Delete(int id);
        void Cancel(int id);
        int Insert(GlobalEventAddRequest model);
        List<GlobalEvent> SelectAll();
        List<GlobalEvent> SelectAllCalendar();
        GlobalEvent SelectById(int id);
        void Update(GlobalEventUpdateRequest model);
        List<GlobalEvent> SearchByRadius(GlobalEventSearchRadiusRequest model);
        List<GlobalEvent> Search(GlobalEventSearchRequest model);
    }
}