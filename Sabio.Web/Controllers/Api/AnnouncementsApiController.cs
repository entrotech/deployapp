using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Transfer;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/announcements")]
    public class AnnouncementsApiController : ApiController
    {   // 5.  
        private IAnnouncementService _announcement = null;  // added this ...
        public AnnouncementsApiController(IAnnouncementService announcement) // added this .
        {
            _announcement = announcement; // added this .
        }

        [Route, HttpPost]
        public HttpResponseMessage Create(AnnouncementAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            if (model == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, "Required announcement inputs: Author, Title, Body, and Category.");
            }

            ItemResponse<int> response = new ItemResponse<int>();

            response.Item = _announcement.Insert(model); // update name to _announcment.

            return Request.CreateResponse(HttpStatusCode.Created, response);
        }

        [Route("{id:int}"), HttpPut]
        public HttpResponseMessage Update(AnnouncementUpdateRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }

            if (model == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, "Required announcement inputs: ID, Author, Title, Body, and Category.");
            }

            _announcement.Update(model);  // update name to _announcment.

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}/image"), HttpPut]
        public HttpResponseMessage UploadImage(AnnouncementUpdateRequest model)
        {
            _announcement.ImageUpload(model.PhotoKey, model.Id);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}/deleteImage"), HttpPut]
        public HttpResponseMessage DeleteImage(int id)
        {
            _announcement.DeleteImage(id);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            _announcement.Delete(id);  // update name to _announcment.

            SuccessResponse response = new SuccessResponse();

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("{id:int}"), HttpGet]
        public HttpResponseMessage SelectById(int id)
        {
            ItemResponse<Announcement> response = new ItemResponse<Announcement>();

            response.Item = _announcement.SelectById(id);  // update name to _announcment.

            if (response.Item == null)
            {
                return Request.CreateResponse(HttpStatusCode.NoContent);
            }

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route, HttpGet]
        public HttpResponseMessage SelectAll()
        {
            ItemsResponse<Announcement> response = new ItemsResponse<Announcement>();

            response.Items = _announcement.SelectAll();  // update name to _announcment.

            if (response.Items == null)
            {
                return Request.CreateResponse(HttpStatusCode.NoContent);
            }

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("withCategories"), HttpGet]
        public HttpResponseMessage SelectAllAnnouncementsAndCategories()
        {
            ItemResponse<AnnouncementAndCategory> response = new ItemResponse<AnnouncementAndCategory>();

            response.Item = _announcement.SelectAllAnnouncementsAndCategories();  // update name to _announcment.

            if (response.Item == null)
            {
                return Request.CreateResponse(HttpStatusCode.NoContent);
            }

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        string _accessKey = "AKIAI3THTWXKTI7SJ5CA";
        string _secretAccess = "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";
        string _existingBucketName = "sabio-training/C31";
        string photoKey = "";

        private string UploadPhotoToAWS(Stream fileStream, string fileName)
        {
            try
            {
                AWSCredentials awsCredentials = new BasicAWSCredentials(_accessKey, _secretAccess);
                AmazonS3Client amazonS3 = new AmazonS3Client(awsCredentials, Amazon.RegionEndpoint.USWest2);
                TransferUtility fileTransferUtility = new TransferUtility(amazonS3);
                TransferUtilityUploadRequest uploadRequest = new TransferUtilityUploadRequest();
                uploadRequest.BucketName = _existingBucketName;
                uploadRequest.InputStream = fileStream;
                uploadRequest.Key = Guid.NewGuid().ToString() + ".png";
                photoKey = uploadRequest.Key;
                fileTransferUtility.Upload(uploadRequest);

            }
            catch (AmazonS3Exception s3Exception)
            {
                Console.WriteLine(s3Exception.Message,
                                  s3Exception.InnerException);
            }

            return photoKey;

        }
    }
}
