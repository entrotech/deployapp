using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface IPersonService
    {
        bool CheckIfPerson(string aspNetUserId);
        void Delete(int id);
        List<Person> GetAll();
        int Insert(PersonAddRequest model);
        Person PublicSelect(int id);
        void Update(PersonUpdateRequest model);
        PersonLayout GetByAspNetUserId(string AspNetUserId);
        int InsertFromRegister(PersonAddRequest model);
        
        List<PersonProject> SelectProjectByPersonId(int id);
        List<PersonBase> PersonBaseSearch(PersonSearchRequest model, out int totalRows);
        int Insert_GoogleUser(PersonAddRequest model);

        PersonPublic PersonPublic_SelectById(int id);
    }
}