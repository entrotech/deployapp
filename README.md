# Deploy App

This repo contains the Deploy Application code for Operation Code.

There are two additional files, ConnectionStrings.config and PrivateSettings.config that contain API keys, connection strings and other private information that will be transmitted to the Operation Code folks separately.

To create a new database for this application, create a database with the name of your choice on a Microsoft SQL Server instance (SQL Server 2016, any edition), then run the following files from the /Sabio.Web/App_Data folder in this order, replacing [XYZ] with the name of your database in square brackets using SQL Server Management Studio:

1. DeployAppCreate.sql
2. DeployAppData.sql
3. DeployAppSprocs.sql

Then modify the ConnectionStrings.config to reflect the corresponding connection string for your server and database.

The API keys and other settings for SendGrid, Google Maps API, Twilio, Amazon AWS S3 file storage, etc. are stored in the PrivateSettings.config file and should be changed to reflect the Operation Code accounts.
