using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface IEducationLevelService
    {
        int Add(EducationLevelAddRequest model);
        void Delete(int id);
        List<EducationLevel> SelectAll();
        EducationLevel SelectById(int id);
        void Update(EducationLevelUpdateRequest model);
    }
}