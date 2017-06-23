using Sabio.Web.Classes;
using Sabio.Web.Models.Request;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests;
using SendGrid;
using SendGrid.Helpers.Mail;
using System.Threading.Tasks;
using System.Web;


namespace Sabio.Web.Services
{
    public class EmailService : BaseService, IEmailService
    {
        public async Task<bool> SendContactUs(ContactUsAddRequest model)
        {
            string toName = "OpCode Admin";
            string toAddress = System.Web.Configuration.WebConfigurationManager.AppSettings["SiteAdminEmailAddress"];
            string subject = "Message From Deploy Site User";
            string messageText = model.Message;
            string messageHtml = messageText;
            return await Send(model.Email, model.Name, toName, toAddress, subject, messageText, messageHtml);
        }

        public async Task<bool> ConfirmRegistration(ConfirmationEmailRequest model)
        {
            // Setup HTML message
            string url = System.Web.Configuration.WebConfigurationManager.AppSettings["BaseUrl"] + "/users/confirm/" + model.SecurityToken;
            string path = HttpContext.Current.Server.MapPath("~/HTML_Templates/RegistrationEmail.html");
            string emailBody = System.IO.File.ReadAllText(path);
            string finalEmail = emailBody.Replace("{{firstName}}", model.FirstName)
                                        .Replace("{{confirmUrl}}", url);

            // Send to Email Sender
            string name = "Operation Code";
            string toName = model.FirstName + " " + model.LastName;
            string toAddress = model.Email;
            string fromAddress = System.Web.Configuration.WebConfigurationManager.AppSettings["SiteAdminEmailAddress"];
            string subject = "Thank you for registering with Deploy!";
            string messageText = "Please click the following link to confirm your email address: " + System.Web.Configuration.WebConfigurationManager.AppSettings["BaseUrl"] + "/users/confirm/" + model.SecurityToken;
            string messageHtml = finalEmail;
            return await Send(fromAddress, name, toName, toAddress, subject, messageText, messageHtml);
        }

        public async Task<bool> Send(string Email, string Name, string toName, string toAddress, string subject, string messageText, string messageHtml)
        {
            var apiKey = SiteConfig.SendGrid;
            var client = new SendGridClient(apiKey);
            var msg = new SendGridMessage()
            {
                From = new EmailAddress(Email, Name),
                Subject = subject,
                PlainTextContent = messageText,
                HtmlContent = messageHtml
            };
            msg.AddTo(new EmailAddress(toAddress, toName));
            SendGrid.Response response = await client.SendEmailAsync(msg);
            bool success = response.StatusCode == System.Net.HttpStatusCode.Accepted;
            return success;
        }

        public async Task<bool> ForgotPassword(ConfirmationEmailRequest model)
        {
            // Setup HTML message
            string url = System.Web.Configuration.WebConfigurationManager.AppSettings["BaseUrl"] + "/users/resetpassword/" + model.SecurityToken;
            string path = HttpContext.Current.Server.MapPath("~/HTML_Templates/ResetPasswordEmail.html");
            string emailBody = System.IO.File.ReadAllText(path);
            string finalEmail = emailBody.Replace("{{firstName}}", model.FirstName)
                                        .Replace("{{confirmUrl}}", url);

            // Send to Email Sender
            string name = "Operation Code";
            string toName = model.FirstName + " " + model.LastName;
            string toAddress = model.Email;
            string fromAddress = System.Web.Configuration.WebConfigurationManager.AppSettings["SiteAdminEmailAddress"];
            string subject = "Reset Your Deploy Password";
            string messageText = "Please click the following link to reset your password: " + System.Web.Configuration.WebConfigurationManager.AppSettings["BaseUrl"] + "/users/resetpassword/" + model.SecurityToken;
            string messageHtml = finalEmail;
            return await Send(fromAddress, name, toName, toAddress, subject, messageText, messageHtml);
        }

        public async Task<bool> SendProposalAdmin(ProposalSendRequest model)
        {
            string name = "Operation Code";
            string toName = "OpCode Admin";
            string toAddress = System.Web.Configuration.WebConfigurationManager.AppSettings["SiteAdminEmailAddress"];
            string subject = "New Proposal From Deploy Site User";
            string path = HttpContext.Current.Server.MapPath("~/HTML_Templates/ProposalAdminEmail.html");
            string emailBody = System.IO.File.ReadAllText(path);

            string budgetString;
            if (model.Budget.HasValue)
            {
                budgetString = model.Budget.Value.ToString();

            }
            else
            {
                budgetString = "tbd";
            }
            string finalEmail = emailBody.Replace("{{firstName}}", model.FirstName)
                   .Replace("{{lastName}}", model.LastName)
                   .Replace("{{email}}", model.Email)
                   .Replace("{{phoneNumber}}", model.PhoneNumber)
                   .Replace("{{deadline}}", model.Deadline)
                   .Replace("{{budget}}", budgetString)
                   .Replace("{{company}}", model.Company)
                   .Replace("{{projectType}}", model.ProjectType)
                   .Replace("{{description}}", model.Description)
                   .Replace("{{siteURL}}", SiteConfig.BaseUrl);
                   

            string messageText = "New Proposal From Deploy Site User";
            string messageHtml = finalEmail;
            return await Send("operationcode@mailinator.com", toName, name, toAddress, subject, messageText, messageHtml);
        }

        public async Task<bool> SendProposalUser(ProposalSendRequest model)
        {
            string name = "Operation Code";

            string toName = model.FirstName + " " + model.LastName;
            string toAddress = model.Email;
            string path = HttpContext.Current.Server.MapPath("~/HTML_Templates/ProposalUserResponseEmail.html");
            string emailBody = System.IO.File.ReadAllText(path);
            string finalEmail = emailBody.Replace("{{firstName}}", model.FirstName);
            string subject = "Thank you for contacting Deploy!";
            string firstName = model.FirstName;
            string lastName = model.LastName;
            string email = model.Email;
            string messageText = "Thank you for contacting Deploy!";
            string messageHtml = finalEmail;
            return await Send("operationcode@mailinator.com", toName, name, toAddress, subject, messageText, messageHtml);
        }
    }
}