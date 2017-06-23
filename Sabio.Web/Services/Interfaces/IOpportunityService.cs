using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests.Interfaces
{
    public interface IOpportunityService
    {
        List<Opportunity> Search(OpportunitySearchRequest model, out int totalRows);
        int Insert(OpportunityAddRequest model);
        void Update(OpportunityUpdateRequest model);
        Opportunity SelectById(int id);
        List<Opportunity> SelectAll();
        void Delete(int id);
    }
}