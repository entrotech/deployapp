using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface ISkillService
    {
        void Delete(int id);
        int Post(SkillAddRequest model);
        List<Skill> SelectAll();
        Skill SelectById(int id);
        void Update(SkillUpdateRequest model);
    }
}