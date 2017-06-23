using Sabio.Web.Domain;
using System.Collections.Generic;

namespace Sabio.Web.Services
{
    public interface ICompanyPersonService
    {
        void Delete(int CompanyId, int PersonId);
        void Insert(int CompanyId, int PersonId);
        List<CompanyBase> GetCompanies(string AspNetUserId);
    }
}