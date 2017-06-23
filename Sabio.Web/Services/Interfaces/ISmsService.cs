namespace Sabio.Web.Requests
{
    public interface ISmsService
    {
        void SendSms(string phoneNumber, string messageText);
    }
}