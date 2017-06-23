using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using Sabio.Web.Services;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/invoices")]
    public class InvoiceApiController : ApiController
    {
        private IInvoiceService _invoice = null;
        public InvoiceApiController(IInvoiceService invoiceService)
        {
            _invoice = invoiceService;
        }

        [Route, HttpPost]
        public HttpResponseMessage Insert(InvoiceAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = _invoice.Insert(model);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        //[Route("{id:int}"), HttpGet]
        //public HttpResponseMessage SelectById(int id)
        //{
        //    if (!ModelState.IsValid)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
        //    }

        //    ItemResponse<Invoice> response = new ItemResponse<Invoice>();

        //    response.Item = _invoice.SelectById(id);

        //    return Request.CreateResponse(HttpStatusCode.OK, response);
        //}

        //[Route, HttpGet]
        //public HttpResponseMessage SelectAll()
        //{
        //    if (!ModelState.IsValid)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
        //    }

        //    //ItemsResponse<Invoice> response = new ItemsResponse<Invoice>();
        //    //var response =
        //    //    _Invoice.SelectAll()
        //    //    .ToDictionary(c => c.Id);

        //    ItemsResponse<Invoice> response = new ItemsResponse<Invoice>();
        //    response.Items = _invoice.SelectAll();

        //    return Request.CreateResponse(HttpStatusCode.OK, response);
        //}

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(InvoiceUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            _invoice.Update(model);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _invoice.Delete(id);

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
