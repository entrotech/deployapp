using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface ILanguageService
    {
        void Delete(int id);
        int Insert(LanguageAddRequest model);
        List<Language> SelectAll();
        Language SelectById(int id);
        void Update(LanguageUpdateRequest model);
    }
}