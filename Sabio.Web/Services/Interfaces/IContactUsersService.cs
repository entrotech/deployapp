using System.Threading.Tasks;
using Sabio.Web.Models.Requests;
using Sabio.Web.Domain;
using System.Collections.Generic;

namespace Sabio.Web.Services
{
    public interface IContactUsersService
    {
        Task Send(UsersEmailSendRequest model);
        List<UserRole> GetUserRoles();
    }
}