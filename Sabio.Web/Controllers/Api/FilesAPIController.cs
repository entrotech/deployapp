using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/files")]
    public class FilesAPIController : ApiController
    {


        IFileUploadService _uploadService = null;
        public FilesAPIController(IFileUploadService uploadService)
        {
            _uploadService = uploadService;
        }

        [HttpPost]
        [Route("photo")]
        public HttpResponseMessage UploadPhoto()
        {
            //if (Request.Content.IsMimeMultipartContent())
            //{
            //    Stream stream;
            //    string myFile;
            //    MultipartMemoryStreamProvider provider = await Request.Content.ReadAsMultipartAsync();
            //    foreach (HttpContent content in provider.Contents)
            //    {
            //        if (content.Headers.ContentDisposition.Name.Contains("files")) {
            //            //  myFile = GetFileParts(Id, provider, i);
            //           myFile= content.Headers.ContentDisposition.FileName.Replace("\"", "").Replace(" ", "_");
            //            stream = await content.ReadAsStreamAsync();
            //            UploadToAWS(stream, myFile);
            //        }
            //    }

            //}
            var httpRequest = HttpContext.Current.Request;
            if (httpRequest.Files.Count < 1)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);

            }
            foreach (string file in httpRequest.Files)
            {
                var postedFile = httpRequest.Files[file];
                UploadToAWS(postedFile.InputStream, postedFile.FileName);

            }


            ItemResponse<HttpPostedFileBase> res = new ItemResponse<HttpPostedFileBase>();
            return Request.CreateResponse(res);
        }

        [HttpPost]
        [Route("")]
        public HttpResponseMessage UpdateBlogPhoto()
        {
            string fileKey = "";
            var httpRequest = HttpContext.Current.Request;
            if (httpRequest.Files.Count < 1)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);

            }
            foreach (string file in httpRequest.Files)
            {
                var postedFile = httpRequest.Files[file];
                fileKey = UploadPhotoToAWS(postedFile.InputStream, postedFile.FileName);

            }

            ItemResponse<string> response = new ItemResponse<string>();
            response.Item = fileKey;
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [HttpPost]
        [Route("Blogphoto")]
        public HttpResponseMessage UploadBlogPhoto(BlogPhotoAddRequest model)
        {
            ItemResponse<int> response = new ItemResponse<int>();
            response.Item = _uploadService.InsertBlogPhoto(model);
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [HttpDelete]
        [Route("{id:int}")]
        public HttpResponseMessage DeleteFromS3(int id)
        {
            string fileName = _uploadService.Delete(id);

            DeleteFromS3(fileName);
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, new SuccessResponse());

        }
        [HttpPost]
        [Route("resume")]
        public HttpResponseMessage UploadResume()
        {
            var httpRequest = HttpContext.Current.Request;
            var fileExtension = System.IO.Path.GetExtension(httpRequest.Files[0].FileName).ToLower();


            if (httpRequest.Files.Count < 1)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);

            }
            foreach (string file in httpRequest.Files)
            {
                var postedFile = httpRequest.Files[file];
                if ((fileExtension == ".pdf") || (fileExtension == ".doc") || (fileExtension == ".docx"))
                {
                    UploadResumeToAWS(postedFile.InputStream, postedFile.FileName);

                }


            }


            ItemResponse<HttpPostedFileBase> res = new ItemResponse<HttpPostedFileBase>();
            return Request.CreateResponse(res);
        }

        [HttpGet]
        [Route("photo")]
        public string downloadPhoto()
        {
            string photoUrl = _uploadService.GetPhoto();
            ItemResponse<string> res = new ItemResponse<string>();
            return photoUrl;

        }

        [HttpGet]
        [Route("resume")]
        public string downloadResume()
        {
            string resumeUrl = _uploadService.GetResume();
            ItemResponse<string> res = new ItemResponse<string>();
            return resumeUrl;

        }
        string _accessKey = System.Configuration.ConfigurationManager.AppSettings["AWSAccessKey"];
        string _secretAccess = System.Configuration.ConfigurationManager.AppSettings["AWSSecretKey"];
        string _existingBucketName = System.Configuration.ConfigurationManager.AppSettings["AWSBucket"] + "/C31";

        string blogPhotoKey = "";

        private void UploadToAWS(Stream fileStream, string fileName)
        {
            string UserFileName = "";
            try
            {

                AWSCredentials awsCredentials = new BasicAWSCredentials(_accessKey, _secretAccess);
                AmazonS3Client amazonS3 = new AmazonS3Client(awsCredentials, Amazon.RegionEndpoint.USWest2);
                TransferUtility fileTransferUtility = new TransferUtility(amazonS3);
                TransferUtilityUploadRequest uploadRequest = new TransferUtilityUploadRequest();
                uploadRequest.BucketName = _existingBucketName;
                uploadRequest.InputStream = fileStream;
                uploadRequest.Key = Guid.NewGuid().ToString() + ".png";
                UserFileName = uploadRequest.Key;
                _uploadService.UpdatePhoto(UserFileName);
                fileTransferUtility.Upload(uploadRequest);
            }
            catch (AmazonS3Exception s3Exception)
            {
                Console.WriteLine(s3Exception.Message,
                                  s3Exception.InnerException);
            }


        }

        private void UploadResumeToAWS(Stream fileStream, string fileName)
        {
            string resume = "";
            try
            {

                AWSCredentials awsCredentials = new BasicAWSCredentials(_accessKey, _secretAccess);
                AmazonS3Client amazonS3 = new AmazonS3Client(awsCredentials, Amazon.RegionEndpoint.USWest2);
                TransferUtility fileTransferUtility = new TransferUtility(amazonS3);
                TransferUtilityUploadRequest uploadRequest = new TransferUtilityUploadRequest();
                uploadRequest.BucketName = _existingBucketName;
                uploadRequest.InputStream = fileStream;
                string fileExtension = fileName.Split('.')[1];
                uploadRequest.Key = Guid.NewGuid().ToString() + "." + fileExtension;
                resume = uploadRequest.Key;
                _uploadService.UpdateResume(resume);
                fileTransferUtility.Upload(uploadRequest);
            }
            catch (AmazonS3Exception s3Exception)
            {
                Console.WriteLine(s3Exception.Message,
                                  s3Exception.InnerException);
            }


        }

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
                blogPhotoKey = uploadRequest.Key;
                fileTransferUtility.Upload(uploadRequest);

            }
            catch (AmazonS3Exception s3Exception)
            {
                Console.WriteLine(s3Exception.Message,
                                  s3Exception.InnerException);
            }

            return blogPhotoKey;

        }

        private string DeleteFromS3(string fileName)
        {
            try
            {
                AWSCredentials awsCredentials = new BasicAWSCredentials(_accessKey, _secretAccess);
                AmazonS3Client amazonS3 = new AmazonS3Client(awsCredentials, Amazon.RegionEndpoint.USWest2);
                DeleteObjectRequest deleteObjectRequest = new DeleteObjectRequest
                {
                    BucketName = _existingBucketName,
                    Key = fileName
                };
                amazonS3.DeleteObject(deleteObjectRequest);

            }
            catch (AmazonS3Exception s3Exception)
            {
                Console.WriteLine(s3Exception.Message,
                                  s3Exception.InnerException);
            }

            return blogPhotoKey;

        }



    }
}
