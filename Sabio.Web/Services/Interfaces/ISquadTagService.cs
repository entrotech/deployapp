using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface ISquadTagService
    {
        void Delete(int id);
        int Post(SquadTagAddRequest model);
        List<SquadTag> SelectAll();
        SquadTag SelectById(int id);
        void Update(SquadTagUpdateRequest model);
    }
}