using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models;

namespace Sabio.Web.Requests
{
    public interface IInvoiceService
    {
        void Delete(int id);
        int Insert(InvoiceAddRequest model);
        void Update(InvoiceUpdateRequest model);
        
    }
}