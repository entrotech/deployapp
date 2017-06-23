using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface IServiceBranchService
    {
        void delete(int id);
        int Insert(ServiceBranchAddRequest model);
        List<ServiceBranch> SelectAll();
        ServiceBranch SelectById(int id);
        void Update(ServiceBranchUpdateRequest model);
        List<Rank> GetRankByService(Branch model);
    }
   
}
