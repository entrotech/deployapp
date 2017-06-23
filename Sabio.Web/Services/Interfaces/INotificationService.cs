using Sabio.Web.Enums;
using System.Threading.Tasks;

namespace Sabio.Web.Services
{
    public interface INotificationService
    {
        Task NewJobApplication(int applicationId);
        Task GlobalEvent(int eventId, EventActionType eventActionType);
        Task SquadEvent(int eventId, EventActionType eventActionType);
    }
}