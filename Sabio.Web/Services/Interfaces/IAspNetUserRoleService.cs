using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;


namespace Sabio.Web.Requests
{
    public interface IAspNetUserRoleService
    {
        void Delete(AspNetUserRoleAddRequest model);
        void Post(AspNetUserRoleAddRequest model);
        List<AspNetUserRole> Search(AspNetUserRoleSearchRequest model);
        AspNetUserRole SelectByAspNetUserId(string userId);
    }
}