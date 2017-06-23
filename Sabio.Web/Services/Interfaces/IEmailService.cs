using System.Threading.Tasks;
using Sabio.Web.Models.Request;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface IEmailService
    {
        Task<bool> ConfirmRegistration(ConfirmationEmailRequest model);
        Task<bool> Send(string Email, string Name, string toName, string toAddress, string subject, string messageText, string messageHtml);
        Task<bool> SendContactUs(ContactUsAddRequest model);
        Task<bool> ForgotPassword(ConfirmationEmailRequest model);
        Task<bool> SendProposalAdmin(ProposalSendRequest model);
        Task<bool> SendProposalUser(ProposalSendRequest model);

    }
}