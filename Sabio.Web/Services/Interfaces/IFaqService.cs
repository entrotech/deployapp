using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests
{
    public interface IFaqService
    {
        void Delete(int id);
        int Insert(FaqAddRequest model);
        List<Faq> SelectAll();
        Faq SelectById(int id);
        void Update(FaqUpdateRequest model);
    }
}