using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models;

namespace Sabio.Web.Requests
{
    public interface IProjectsService
    {
        void Delete(int id);
        int Post(ProjectsAddRequest model);
        List<Project> SelectAll();
        Project SelectById(int id);
        List<Project> SelectProjectByCompanyId(int id);
        void Update(ProjectsUpdateRequest model);
        //List<PersonBase> PersonSearch(ProjectPersonSearchRequest model);
    }
}