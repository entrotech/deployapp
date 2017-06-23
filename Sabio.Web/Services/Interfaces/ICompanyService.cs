using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface ICompanyService
    {
        void Delete(int id);
        int Insert(CompanyAddRequest model);
        List<Company> SelectAll();
        Company SelectById(int id);
        void Update(CompanyUpdateRequest model);
        List<Company> Search(string searchString);
    }
}