//using Sabio.Web.Domain;
//using Sabio.Web.Models.Requests;
//using Sabio.Web.Models.Responses;
//using Sabio.Web.Requests;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Net;
//using System.Net.Http;
//using System.Web.Http;

//namespace Sabio.Web.Controllers.Api
//{
//    [RoutePrefix("api/exdave")]
//    public class ExDaveApiController : ApiController
//    {
//            [Route, HttpPost]
//            public HttpResponseMessage Add(ExDaveAddRequest model)
//            {
//                if (!ModelState.IsValid)
//                {
//                    return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
//                }
//                ItemResponse<int> response = new ItemResponse<int>();
//                response.Item = ExDaveService.Insert(model);
//                return Request.CreateResponse(HttpStatusCode.OK, response);
//            }

//            [Route("{id:int}"), HttpPut]
//            public HttpResponseMessage Update(ExDaveUpdateRequest model)
//            {
//                if (!ModelState.IsValid)
//                {
//                    return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
//                }
//                ExDaveService.Update(model);
//                SuccessResponse response = new SuccessResponse();
//                return Request.CreateResponse(HttpStatusCode.OK, response);
//            }

//            [Route("{id:int}"), HttpGet]
//            public HttpResponseMessage SelectById(int id)
//            {
//                ItemResponse<ExDave> response = new ItemResponse<ExDave>();
//                response.Item = ExDaveService.SelectById(id);
//                return Request.CreateResponse(HttpStatusCode.OK, response);
//            }

//            [Route, HttpGet]
//            public HttpResponseMessage SelectAll()
//            {
//                ItemsResponse<ExDave> response = new ItemsResponse<ExDave>();
//                response.Items = ExDaveService.SelectAll();
//                return Request.CreateResponse(HttpStatusCode.OK, response);
//            }


//            [Route("{id:int}"), HttpDelete]
//            public HttpResponseMessage Delete(int id)
//            {
//                ExDaveService.Delete(id);
//                SuccessResponse response = new SuccessResponse();
//                return Request.CreateResponse(HttpStatusCode.OK, response);
//            }
//        }
//    }


