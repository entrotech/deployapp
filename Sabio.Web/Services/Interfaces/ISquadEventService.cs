using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface ISquadEventService
    {
        void Delete(int id);
        int Insert(SquadEventAddRequest model);
        List<SquadEvent> SelectAll();
        List<SquadEvent> SelectBySquadId(int squadId);
        SquadEvent SelectById(int id);
        void Update(SquadEventUpdateRequest model);
        List<SquadEvent> SquadEventSearch(SquadEventSearchRequest model, out int totalRows);
    }
}