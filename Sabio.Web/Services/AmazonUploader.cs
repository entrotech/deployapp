﻿using Amazon;
using Amazon.S3;
using Amazon.S3.Transfer;
using System;
using System.Collections.Generic;
using System.Linq;
using Amazon.Util;
using System.Web;

namespace Sabio.Web.Services
{
    public class AmazonUploader
    {

    //    public bool sendMyFileToS3(string localFilePath, string bucketName, string subDirectoryInBucket, string fileNameInS3)
    //    {
    //        // input explained :
    //        // localFilePath = the full local file path e.g. "c:\mydir\mysubdir\myfilename.zip"
    //        // bucketName : the name of the bucket in S3 ,the bucket should be alreadt created
    //        // subDirectoryInBucket : if this string is not empty the file will be uploaded to
    //        // a subdirectory with this name
    //        // fileNameInS3 = the file name in the S3

           
    //        IAmazonS3 client = Amazon.AWSClientFactory.CreateAmazonS3Client(RegionEndpoint.EUWest1);

    //        // create a TransferUtility instance passing it the IAmazonS3 created in the first step
    //        TransferUtility utility = new TransferUtility(client);
    //        // making a TransferUtilityUploadRequest instance
    //        TransferUtilityUploadRequest request = new TransferUtilityUploadRequest();

    //        if (subDirectoryInBucket == "" || subDirectoryInBucket == null)
    //        {
    //            request.BucketName = bucketName; //no subdirectory just bucket name
    //        }
    //        else
    //        {   // subdirectory and bucket name
    //            request.BucketName = bucketName + @"/" + subDirectoryInBucket;
    //        }
    //        request.Key = fileNameInS3; //file name up in S3
    //        request.FilePath = localFilePath; //local file name
    //        utility.Upload(request); //commensing the transfer

    //        return true; //indicate that the file was sent
    //    }
    }
}