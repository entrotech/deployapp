using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface ITimecardEntryService
    {
        void Delete(int id);
        int Insert(TimecardEntryAddRequest model);
        List<TimecardEntry> Search(TimecardEntrySearchRequest model);
        List<TimecardEntry>SelectByProjectId(int id);
        void Update(TimecardEntryUpdateRequest model);
    }
}