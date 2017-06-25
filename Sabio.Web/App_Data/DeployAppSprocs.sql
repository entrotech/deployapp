/*
	Stored Procedures for Deploy Application



*/

/****** Object:  StoredProcedure [dbo].[AddBlogComments]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[AddBlogComments] 
@Name nvarchar(50),
@Email nvarchar(50),
@comment nvarchar(max),
@Id int Output


AS
Begin
Insert Into [Comments]
( Name, Email, Comment)
Values(@Name, @Email, @Comment)
select @id = SCOPE_IDENTITY()
end


GO
/****** Object:  StoredProcedure [dbo].[Announcement_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Announcement_Delete]
	@id int

/* --- TEST CODE ---

	DECLARE @id int = 1

	SELECT *
	FROM dbo.Announcement
	WHERE Id = @id

	EXECUTE dbo.Announcement_Delete
		@id

	SELECT *
	FROM dbo.Announcement
	WHERE Id = @id

*/

AS

BEGIN

	DELETE FROM [dbo].[Announcement]
	WHERE Id = @id

END



GO
/****** Object:  StoredProcedure [dbo].[Announcement_DeleteImage]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Announcement_DeleteImage]
	@id int

AS

/*

	SELECT *
	FROM dbo.Announcement

	EXEC dbo.Announcement_DeleteImage
		113

*/

BEGIN
	UPDATE dbo.Announcement
	SET PhotoKey = NULL 
	WHERE Id = @id
END

GO
/****** Object:  StoredProcedure [dbo].[Announcement_ImageUpload]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Announcement_ImageUpload]
	@photoKey nvarchar(150),
	@id int

AS

BEGIN
	UPDATE Announcement
	SET PhotoKey = @photoKey
	WHERE Id = @id
END

GO
/****** Object:  StoredProcedure [dbo].[Announcement_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Announcement_Insert]
	@title nvarchar(50)
	,@body nvarchar(4000)
	,@announcementCategoryId int
	,@userId nvarchar(128)
	,@id int OUTPUT

/* -- TEST CODE ---
	
	DECLARE	@personId int = 168 
		,@title nvarchar(50) = 'test announcement'
		,@body nvarchar(4000) = 'body'
		,@announcementCategoryId int = 2
		,@userId nvarchar(128) = 'abc1'
		,@id int = 0

	EXECUTE dbo.Announcement_Insert
		@personId
		,@title
		,@body
		,@announcementCategoryId
		,@userId
		,@id OUTPUT
	
	SELECT *
	FROM dbo.Announcement
	WHERE Id = @id

*/

AS

BEGIN	
	
	INSERT INTO [dbo].[Announcement]
		([PersonId]
		,[Title]
		,[Body]
		,[AnnouncementCategoryId]
		,[UserIdCreated])
	SELECT
		p.Id
		,@title
		,@body
		,@announcementCategoryId
		,@userId
	FROM Person p
	WHERE p.AspNetUserId = @userId

	SET @id = SCOPE_IDENTITY()

END



GO
/****** Object:  StoredProcedure [dbo].[Announcement_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Announcement_SelectAll]

/* --- TEST CODE ---
	
	SELECT *
	FROM dbo.Announcement

	EXECUTE dbo.Announcement_SelectAll

*/

AS

BEGIN

	SELECT A.Id
		, A.PersonId
		, A.Title
		, A.Body
		, A.AnnouncementCategoryId
		, AC.CategoryName
		, A.DateCreated
		, P.FirstName AS PersonFirstName
		, P.LastName AS PersonLastName
		, A.PhotoKey
	FROM [dbo].[Announcement] AS A
		INNER JOIN AnnouncementCategory AS AC
		ON A.AnnouncementCategoryId = AC.Id
		INNER JOIN Person AS P
		ON A.PersonId = P.Id
	ORDER BY A.DateCreated DESC

END



GO
/****** Object:  StoredProcedure [dbo].[Announcement_SelectByCategory]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Announcement_SelectByCategory]
	@announcementCategoryId int

/* --- TEST CODE ---

	DECLARE @categoryId int = 2

	EXECUTE dbo.Announcement_SelectByCategory
		@categoryId

*/

AS

BEGIN

	SELECT [Id]
		,[PersonId]
		,[Title]
		,[Body]
		,[AnnouncementCategoryId]
		,[DateCreated]
		,[DateModified]
		,[UserIdCreated]
	
	FROM [dbo].[Announcement]
	WHERE AnnouncementCategoryId = @announcementCategoryId

END



GO
/****** Object:  StoredProcedure [dbo].[Announcement_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Announcement_SelectById]
	@id int

/* --- TEST CODE ---

	DECLARE @id int = 107

	EXECUTE dbo.Announcement_SelectById
		@id

*/

AS

BEGIN
	SELECT A.Id
		, A.PersonId
		, A.Title
		, A.Body
		, A.AnnouncementCategoryId
		, AC.CategoryName
		, A.DateCreated
		, P.FirstName AS PersonFirstName
		, P.LastName AS PersonLastName
		, A.PhotoKey
	FROM [dbo].[Announcement] AS A
		INNER JOIN AnnouncementCategory AS AC
		ON A.AnnouncementCategoryId = AC.Id
		INNER JOIN Person AS P
		ON A.PersonId = P.Id
	WHERE A.Id = @id
END



GO
/****** Object:  StoredProcedure [dbo].[Announcement_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Announcement_Update]
	@title nvarchar(50)
	, @body nvarchar(4000)
	, @announcementCategoryId int
	, @userId nvarchar(128)
	, @id int

/* --- TEST CODE ---

	EXECUTE dbo.Announcement_Update
		'test title'
		, 'test body'
		, 3
		, 'abcd123'
		, 104

*/

AS

BEGIN

	DECLARE @dateNow datetime2 = GETUTCDATE()

	UPDATE [dbo].[Announcement]
	SET [Title] = @title
		, [Body] = @body
		, [AnnouncementCategoryId] = @announcementCategoryId
		, [DateModified] = @dateNow
		, [UserIdCreated] = @userId
	WHERE Id = @id

END



GO
/****** Object:  StoredProcedure [dbo].[AnnouncementAndCategory_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AnnouncementAndCategory_SelectAll]

/* --- TEST CODE ---

	EXECUTE [dbo].[AnnouncementAndCategory_SelectAll]

*/

AS

BEGIN

	--------- ALL CATEGORIES WITH TOTALS ---------	
	SELECT 
		COUNT(*) AS CategoryTotal 
		, A.AnnouncementCategoryId
		, AC.CategoryName
	FROM dbo.Announcement A
		INNER JOIN AnnouncementCategory AC ON AC.Id = A.AnnouncementCategoryId
	GROUP BY A.AnnouncementCategoryId, AC.CategoryName

	--------- ALL ANNOUNCEMENTS ---------
	SELECT A.Id
			, A.PersonId
			, A.Title
			, A.Body
			, A.AnnouncementCategoryId
			, AC.CategoryName
			, A.DateCreated
			, P.FirstName AS PersonFirstName
			, P.LastName AS PersonLastName
			, A.PhotoKey
		FROM dbo.Announcement AS A
			INNER JOIN AnnouncementCategory AS AC ON A.AnnouncementCategoryId = AC.Id
			INNER JOIN Person AS P ON A.PersonId = P.Id
		ORDER BY A.DateCreated DESC		

END



GO
/****** Object:  StoredProcedure [dbo].[AspNetRoles_GetAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[AspNetRoles_GetAll]

AS

/* TEST CODE

EXECUTE		dbo.AspNetRoles_GetAll

*/

BEGIN

	SELECT [Id]
		  ,[Name]
	  FROM [dbo].[AspNetRoles]

END




GO
/****** Object:  StoredProcedure [dbo].[AspNetUserRoles_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AspNetUserRoles_Delete] 
	@UserId nvarchar(128)
	, @Role nvarchar(256)
AS
/* TEST CODE

	DECLARE
		@UserId nvarchar(128) = '01a3a909-29f1-4dae-8cc9-4a2768c028da'
		, @Role nvarchar(256) = 'User'

	SELECT *
	FROM AspNetUserRoles
	WHERE UserId = @UserId AND RoleId = (SELECT Id
		FROM AspNetRoles
		WHERE [Name] = @Role)

	EXEC AspNetUserRoles_Delete
		@UserId
		, @Role

	SELECT *
	FROM AspNetUserRoles
	WHERE UserId = @UserId AND RoleId = (SELECT Id
		FROM AspNetRoles
		WHERE [Name] = @Role)
*/
BEGIN
	
	DELETE FROM AspNetUserRoles
	WHERE UserId = @UserId AND RoleId = (SELECT Id
		FROM AspNetRoles
		WHERE [Name] = @Role)

END



GO
/****** Object:  StoredProcedure [dbo].[AspNetUserRoles_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AspNetUserRoles_Insert]
	@UserId nvarchar(128)
	, @Role nvarchar(256)
AS
/* TEST CODE

	DECLARE
		@UserId nvarchar(128) = '6bfd9970-2e37-4809-a5fa-25cf7e366802'
		, @Role nvarchar(256) = 'User'

	EXEC AspNetUserRoles_Insert
		@UserId
		, @Role

	SELECT *
	FROM AspNetUserRoles
	WHERE UserId = @UserId
*/
BEGIN
	
	INSERT INTO AspNetUserRoles (UserId, RoleId)
	VALUES (@UserId, (SELECT Id
		FROM AspNetRoles
		WHERE [Name] = @Role))
	
	 
END


GO
/****** Object:  StoredProcedure [dbo].[AspNetUserRoles_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AspNetUserRoles_Search]
	@Name nvarchar(128) = NULL
	, @Role nvarchar(128) = NULL
	, @CurrentPage int = 1
	, @ItemsPerPage int = 10
AS
/* TEST CODE
	
	EXEC AspNetUserRoles_Search
		NULL
		, 'user'
		, 1
		, 10
		
*/
BEGIN

	SELECT @Name = ISNULL(@Name, ''), @Role = ISNULL(@Role, '')

	SELECT p.FirstName
	, p.LastName
	, p.Email
	, p.AspNetUserId
	, count(*) over () totalRows
	, CASE WHEN SUM(CASE WHEN anr.[Name] = 'User' THEN 1 ELSE 0 END) = 1 THEN CONVERT (bit, 1) ELSE CONVERT (bit, 0) END AS hasUsr
	, CASE WHEN SUM(CASE WHEN anr.[Name] = 'Manager' THEN 1 ELSE 0 END) = 1 THEN CONVERT (bit, 1) ELSE CONVERT (bit, 0) END AS hasMgr
	, CASE WHEN SUM(CASE WHEN anr.[Name] = 'Admin' THEN 1 ELSE 0 END) = 1 THEN CONVERT (bit, 1) ELSE CONVERT (bit, 0) END AS hasAdm
	INTO #Result
	FROM Person p
		LEFT JOIN AspNetUserRoles anur
		ON p.AspNetUserId = anur.UserId
		LEFT JOIN AspNetRoles anr
		ON anur.RoleId = anr.Id
	WHERE p.IsDeleted = 0
		AND AspNetUserId IS NOT NULL
		AND (p.FirstName LIKE '%' + @Name + '%' OR p.LastName LIKE '%' + @Name + '%' OR p.Email LIKE '%' + @Name + '%')		
	GROUP BY p.FirstName, p.LastName, p.Email, p.AspNetUserId
	

	SELECT DISTINCT r.*
	FROM #Result r
		LEFT JOIN AspNetUserRoles anur
		ON r.AspNetUserId = anur.UserId
		LEFT JOIN AspNetRoles anr
		ON anur.RoleId = anr.Id
	WHERE (@Role = '' OR anr.[Name] LIKE '%' + @Role + '%')
	ORDER BY r.FirstName
	OFFSET @ItemsPerPage * (@CurrentPage - 1) ROWS
	FETCH NEXT @ItemsPerPage ROWS ONLY

END


GO
/****** Object:  StoredProcedure [dbo].[AspNetUserRoles_SelectByUserId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AspNetUserRoles_SelectByUserId]
	@UserId nvarchar(128)
AS

--EXEC AspNetUserRoles_SelectByUserId '991aa9e6-6458-4cad-8851-6c0d13f1278e'

BEGIN

	SELECT 
		p.AspNetUserId
		, CASE WHEN SUM(CASE WHEN anr.[Name] = 'User' THEN 1 ELSE 0 END) = 1 THEN CONVERT (bit, 1) ELSE CONVERT (bit, 0) END AS hasUsr
		, CASE WHEN SUM(CASE WHEN anr.[Name] = 'Manager' THEN 1 ELSE 0 END) = 1 THEN CONVERT (bit, 1) ELSE CONVERT (bit, 0) END AS hasMgr
		, CASE WHEN SUM(CASE WHEN anr.[Name] = 'Admin' THEN 1 ELSE 0 END) = 1 THEN CONVERT (bit, 1) ELSE CONVERT (bit, 0) END AS hasAdm
	FROM Person p
		LEFT JOIN AspNetUserRoles anur ON p.AspNetUserId = anur.UserId
		LEFT JOIN AspNetRoles anr ON anur.RoleId = anr.Id
	WHERE UserId = @UserId	
	GROUP BY p.AspNetUserId

END



GO
/****** Object:  StoredProcedure [dbo].[AspNetUsers_ConfirmEmail]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AspNetUsers_ConfirmEmail]
			@Id NVARCHAR(128)
AS

/* TEST CODE

DECLARE @Id NVARCHAR(128) = 'ecc70f11-c5b2-42be-aa66-7facf122a85a'

SELECT *
FROM dbo.AspNetUsers
WHERE Id = @Id

EXECUTE dbo.AspNetUsers_ConfirmEmail
		@Id

SELECT *
FROM dbo.AspNetUsers
WHERE Id = @Id

*/

BEGIN

	UPDATE [dbo].[AspNetUsers]
	   SET [EmailConfirmed] = 1
      
	 WHERE Id = @Id

END




GO
/****** Object:  StoredProcedure [dbo].[AspNetUsers_Validate]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AspNetUsers_Validate]

@Email nvarchar(256)
,@EmailConfirmed bit OUT
,@TokenCreated Datetime2(7) OUT

AS BEGIN
/* TEST CODE
DECLARE @EmailConfirmed bit 
,@TokenCreated Datetime2(7)

EXEC AspNetUsers_Validate 
'html@mailinator.com', @EmailConfirmed OUT, @TokenCreated OUT

SELECT @EmailConfirmed AS EmailConfirmed, @TokenCreated AS TokenCreated


EXEC AspNetUsers_Validate 
'stallone@mailinator.com'

EXEC AspNetUsers_Validate 
'one@mailinator.com'





*/
DECLARE
	
	@AspNetUserId nvarchar(120)
	

	SELECT @EmailConfirmed =EmailConfirmed, @AspNetUserId=Id
	FROM AspNetUsers
	WHERE Email=@Email

	IF (@EmailConfirmed IS NULL OR @EmailConfirmed=0)

	BEGIN
	SELECT @TokenCreated=DateCreated
	FROM SecurityToken
	WHERE AspNetUserId =@AspNetUserId
	END

	--SELECT @EmailConfirmed AS EmailConfirmed,@TokenCreated AS TokenCreated
	

	





END


GO
/****** Object:  StoredProcedure [dbo].[Blog_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Blog_Delete]
            @id int

AS
/*

EXECUTE dbo.Blog_Delete
        @id = 71
*/
BEGIN

	DELETE FROM dbo.BlogBlogTag
		  WHERE BlogId = @id

	DELETE FROM [dbo].[Blog]
		  WHERE Id = @id
		  
    DELETE FROM [dbo].[BlogBlogPhoto]
		  WHERE BlogId = @id

END
-- select * from blogBlogPhoto






GO
/****** Object:  StoredProcedure [dbo].[Blog_DeletePhoto]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Blog_DeletePhoto]
@Id int, 
@FileName nvarchar(150) Output
As 
Begin

Select @fileName = PhotoKey from BlogPhoto where id =@id
delete BlogBlogPhoto where BlogPhotoid = @Id
delete BlogPhoto where id= @Id 
 
 
 --Declare @fileName nvarchar(150)
 --Exec Blog_DeletePhoto 17, @fileName output
  

End

GO
/****** Object:  StoredProcedure [dbo].[Blog_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Blog_Insert]
		  @userIdCreated nvarchar(128),
		  @title nvarchar(200),
		  @body nvarchar(MAX),
		  @blogCategory nvarchar(50),
		  @private bit,
		  @blogTagIds dbo.IntIdTable READONLY,
		  @id int OUTPUT
		
AS

DECLARE @PersonId int

/* Test Code

	DECLARE @userIdCreated nvarchar(128) = 'me',
			@title nvarchar(200) = 'ahhh',
			@body nvarchar(MAX) = 'noooooo',
			@blogCategory nvarchar(50) = 'General',
			@private bit = 0,
			@blogTagIds dbo.IntIdTable,
			@id int

	INSERT @blogTagIds (data)
	VALUES(9)

	INSERT @blogTagIds (data)
	VALUES(10)

	EXECUTE dbo.Blog_Insert
			@userIdCreated,
			@title,
			@body,
			@blogCategory,
			@private,
			@blogTagIds,
			@id OUTPUT
	SELECT *
	FROM dbo.Blog
	WHERE Id = @id

*/  
BEGIN
	INSERT INTO [dbo].[blog](
		        [UserIdCreated],
			    [Title],
				[Body],
				[BlogCategory],
				[Private]
				) 
	VALUES(
			@userIdCreated,
			@title,
			@body,
			@blogCategory,
			@private
			) 

	SET @id = SCOPE_IDENTITY()

	INSERT INTO [dbo].[BlogBlogTag]
				    ([BlogId],
					 [BlogTagId])
	SELECT @id AS BlogId, data AS BlogTagId
	  FROM @blogTagIds

END	  

       



GO
/****** Object:  StoredProcedure [dbo].[Blog_InsertPhotoKey]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROC [dbo].[Blog_InsertPhotoKey] 
@PhotoKey nvarchar(50),
@BlogId int,
@id int Output
AS
BEGIN
	insert into BlogPhoto(PhotoKey)
	Values(@PhotoKey)
	SET @id = SCOPE_IDENTITY()
	
INSERT INTO [dbo].[BlogBlogPhoto]
           ([BlogId]
           ,[BlogPhotoId])
     VALUES
           (@blogId
           ,@Id)
END


GO
/****** Object:  StoredProcedure [dbo].[Blog_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC Blog_Search
		 ''
		 ,'General'
		, 1
		, 10
		
*/
CREATE PROCEDURE [dbo].[Blog_Search]
	 @SearchStr nvarchar(128) = NULL
	, @Category nvarchar(128) = Null
	, @CurrentPage int = 1 
	, @ItemsPerPage int = 6
	
AS

BEGIN
SELECT @SearchStr = ISNULL(@SearchStr, '')
SELECT @Category = ISNULL(@Category, '')

SELECT Id, UserIdCreated, Title, Body, BlogCategory, Private, DateCreated, DateModified
	, count(*) over () totalRows
	INTO #BResult
	FROM Blog 
	WHERE (Title LIKE '%' +  @SearchStr + '%' OR Body LIKE '%' +  @SearchStr + '%') AND BlogCategory Like '%' + @category+ '%'
	

	SELECT DISTINCT *
	FROM #BResult
	Order By DateCreated
	OFFSET @ItemsPerPage * (@CurrentPage - 1) ROWS
	FETCH NEXT @ItemsPerPage ROWS ONLY

END


GO
/****** Object:  StoredProcedure [dbo].[Blog_Search2]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Blog_Search2]
@SearchStr  nvarchar(50)

AS
BEGIN
   /*
   EXECUTE dbo.Blog_Search2 "ab"
   */

   SELECT 
       B.[Id]
      ,B.[UserIdCreated]
      ,B.[Title]
      ,B.[Body]
      ,B.[BlogCategory]
      ,B.[Private]
      ,B.[DateCreated]
      ,B.[DateModified],
	  P.Email, 
	  P.FirstName,
	  P.LastName,
	  P.PhotoKey
	 INTO #Result
FROM [dbo].[Blog] AS B
Join Dbo.Person AS P
ON B.UserIdCreated = P.aspnetuserId
WHERE (B.Title LIKE '%' +  @SearchStr + '%' OR B.Body LIKE '%' +  @SearchStr + '%')
Order By B.DateCreated

select * from #Result

  SELECT bbt.BlogId,
		   bbt.BlogTagId,
		   bt.Keyword
	FROM BlogBlogTag bbt
	JOIN BlogTag bt
		ON bbt.BlogTagId = bt.Id

		select bbp.BlogId,
		bbp.BlogPhotoId, 
		bp.PhotoKey
		From BlogBlogPhoto bbp 
		join BlogPhoto bp
		On bbp.BlogPhotoId = bp.Id
		
		Where Exists (select id from #Result WHERE #result.id = bbp.BlogId)

		
END







GO
/****** Object:  StoredProcedure [dbo].[Blog_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Blog_SelectAll]
            

AS
BEGIN
   /*
   EXECUTE dbo.Blog_SelectAll
   */

   SELECT  B.[Id]
      ,B.[UserIdCreated]
      ,B.[Title]
      ,B.[Body]
      ,B.[BlogCategory]
      ,B.[Private]
      ,B.[DateCreated]
      ,B.[DateModified],
	  P.Email, 
	  P.FirstName,
	  P.LastName,
	  P.PhotoKey
	 
FROM [dbo].[Blog] AS B
 Join Dbo.Person AS P
ON B.UserIdCreated = P.aspnetuserId
Order By B.DateCreated


  SELECT bbt.BlogId,
		   bbt.BlogTagId,
		   bt.Keyword
	FROM BlogBlogTag bbt
	JOIN BlogTag bt
		ON bbt.BlogTagId = bt.Id

		select bbp.BlogId,
		bbp.BlogPhotoId, 
		bp.PhotoKey
		From BlogBlogPhoto bbp 
		join BlogPhoto bp
		On bbp.BlogPhotoId = bp.Id

END







GO
/****** Object:  StoredProcedure [dbo].[Blog_SelectAllByUserId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Blog_SelectAllByUserId]
 @userIdCreated nvarchar(50)

AS
BEGIN
   /*
   EXECUTE dbo.Blog_SelectAll
   */

   SELECT  B.[Id]
      ,B.[UserIdCreated]
      ,B.[Title]
      ,B.[Body]
      ,B.[BlogCategory]
      ,B.[Private]
      ,B.[DateCreated]
      ,B.[DateModified],
	  P.Email, 
	  P.FirstName,
	  P.LastName,
	  P.PhotoKey
	 
FROM [dbo].[Blog] AS B
 Join Dbo.Person AS P
ON B.UserIdCreated = P.aspnetUserId
WHERE B.UserIdCreated = @userIdCreated
Order By B.DateCreated


 -- SELECT bbt.BlogId,
	--	   bbt.BlogTagId,
	--	   bt.Keyword
	--FROM BlogBlogTag bbt
	--JOIN BlogTag bt
	--	ON bbt.BlogTagId = bt.Id

	--	select bbp.BlogId,
	--	bbp.BlogPhotoId, 
	--	bp.PhotoKey
	--	From BlogBlogPhoto bbp 
	--	join BlogPhoto bp
	--	On bbp.BlogPhotoId = bp.Id

END







GO
/****** Object:  StoredProcedure [dbo].[Blog_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Blog_SelectById]
    @id int

AS

BEGIN


--   EXECUTE dbo.Blog_SelectById 77

  SELECT  B.[Id]
      ,B.[UserIdCreated]
      ,B.[Title]
      ,B.[Body]
      ,B.[BlogCategory]
      ,B.[Private]
      ,B.[DateCreated]
      ,B.[DateModified],
	  P.Email, 
	  P.FirstName,
	  P.LastName,
	  P.PhotoKey
	 
FROM [dbo].[Blog] AS B
Join Dbo.Person AS P
ON B.UserIdCreated = P.aspnetUserId
  WHERE B.Id = @Id

	SELECT bbt.BlogId,
		   bbt.BlogTagId,
		   bt.Keyword
	FROM BlogBlogTag bbt
	JOIN BlogTag bt
		ON bbt.BlogTagId = bt.Id
		WHERE bbt.BlogId = @id
  
  select bbp.BlogId,
		bbp.BlogPhotoId, 
		bp.PhotoKey as BlogPhoto
		From BlogBlogPhoto bbp 
		join BlogPhoto bp
		On bbp.BlogPhotoId = bp.Id
		where bbp.BlogId = @id

END








GO
/****** Object:  StoredProcedure [dbo].[Blog_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Blog_Update]
           @userIdCreated nvarchar(128),
		   @title nvarchar(200),
		   @body nvarchar(MAX),
		   @blogCategory nvarchar(50),
		   @private bit,
		   @blogTagIds dbo.IntIdTable READONLY,
		   @id int

AS	

	DECLARE @dateModified datetime2(7) = GETUTCDATE();

BEGIN
/*

	DECLARE @userIdCreated nvarchar(128) = '186a6dc9-4428-4ee4-9125-858a2a745d95',
			@title nvarchar(200) = 'ah',
			@body nvarchar(MAX) = 'ah',
			@blogCategory nvarchar(50) = 'General',
			@private bit = 0,
			@blogTagIds dbo.IntIdTable,
			@id int = 113
	DELETE FROM dbo.BlogBlogTag
		  WHERE BlogId = @id

	INSERT @blogTagIds (data)
	VALUES(8), (9),(23), (24), (25)

	EXECUTE dbo.Blog_Update			
			@userIdCreated,
			@title,
			@body,
			@blogCategory,
			@private,
			@blogTagIds,
			@id

	SELECT *
	FROM dbo.BlogBlogTag
	WHERE BlogId = @id

	SELECT *
	FROM dbo.Blog
	WHERE Id = @id

*/



	UPDATE dbo.Blog
	   SET [UserIdCreated] = @userIdCreated,
		   [Title] = @title,
		   [Body] = @body,
		   [BlogCategory] = @blogCategory,
		   [Private] = @private,
		   [DateModified] = @dateModified
	WHERE Id = @id

	DELETE FROM dbo.BlogBlogTag
	WHERE BlogId = @id

	INSERT INTO [dbo].[BlogBlogTag]
				([BlogId],
				 [BlogTagId])

	SELECT @id AS BlogId, data AS BlogTagId
	  FROM @blogTagIds



END




GO
/****** Object:  StoredProcedure [dbo].[BlogBlogTag_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BlogBlogTag_Delete]
			@blogId int,
			@blogTagId int

AS

/* TEST CODE

DECLARE @blogId INT = 46,
		@blogTagId INT = 3

SELECT *
FROM dbo.BlogBlogTag
WHERE BlogId = @blogId AND BlogTagId = @blogTagId

EXECUTE dbo.BlogBLogTag_Delete
		@blogId,
		@blogTagId

SELECT *
FROM dbo.BlogBlogTag
WHERE BlogId = @blogId AND BlogTagId = @blogTagId

*/

BEGIN

DELETE FROM [dbo].[BlogBlogTag]
      WHERE BlogId = @blogId AND BlogTagId = @blogTagId

END


GO
/****** Object:  StoredProcedure [dbo].[BlogBlogTag_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[BlogBlogTag_Insert]
            @blogId int,
			@blogTagId int

AS

/* TEST CODE

DECLARE @blogId int = 46,
		@blogTagId int =3

EXECUTE dbo.BlogBlogTag_Insert
		@blogId,
		@blogTagId

SELECT *
FROM dbo.BlogBlogTag

*/


BEGIN

INSERT INTO [dbo].[BlogBlogTag]
           ([BlogId]
           ,[BlogTagId])
     VALUES
           (@blogId
           ,@blogTagId)

END



GO
/****** Object:  StoredProcedure [dbo].[BlogBlogTag_SelectByBlogId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[BlogBlogTag_SelectByBlogId]
			@blogId int

AS

/* TEST CODE

DECLARE @blogId int = 47

EXECUTE dbo.BlogBlogTag_SelectByBlogId
			@blogId

*/

BEGIN

	SELECT [BlogTagId]
		  ,dbo.BlogTag.Keyword
	  FROM [dbo].[BlogBlogTag]
	  JOIN dbo.BlogTag ON dbo.BlogBlogTag.BlogTagId = dbo.BlogTag.Id
	  WHERE BlogId = @blogId


END



GO
/****** Object:  StoredProcedure [dbo].[BlogBlogTag_SelectByBlogTagId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[BlogBlogTag_SelectByBlogTagId]
			@blogTagId int

AS

/* TEST CODE

DECLARE @blogTagId int = 3

EXECUTE dbo.BlogBlogTag_SelectByBlogTagId
			@blogTagId 

*/

BEGIN

	SELECT [BlogId]
		  ,dbo.Blog.UserIdCreated
		  ,dbo.Blog.Title
		  ,dbo.Blog.Body
		  ,dbo.Blog.BlogCategory
		  ,dbo.Blog.Private

	  FROM [dbo].[BlogBlogTag]
	  JOIN dbo.Blog ON dbo.BlogBlogTag.BlogId = dbo.Blog.Id
	  WHERE BlogTagId = @blogTagId

END



GO
/****** Object:  StoredProcedure [dbo].[BlogComment_Approve]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BlogComment_Approve]
@Id int
AS 
BEGIN

Update  BlogComment 
Set isApproved = 'true'
Where Id = @Id
  End

  -- Exec blogComment_Approve 11

GO
/****** Object:  StoredProcedure [dbo].[BlogComment_CascadeDelete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[BlogComment_CascadeDelete]
As
Begin 


ALTER TABLE [dbo].BlogComment WITH CHECK ADD CONSTRAINT 
[FK_BlogComment] FOREIGN KEY(ParentId)
REFERENCES [dbo].[BlogComment] (Id)
ON DELETE CASCADE


End

GO
/****** Object:  StoredProcedure [dbo].[BlogComment_delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BlogComment_delete]
@id Int
AS
Begin

WITH    q AS
        (
        SELECT  id, ParentId
        FROM    BlogComment
        WHERE   id = @Id
                --AND ParentId = 156
        UNION ALL
        SELECT  tc.id, tc.parentId
        FROM    q
        JOIN    BlogComment tc
        ON      tc.parentID = q.id
                --AND tc.parentId = q.ParentId
        )
DELETE
FROM    BlogComment
OUTPUT  DELETED.*
WHERE   EXISTS
        (
        SELECT  id, parentId
        INTERSECT
        SELECT  id, parentId
        FROM    q
        )
End
-- Exec BlogComment_Delete 11


--insert into BlogComment 
--select Comment, DateCreated, 
--DateModified, BlogId, ParentId, UserIdCreated, IsApproved from BlogComment


GO
/****** Object:  StoredProcedure [dbo].[BlogComment_DeleteCascade]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BlogComment_DeleteCascade]
@id Int
AS
Begin

WITH    q AS
        (
        SELECT  id, ParentId
        FROM    BlogComment
        WHERE   id = @Id
                --AND ParentId = 156
        UNION ALL
        SELECT  tc.id, tc.parentId
        FROM    q
        JOIN    BlogComment tc
        ON      tc.parentID = q.id
                --AND tc.parentId = q.ParentId
        )
DELETE
FROM    BlogComment
OUTPUT  DELETED.*
WHERE   EXISTS
        (
        SELECT  id, parentId
        INTERSECT
        SELECT  id, parentId
        FROM    q
        )
End

GO
/****** Object:  StoredProcedure [dbo].[BlogComment_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BlogComment_Insert]
@Comment nvarchar(Max),
@BlogId int,
@ParentId int = Null,
@UseridCreated nvarchar(100),
@IsApproved bit = 'true',
@Id int Output
AS 
BEGIN
INSERT INTO [dbo].[BlogComment]
           ([Comment]
           ,[BlogId]
		   ,[ParentId]
		   ,[UserIdCreated],
		   IsApproved)
     VALUES
			(@Comment,
			 @BlogId,
			 @ParentId,
			 @userIdCreated,
			 @IsApproved)
	 SELECT @Id = SCOPE_IDENTITY()
  End


GO
/****** Object:  StoredProcedure [dbo].[BlogComment_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BlogComment_SelectAll]
@Id int
AS 
BEGIN
--SELECT b.[Id]
--     ,B.[Comment]
--      ,B.[DateCreated]
--      ,[BlogId]
--	  ,B.UserIdCreated
--    , p.FirstName
--	  ,p.LastName
--	  ,p.Email
--	  ,p.PhotoKey
--	   ,B.[ParentId]
	 
--  FROM [dbo].[BlogComment] B
-- Join AspNetUsers As A
--    On b.UserIdCreated = A.Id
--	Join Person AS P
--	On P.AspNetUserId = A.Id
--  WHERE BlogID = @BlogId 
--  End


   With
  blogCommentCTE (Id, comment, DateCreated, BlogId, UserIdCreated, ParentId, [Level], IsApproved)
  as
  (
    Select Id, comment, DateCreated, BlogId, UserIdCreated, ParentId, 1, BlogComment.IsApproved
    from BlogComment
    where ParentId is null 
    
    union all
    
    Select BlogComment.Id, BlogComment.Comment,  BlogComment.DateCreated, BlogComment.BlogId, BlogComment.UserIdCreated, BlogComment.ParentId, blogCommentCTE.[Level] + 1, BlogComment.IsApproved
    from BlogComment
    join blogCommentCTE
    on BlogComment.ParentId = blogCommentCTE.Id
  )

Select blogCTE.Id, blogCTE.comment, blogCTE.DateCreated, blogCTE.BlogId, blogCTE.UserIdCreated, P.FirstName, P.LastName, p.Email, P.PhotoKey, blogCTE.ParentId,
blogCTE.[Level], blogCTE.IsApproved
from blogCommentCTE blogCTE
left join blogCommentCTE parentCTE
on blogCTE.ParentId = parentCTE.Id
Inner Join Person As P
On BlogCTE.UserIdCreated = P.AspNetUserId
Where blogCTE.BlogId = @Id
Order By blogCTE.Level
End

  -- Exec BlogComment_selectAll 76

GO
/****** Object:  StoredProcedure [dbo].[BlogComment_SelectByBlogId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[BlogComment_SelectByBlogId]
@Id int
AS
Begin

  With
  blogCommentCTE (Id, comment, DateCreated, BlogId, UserIdCreated, ParentId, [Level], IsApproved)
  as
  (
    Select Id, comment, DateCreated, BlogId, UserIdCreated, ParentId, 1, BlogComment.IsApproved
    from BlogComment
    where ParentId is null 
    
    union all
    
    Select BlogComment.Id, BlogComment.Comment,  BlogComment.DateCreated, BlogComment.BlogId, BlogComment.UserIdCreated, BlogComment.ParentId, blogCommentCTE.[Level] + 1, BlogComment.IsApproved
    from BlogComment
    join blogCommentCTE
    on BlogComment.ParentId = blogCommentCTE.Id
  )

Select blogCTE.Id, blogCTE.comment, blogCTE.DateCreated, blogCTE.BlogId, blogCTE.UserIdCreated, P.FirstName, P.LastName, p.Email, P.PhotoKey, blogCTE.ParentId,
blogCTE.[Level], BlogCTE.IsApproved
from blogCommentCTE blogCTE
left join blogCommentCTE parentCTE
on blogCTE.ParentId = parentCTE.Id
Inner Join Person As P
On BlogCTE.UserIdCreated = P.AspNetUserId
Where blogCTE.BlogId = @Id and BlogCTE.IsApproved=1
Order By blogCTE.Level
END

--    Exec BlogComment_SelectByBlogId 76

--     Exec BlogComment_selectAll 77

-- select * from blogComment




GO
/****** Object:  StoredProcedure [dbo].[BlogComment_SelectByBlogId2]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[BlogComment_SelectByBlogId2]
@Id int
AS
Begin

  With
  blogCommentCTE (Id,  DateCreated, Comment, BlogId, ParentId, UserIdCreated, [Level])
  as
  (
    Select Id, DateCreated, Comment, BlogId, ParentId, UserIdCreated, 1
    from BlogComment
    where ParentId is null
    
    union all
    
    Select BlogComment.Id, BlogComment.DateCreated, BlogComment.Comment, BlogComment.BlogId, BlogComment.ParentId, BlogComment.UserIdCreated, blogCommentCTE.[Level] + 1
    from BlogComment
    join blogCommentCTE
    on BlogComment.ParentId = blogCommentCTE.Id
  )
Select blogCTE.Id, blogCTE.DateCreated, blogCTE.Comment ,blogCTE.BlogId, blogCTE.ParentId, blogCTE.UserIdCreated,
blogCTE.[Level] 
Into #CommentResult
from blogCommentCTE blogCTE
left join blogCommentCTE parentCTE
on blogCTE.ParentId = parentCTE.Id
Where blogCTE.BlogId = @Id



   Select C.id, C.comment, C.DateCreated, C.BlogId, C.ParentId, P.FirstName, p.LastName, P.Email, P.PhotoKey, C.Level
   FROM #CommentResult AS C
   Join AspNetUsers As A
    On C.UserIdCreated = A.Id
	Join Person AS P
	On P.AspNetUserId = A.Id
	Order By C.Level


--    Exec BlogComment_selectByBlogId2 76


-- select * from BlogComment


END 

GO
/****** Object:  StoredProcedure [dbo].[BlogComment_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BlogComment_Update]
@id int,
@Comment nvarchar(Max),
@BlogId int
AS
BEGIN
UPDATE  [dbo].[BlogComment]
        SET 
		  
           [Comment]=@Comment
           ,[BlogId]=@BlogId
		WHERE id = @id
  End


GO
/****** Object:  StoredProcedure [dbo].[BlogTag_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[BlogTag_Delete]
            @id int

AS
/*

EXECUTE dbo.BlogTag_Delete
        @id = 3
*/
BEGIN

DELETE FROM [dbo].[BlogTag]
      WHERE Id = @id

END




GO
/****** Object:  StoredProcedure [dbo].[BlogTag_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[BlogTag_Insert]
            @keyword nvarchar(100),
            @id int OUTPUT
AS

BEGIN

/* Test Code

DECLARE @keyword nvarchar(100) = 'experience',
		@id int

EXECUTE dbo.BlogTag_Insert
        @keyword,
		@id OUTPUT
SELECT *
FROM dbo.Blog
WHERE Id = @id

*/  

INSERT INTO [dbo].[BlogTag] (
                  [Keyword]
                  )
VALUES (
       @keyword
       )
SET @id = SCOPE_IDENTITY()

END




GO
/****** Object:  StoredProcedure [dbo].[BlogTag_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[BlogTag_Search]
@searchString nvarchar(50)=''
AS

/* TEST CODE

EXECUTE dbo.BlogTag_search 

*/

BEGIN

	SELECT [Id]
		  ,[Keyword]
	  FROM [dbo].[BlogTag]
	  Where Keyword like '%' + @searchString+'%'

END






GO
/****** Object:  StoredProcedure [dbo].[BlogTag_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[BlogTag_SelectAll]

AS

/* TEST CODE

EXECUTE dbo.BlogTag_SelectAll

*/

BEGIN

	SELECT [Id]
		  ,[Keyword]
	  FROM [dbo].[BlogTag]


END






GO
/****** Object:  StoredProcedure [dbo].[BlogTag_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[BlogTag_Update]
            @keyword nvarchar(100),
			@id int
AS

/* TEST CODE

DECLARE		@keyword nvarchar(100) = 'java',
			@id int = 16

EXECUTE dbo.BlogTag_Update
			@keyword,
		    @id

SELECT *
FROM dbo.BlogTag
WHERE Id = @id

*/

BEGIN

	UPDATE [dbo].[BlogTag]
	   SET [Keyword] = @keyword
	
	WHERE Id = @id

END

GO
/****** Object:  StoredProcedure [dbo].[Company_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Company_Delete]
		@Id int
/*
	Declare @Id int = 4
	
	Select * From dbo.Company
	WHERE Id = @Id

	EXEC dbo.Company_Delete @Id

	Select * From dbo.Company
	WHERE Id = @Id

*/

As

Begin

		DELETE FROM CompanyPerson
		WHERE CompanyId = @Id
		
		Delete FROM dbo.Company
		WHERE Id = @Id

	
END



GO
/****** Object:  StoredProcedure [dbo].[Company_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Company_Insert]
			@CompanyIdCreated NVARCHAR(128)
			,@CompanyName NVARCHAR(100)
			,@CompanyPhoneNumber NVARCHAR(50)
			,@CompanyEmail NVARCHAR(100)
			,@Address1 NVARCHAR(50)
			,@Address2 NVARCHAR(50) = null
			,@City NVARCHAR(50)
			,@StateProvinceId INT
			,@CountryId INT
			,@PostalCode NVARCHAR(20)
			,@Inactive Bit
			,@IsDeploy BIT
			,@UserIdCreated nvarchar(128)
			,@Id INT OUTPUT


/*-----------Test Code--------


	Declare @CompanyIdCreated NVARCHAR(128) = '4'
			,@CompanyName NVARCHAR(100) = 'IMDB'
			,@CompanyPhoneNumber NVARCHAR(50) = 'TestPhone'
			,@CompanyEmail NVARCHAR(100) = 'testEmail' 
			,@Address1 NVARCHAR(50) = 'Test Address'
			,@Address2 NVARCHAR(50) = 'Suite 1'
			,@City NVARCHAR(50) = 'test City'
			,@StateProvinceId INT = 4
			,@CountryId INT = 4
			,@PostalCode NVARCHAR(20) = '95133'
			,@Inactive BIT = 0
			,@IsDeploy BIT = 0
			,@PersonId INT = 211
			,@Id INT 
	
	Execute dbo.Company_Insert
							@CompanyIdCreated
							,@CompanyName 
							,@CompanyPhoneNumber 
							,@CompanyEmail 
							,@Address1 
							,@Address2 
							,@City 
							,@StateProvinceId 
							,@CountryId 
							,@postalCode
							,@Inactive
							,@IsDeploy
							,@PersonId
							,@Id OUTPUT

	
	SELECT * FROM dbo.Company
	WHERE Id = @Id

	SELECT * FROM dbo.CompanyPerson
	
	Select * FROM dbo.Company
	
	Truncate table dbo.Company

*/
as

Begin



	INSERT INTO [dbo].[Company]
			   ([CompanyIdCreated]
			   ,[CompanyName]
			   ,[CompanyPhoneNumber]
			   ,[CompanyEmail]
			   ,[Address1]
			   ,[Address2]
			   ,[City]
			   ,[StateProvinceId]
			   ,[CountryId]
			   ,[PostalCode]
			   ,[Inactive]
			   ,IsDeploy)
		 VALUES
				(@CompanyIdCreated
				,@CompanyName
				,@CompanyPhoneNumber 
				,@CompanyEmail 
				,@Address1 
				,@Address2 
				,@City 
				,@StateProvinceId 
				,@CountryId
				,@PostalCode
				,@Inactive
				,@IsDeploy)

		Set @Id = SCOPE_IDENTITY()

		INSERT INTO CompanyPerson
					(CompanyId
					,PersonId)
	
		SELECT @Id, id
		FROM Person p 
		WHERE p.AspNetUserId = @UserIdCreated

	

End



GO
/****** Object:  StoredProcedure [dbo].[Company_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Company_Search]
			@SearchString NVARCHAR(1000)

As
/*
	DECLARE @SearchString NVARCHAR(1000) = 'sabio'


	EXECUTE dbo.Company_Search
			@SearchString
	
*/
Begin 
		
		SELECT   p.[Id]
				,p.[DateCreated]
				,p.[DateModified]
				,p.[CompanyName]
				,p.[CompanyPhoneNumber]
				,p.[CompanyEmail]
				,p.[Address1]
				,p.[Address2]
				,p.[City]
				,p.[StateProvinceId]
				,sp.StateProvinceCode
				,sp.Name stateName
				,p.[CountryId]
				,c.LongCode CountryLongCode
				,c.Code CountryCode
				,c.Name CountryName
				,p.[PostalCode]
				,p.[Inactive]
				,p.IsDeploy
				INTO #TempTable
				FROM [dbo].[Company] p
				LEFT JOIN StateProvince sp
					ON p.StateProvinceId = sp.Id
				LEFT JOIN Country c
					ON p.CountryId = c.Id
				WHERE (p.CompanyName LIKE '%' + @SearchString + '%'
					OR p.City LIKE '%' + @SearchString + '%')

		SELECT *
		FROM #TempTable

		SELECT	C.Id AS CompanyId
				,JP.Id AS JobPostingId
				,C.CompanyName
				,JP.PositionName
				,JP.StreetAddress
				,JP.City
				,JP.StateProvinceId
				,JP.CountryId
				,JP.Compensation
				,JP.CompensationRateId
				,JP.FullPartId
				,JP.ContractPermanentId
				,JP.ExperienceLevelId
				,JP.Description
				,JP.Responsibilities
				,JP.Requirements
				,JP.ContactInformation
				,JP.JobPostingStatusId
				,JP.DateCreated
				,JP.DateModified
				,CY.Name
				,SP.Name
			FROM dbo.JobPosting JP
			LEFT JOIN dbo.Company C ON C.Id = JP.CompanyId
			LEFT JOIN dbo.Country CY ON CY.Id = JP.CountryId
			LEFT JOIN dbo.StateProvince SP ON SP.Id = JP.StateProvinceId
			WHERE JP.CompanyId IN (SELECT Id FROM #TempTable)
End




GO
/****** Object:  StoredProcedure [dbo].[Company_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Company_SelectAll]

As
/*
	Execute dbo.Company_SelectAll
	
*/
Begin
		SELECT   p.[Id]
				,p.[DateCreated]
				,p.[DateModified]
				,p.[CompanyName]
				,p.[CompanyPhoneNumber]
				,p.[CompanyEmail]
				,p.[Address1]
				,p.[Address2]
				,p.[City]
				,p.[StateProvinceId]
				,sp.StateProvinceCode
				,ISNULL(sp.Name,'') stateName
				,p.[CountryId]
				,c.LongCode CountryLongCode
				,c.Code CountryCode
				,c.Name CountryName
				,p.[PostalCode]
				,p.[Inactive]
				,p.IsDeploy
				FROM [dbo].[Company] p
				LEFT JOIN StateProvince sp
					ON p.StateProvinceId = sp.Id
				LEFT JOIN Country c
				ON p.CountryId = c.Id

		SELECT	C.Id AS CompanyId
				,JP.Id AS JobPostingId
				,C.CompanyName
				,JP.PositionName
				,JP.StreetAddress
				,JP.City
				,JP.StateProvinceId
				,JP.CountryId
				,JP.Compensation
				,JP.CompensationRateId
				,JP.FullPartId
				,JP.ContractPermanentId
				,JP.ExperienceLevelId
				,JP.Description
				,JP.Responsibilities
				,JP.Requirements
				,JP.ContactInformation
				,JP.JobPostingStatusId
				,JP.DateCreated
				,JP.DateModified
				,CY.Name
				,SP.Name
		FROM dbo.JobPosting JP
		LEFT JOIN dbo.Company C ON C.Id = JP.CompanyId
		LEFT JOIN dbo.Country CY ON CY.Id = JP.CountryId
		LEFT JOIN dbo.StateProvince SP ON SP.Id = JP.StateProvinceId

End




GO
/****** Object:  StoredProcedure [dbo].[Company_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Company_SelectById]
			@Id INT

As
/*
	Declare @Id int = 50;
	Execute dbo.Company_SelectById @Id
	
*/
Begin 
		
		SELECT   p.[Id]
				,p.[DateCreated]
				,p.[DateModified]
				,p.[CompanyName]
				,p.[CompanyPhoneNumber]
				,p.[CompanyEmail]
				,p.[Address1]
				,p.[Address2]
				,p.[City]
				,p.[StateProvinceId]
				,sp.StateProvinceCode
				,sp.Name stateName
				,p.[CountryId]
				,c.LongCode CountryLongCode
				,c.Code CountryCode
				,c.Name CountryName
				,p.[PostalCode]
				,p.[Inactive]
				,p.IsDeploy
				FROM [dbo].[Company] p
				LEFT JOIN StateProvince sp
					ON p.StateProvinceId = sp.Id
				LEFT JOIN Country c
				ON p.CountryId = c.Id
				WHERE p.Id = @Id

		SELECT DISTINCT
				 C.Id AS CompanyId
				,JP.Id AS JobPostingId
				,C.CompanyName
				,JP.PositionName
				,JP.StreetAddress
				,JP.City
				,JP.StateProvinceId
				,JP.CountryId
				,JP.Compensation
				,JP.CompensationRateId
				,JP.FullPartId
				,JP.ContractPermanentId
				,JP.ExperienceLevelId
				,JP.Description
				,JP.Responsibilities
				,JP.Requirements
				,JP.ContactInformation
				,JP.JobPostingStatusId
				,JP.DateCreated
				,JP.DateModified
				,CY.Name
				,SP.Name
		FROM dbo.JobPosting JP
		LEFT JOIN dbo.Company C ON C.Id = JP.CompanyId
		LEFT JOIN dbo.Country CY ON CY.Id = JP.CountryId
		LEFT JOIN dbo.StateProvince SP ON SP.Id = JP.StateProvinceId
		WHERE JP.CompanyId = @Id

		SELECT JP.Id AS JobPostingId
			 ,JT.Id AS JobTagId
			 ,JT.Keyword
			 ,JT.DisplayOrder	
		  FROM [dbo].[JobPosting] JP
		  JOIN dbo.JobPostingJobTag JPJT ON JPJT.JobPostingId = JP.Id
		  JOIN dbo.JobTag JT ON JPJT.JobTagId = JT.Id
		  WHERE JP.CompanyId = @Id

		SELECT P.Id
				,P.FirstName
				,P.LastName
				,P.Email
		FROM Person P
		JOIN CompanyPerson CP ON CP.PersonId = P.Id
		WHERE CP.CompanyId = @Id
End




GO
/****** Object:  StoredProcedure [dbo].[Company_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Company_Update]
				@Id int 
				,@CompanyName NVARCHAR(100)
				,@CompanyPhoneNumber NVARCHAR(50)
				,@CompanyEmail NVARCHAR(100)
				,@Address1 NVARCHAR(50)
				,@Address2 NVARCHAR(50)
				,@City NVARCHAR(50)
				,@StateProvinceId INT
				,@CountryId INT
				,@CompanyIdCreated NVARCHAR(128)
				,@PostalCode NVARCHAR(50)
				,@Inactive BIT = null
				,@IsDeploy BIT
				,@UserIdCreated nvarchar (128)
As

/*
	

	Declare @Id int = 3;

	DECLARE	
			@CompanyName NVARCHAR(100) = 'ASUS'
			,@CompanyPhoneNumber NVARCHAR(50) = 'TestPhone'
			,@CompanyEmail NVARCHAR(100) = 'testEmail' 
			,@Address1 NVARCHAR(50) = 'Test Address'
			,@Address2 NVARCHAR(50) = 'Suite 1'
			,@City NVARCHAR(50) = 'test City'
			,@StateProvinceId INT = 4
			,@CountryId INT = 4
			,@CompanyIdCreated NVARCHAR(128)= '911'
			,@PostalCode NVARCHAR(50) = '95133'
			,@Inactive BIT = 0
			,@IsDeploy BIT
	Select * FROM dbo.Company
	WHERE Id = @Id		

	Execute dbo.Company_Update
			@Id		
			,@CompanyName 
			,@CompanyPhoneNumber 
			,@CompanyEmail 
			,@Address1 
			,@Address2 
			,@City 
			,@StateProvinceId 
			,@CountryId
			,@CompanyIdCreated
			,@PostalCode
			,@Inactive
			,@IsDeploy

		Select *
		From dbo.Company
		Where Id = @Id

*/

BEGIN
	DECLARE @datemodified DATETIME2(7) = GETUTCDATE()

	UPDATE [dbo].[Company]
		SET    
				[CompanyName] = @CompanyName
				,[CompanyPhoneNumber] = @CompanyPhoneNumber
				,[CompanyEmail] = @CompanyEmail
				,[Address1] = @Address1
				,[Address2] = @Address2
				,[City] = @City
				,[StateProvinceId] = @StateProvinceId
				,[CountryId] = @CountryId		
				,[DateModified] = @DateModified
				,[CompanyIdCreated] = @CompanyIdCreated
				,[PostalCode] = @PostalCode
				,[Inactive] = @Inactive
				,IsDeploy = @IsDeploy
				WHERE @Id = Id
End



GO
/****** Object:  StoredProcedure [dbo].[CompanyPerson_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CompanyPerson_Delete]
			@CompanyId INT
			,@PersonId INT

AS

/* TEST CODE

SELECT *
FROM CompanyPerson

DECLARE @CompanyId INT = 50
		,@PersonId INT = 173

EXECUTE dbo.CompanyPerson_Delete
			@CompanyId
			,@PersonId

SELECT *
FROM CompanyPerson

*/

BEGIN

	DELETE FROM [dbo].[CompanyPerson]
		  WHERE (CompanyId = @CompanyId
		  AND	PersonId = @PersonId)

END




GO
/****** Object:  StoredProcedure [dbo].[CompanyPerson_GetCompanies]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CompanyPerson_GetCompanies]
			@AspNetUserId NVARCHAR(128)

AS

/* TEST CODE

SELECT *
FROM CompanyPerson

SELECT *
FROM Person

DECLARE @AspNetUserId NVARCHAR(128) = 'aca9016c-b155-4e57-8e4c-f1018715de6b'

EXECUTE dbo.CompanyPerson_GetCompanies
		@AspNetUserId


*/

BEGIN

	SELECT [CompanyId]
			,C.CompanyName
			,C.CompanyPhoneNumber
			,C.CompanyEmail
	  FROM [dbo].[CompanyPerson] CP
	  JOIN Person P ON CP.PersonId = P.Id
	  JOIN Company C ON CP.CompanyId = C.Id
	  WHERE P.AspNetUserId = @AspNetUserId

END




GO
/****** Object:  StoredProcedure [dbo].[CompanyPerson_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CompanyPerson_Insert]
			@CompanyId INT
			,@PersonId INT

AS

/* TEST CODE

SELECT *
FROM Company

SELECT *
FROM Person

DECLARE @CompanyId INT
		,@PersonId INT

EXECUTE dbo.CompanyPerson_Insert
		@CompanyId
		,@PersonId

SELECT *
FROM CompanyPerson

*/

BEGIN

	INSERT INTO [dbo].[CompanyPerson]
			   ([CompanyId]
			   ,[PersonId])
		 VALUES
			   (@CompanyId
			   ,@PersonId)


END




GO
/****** Object:  StoredProcedure [dbo].[CompanyPerson_Verify]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CompanyPerson_Verify]
			@CompanyId INT
			,@AspNetUserId NVARCHAR(128)
			,@IsVerified BIT OUTPUT

AS

/* TEST CODE

SELECT *
FROM dbo.CompanyPerson

SELECT *
FROM dbo.Person

DECLARE @CompanyId INT = 60
		,@AspNetUserId NVARCHAR(128) = 'aca9016c-b155-4e57-8e4c-f1018715de6b'
		,@IsVerified BIT

EXECUTE dbo.CompanyPerson_Verify
		@CompanyId
		,@AspNetUserId
		,@IsVerified OUTPUT

SELECT @IsVerified


*/

BEGIN

	SELECT [CompanyId]
	  INTO #TempTable
	  FROM [dbo].[CompanyPerson]
	  JOIN Person P ON PersonId = P.Id
	  WHERE P.AspNetUserId = @AspNetUserId

	  SET @IsVerified =
		CASE WHEN @CompanyId IN (SELECT * FROM #TempTable)
			THEN 1
			ELSE 0
		END

END




GO
/****** Object:  StoredProcedure [dbo].[CompanyPerson_VerifyHasCompany]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[CompanyPerson_VerifyHasCompany]
			@AspNetUserId NVARCHAR(128)
			,@IsVerified BIT OUTPUT

AS

/* TEST CODE

SELECT *
FROM dbo.CompanyPerson

SELECT *
FROM dbo.Person

DECLARE @AspNetUserId NVARCHAR(128) = 'aca9016c-b155-4e57-8e4c-f1018715de6b'
		,@IsVerified BIT

EXECUTE dbo.CompanyPerson_Verify
		@AspNetUserId
		,@IsVerified OUTPUT

SELECT @IsVerified


*/

BEGIN

	SELECT [CompanyId]
	  INTO #TempTable
	  FROM [dbo].[CompanyPerson]
	  JOIN Person P ON PersonId = P.Id
	  WHERE P.AspNetUserId = @AspNetUserId

	  SET @IsVerified =
		CASE WHEN (SELECT COUNT(*) FROM #TempTable) > 0
			THEN 1
			ELSE 0
		END

END




GO
/****** Object:  StoredProcedure [dbo].[CompanyPerson_VerifyPosting]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CompanyPerson_VerifyPosting]
			@JobPostingId INT
			,@AspNetUserId NVARCHAR(128)
			,@IsVerified BIT OUTPUT

AS

/* TEST CODE

SELECT *
FROM dbo.JobPosting

SELECT *
FROM dbo.CompanyPerson

SELECT *
FROM dbo.Person

DECLARE @JobPostingId INT = 32
		,@AspNetUserId NVARCHAR(128) = '032cf875-8843-4e97-a539-4fd336951e62'
		,@IsVerified BIT

EXECUTE dbo.CompanyPerson_Verify
		@JobPostingId
		,@AspNetUserId
		,@IsVerified OUTPUT

SELECT @IsVerified


*/

BEGIN

	SELECT JP.Id
	  INTO #TempTable
	  FROM JobPosting JP
	  JOIN CompanyPerson CP ON JP.CompanyId = CP.CompanyId
	  JOIN Person P ON CP.PersonId = P.Id
	  WHERE P.AspNetUserId = @AspNetUserId

	  SELECT * FROM #TempTable

	  SET @IsVerified =
		CASE WHEN @JobPostingId IN (SELECT * FROM #TempTable)
			THEN 1
			ELSE 0
		END

END




GO
/****** Object:  StoredProcedure [dbo].[ContactRequest_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ContactRequest_Insert]

	@Name nvarchar (100)
	, @Email nvarchar (100)
	, @Message nvarchar (MAX)
	, @Id int OUTPUT

AS
BEGIN

	INSERT INTO ContactRequest

		(Name
		, Email
		, Message)

	VALUES 

	    (@Name
		, @Email
		, @Message)

	SET @Id = SCOPE_IDENTITY();
	
END



GO
/****** Object:  StoredProcedure [dbo].[ContactRequest_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ContactRequest_Search]

	@SearchStr nvarchar(250) = ''
	,@CurrentPage int = 1
	,@ItemsPerPage int = 5



AS

/* TEST CODE

	EXEC ContactRequest_Search



*/

BEGIN

	SELECT Id, Name, Email, Message, DateCreated, ContactRequestStatusId, Notes
	FROM ContactRequest

END



GO
/****** Object:  StoredProcedure [dbo].[ContactRequest_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ContactRequest_SelectAll]
AS
BEGIN
/*

	EXEC ContactRequest_SelectAll

*/

	SELECT Id
		, Name
		, Email
		, Message
		, DateCreated
		, ContactRequestStatusId
		, Notes
	
	FROM ContactRequest

	
END



GO
/****** Object:  StoredProcedure [dbo].[ContactRequest_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ContactRequest_SelectById]

	@Id int

AS

	/* Test Code
	EXEC ContactRequest_SelectById '1'

	*/

BEGIN

	SELECT Id, Name, Email, Message, DateCreated, ContactRequestStatusId, Notes
	FROM ContactRequest
	WHERE Id = @Id
	
END



GO
/****** Object:  StoredProcedure [dbo].[ContactRequest_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ContactRequest_Update]

	@Name nvarchar (100)
	, @Email nvarchar (100)
	, @Message nvarchar (MAX)
	, @ContactRequestStatusId int
	, @Notes nvarchar (250) = null
	, @Id int 

AS
/*
DECLARE @Id int = 1
		   ,@Name nvarchar (100) = 'John Rambo'
		   , @Email nvarchar (100) = 'rambo@mailinator.com'
		   , @Message nvarchar (MAX) = 'I have a profound question"
	       , @ContactRequestStatusId int = 1
	       , @Notes nvarchar (250) = 'something'
		   			
    EXEC dbo.ContactRequest_Update
					
				   ,@Name 
				   ,@Email
				   ,@Message
				   ,@ContactRequestStatusId
				   ,@Notes
				   ,@Id
				   

*/
BEGIN

	UPDATE ContactRequest
			
			SET Name = @Name, 
			Email = @Email,
			Message = @Message, 
			ContactRequestStatusId = @ContactRequestStatusId, 
			Notes = @Notes

		
		WHERE Id = @Id
	
END



GO
/****** Object:  StoredProcedure [dbo].[Country_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Country_SelectAll]

AS

/* TEST CODE

EXECUTE dbo.Country_SelectAll

*/

BEGIN

SELECT [Id]
      ,[Name]
      ,[Code]
      ,[LongCode]
      ,[DateAdded]
      ,[DateModified]
  FROM [dbo].[Country]


  END






GO
/****** Object:  StoredProcedure [dbo].[EducationLevel_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EducationLevel_Delete]

@Id int

AS

/*------TEST CODE

		DECLARE @Id int = 23

		SELECT *
		FROM dbo.EducationLevel
		WHERE id = @id;

		EXECUTE dbo.EducationLevel_Delete @id

		SELECT * 
		FROM dbo.EducationLevel
		WHERE Id =  @id;

		*/


BEGIN

		DELETE 
		FROM EducationLevel
		WHERE Id = @Id

END




GO
/****** Object:  StoredProcedure [dbo].[EducationLevel_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EducationLevel_Insert]

	@Code nvarchar(20) = ''
	, @Name nvarchar(50)
	, @Inactive bit = 0
	, @DisplayOrder int = 10
	, @UserIdCreated nvarchar(128)
	, @Id int OUTPUT

	/* -----TEST CODE----- 
			DECLARE @Id int = 0;

			DECLARE	@Code nvarchar(20) = 'Z'
			,@Name nvarchar(50) = 'Zenith'
			,@Inactive bit = 0
			,@DisplayOrder int = 1
			,@UserIdCreated nvarchar(128) = 'jfjfjfj'

			Exec dbo.EducationLevel_Insert
									@Code
									,@Name
									,@Inactive
									,@DisplayOrder
									,@UserIdCreated
									,@Id OUTPUT

			SELECT @Id

			SELECT * 
			FROM dbo.EducationLevel
			WHERE Id = @Id
	*/

AS

BEGIN
	INSERT INTO dbo.EducationLevel
		(Code
		,Name
		,Inactive
		,DisplayOrder
		,UserIdCreated)
	VALUES 
		(@Code
		, @Name
		, @Inactive
		, @DisplayOrder
		, @UserIdCreated)

	SET @Id = SCOPE_IDENTITY();

END




GO
/****** Object:  StoredProcedure [dbo].[EducationLevel_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EducationLevel_SelectAll]

AS
/*
		EXECUTE [dbo].[EducationLevel_SelectAll]

		SELECT *
		FROM dbo.EducationLevel
		

*/
BEGIN

	SELECT Id
		, Code
		, Name
		, Inactive
		, DisplayOrder
		, DateCreated
		, DateModified

	FROM EducationLevel
	ORDER BY DisplayOrder, Name


END




GO
/****** Object:  StoredProcedure [dbo].[EducationLevel_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EducationLevel_SelectById]
@Id int

AS

/*-----TEST CODE-------

DECLARE @id int = 11

EXECUTE [dbo].[EducationLevel_SelectById] @id

*/

BEGIN

	SELECT Id
	, Code
	, Name
	, Inactive
	, DisplayOrder
	, DateCreated
	, DateModified
	FROM EducationLevel
	WHERE Id = @Id


END




GO
/****** Object:  StoredProcedure [dbo].[EducationLevel_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EducationLevel_Update] 

		@Code nvarchar(20) = ''
		, @Name nvarchar(50)
		, @Inactive bit
		, @DisplayOrder int = 10
		, @UserIdCreated nvarchar(128)
		, @Id int

				
/* -----TEST CODE----- 

			DECLARE @Id int = 21;

			DECLARE	@Code nvarchar(20) = 'A'
			,@Name nvarchar(50) = 'Awesome!'
			,@Inactive bit = 1
			,@DisplayOrder int = 1
			,@UserIdCreated nvarchar(128) = 'jfjfjfj'

			Exec dbo.EducationLevel_Update

									@Code
									,@Name
									,@Inactive
									,@DisplayOrder
									,@UserIdCreated
									,@Id

			SELECT @Id

			SELECT * 
			FROM dbo.EducationLevel
			WHERE Id = @Id
	*/


AS

BEGIN 

	DECLARE @dateNow datetime2 = GETUTCDATE();

	UPDATE dbo.EducationLevel

	SET
		Code = @Code
		, Name = @Name
		, Inactive = @Inactive
		, DisplayOrder = @DisplayOrder
		, UserIdCreated = @UserIdCreated
		, DateModified = @dateNow

	WHERE Id = @Id

END




GO
/****** Object:  StoredProcedure [dbo].[Employer_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Employer_Delete]
		@Id int
AS
/*
	Declare @Id int = 4
	
	Select * From dbo.Employer
	WHERE Id = @Id

	EXEC dbo.Employer_Delete @Id

	Select * From dbo.Employer
	WHERE Id = @Id

	*/
BEGIN
		DELETE FROM dbo.Employer
		WHERE Id = @Id
END



GO
/****** Object:  StoredProcedure [dbo].[Employer_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Employer_Insert]
		@EmployerIdCreated NVARCHAR(128)
			,@EmployerName NVARCHAR(100)
			,@EmployerPhoneNumber NVARCHAR(50)
			,@EmployerEmail NVARCHAR(100)
			,@Address1 NVARCHAR(50)
			,@Address2 NVARCHAR(50)
			,@City NVARCHAR(50)
			,@StateProvinceId INT
			,@CountryId INT
			,@Id INT OUTPUT


/*-----------Test Code--------


	Declare @EmployerIdCreated NVARCHAR(128) = '4'
			,@EmployerName NVARCHAR(100) = 'BB'
			,@EmployerPhoneNumber NVARCHAR(50) = 'TestPhone'
			,@EmployerEmail NVARCHAR(100) = 'testEmail' 
			,@Address1 NVARCHAR(50) = 'Test Address'
			,@Address2 NVARCHAR(50) = 'Suite 1'
			,@City NVARCHAR(50) = 'test City'
			,@StateProvinceId INT = 4
			,@CountryId INT = 4
			,@Id INT 
	
	Execute dbo.Employer_Insert
							@EmployerIdCreated
							,@EmployerName 
							,@EmployerPhoneNumber 
							,@EmployerEmail 
							,@Address1 
							,@Address2 
							,@City 
							,@StateProvinceId 
							,@CountryId 
							,@Id OUTPUT

	
	SELECT * FROM dbo.Employer
	WHERE Id = @Id
	
	Select * FROM dbo.Employer
	
	Truncate table dbo.Company

*/

AS

BEGIN


INSERT INTO [dbo].Employer
           ([EmployerIdCreated]
           ,[EmployerName]
           ,[EmployerPhoneNumber]
           ,[EmployerEmail]
           ,[Address1]
           ,[Address2]
           ,[City]
           ,[StateProvinceId]
           ,[CountryId])
		VALUES
			(@EmployerIdCreated
			,@EmployerName
			,@EmployerPhoneNumber 
			,@EmployerEmail 
			,@Address1 
			,@Address2 
			,@City 
			,@StateProvinceId 
			,@CountryId) 

SET @Id = SCOPE_IDENTITY()

END



GO
/****** Object:  StoredProcedure [dbo].[Employer_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Employer_SelectAll]

AS
/*

			Execute dbo.Company_SelectAll

*/
BEGIN
		SELECT  [Id]
				,[DateCreated]
				,[DateModified]
				,[EmployerIdCreated]
				,[EmployerName]
				,[EmployerPhoneNumber]
				,[EmployerEmail]
				,[Address1]
				,[Address2]
				,[City]
				,[StateProvinceId]
				,[CountryId]
				FROM [dbo].[Employer]
END



GO
/****** Object:  StoredProcedure [dbo].[Employer_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Employer_SelectById]
		@Id INT
AS
/*
	Declare @Id int = 2;
	Execute dbo.Employer_SelectById @Id
	
*/

BEGIN
		SELECT  [Id]
				,[DateCreated]
				,[DateModified]
				,[EmployerIdCreated]
				,[EmployerName]
				,[EmployerPhoneNumber]
				,[EmployerEmail]
				,[Address1]
				,[Address2]
				,[City]
				,[StateProvinceId]
				,[CountryId]
				FROM [dbo].[Employer]
				WHERE Id = @Id

END



GO
/****** Object:  StoredProcedure [dbo].[Employer_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Employer_Update]
				@Id int 
				,@EmployerIdCreated NVARCHAR(128)
				,@EmployerName NVARCHAR(100)
				,@EmployerPhoneNumber NVARCHAR(50)
				,@EmployerEmail NVARCHAR(100)
				,@Address1 NVARCHAR(50)
				,@Address2 NVARCHAR(50)
				,@City NVARCHAR(50)
				,@StateProvinceId INT
				,@CountryId INT
AS
/*

	Declare @Id int = 3
			,@EmployerIdCreated NVARCHAR(128) = '4'
			,@EmployerName NVARCHAR(100) = 'BEEF NOODLE'
			,@EmployerPhoneNumber NVARCHAR(50) = 'TestPhone'
			,@EmployerEmail NVARCHAR(100) = 'testEmail' 
			,@Address1 NVARCHAR(50) = 'Test Address'
			,@Address2 NVARCHAR(50) = 'Suite 1'
			,@City NVARCHAR(50) = 'test City'
			,@StateProvinceId INT = 4
			,@CountryId INT = 4
	
	Select * FROM dbo.Employer
	WHERE Id = @Id		

	Execute dbo.Employer_Update
			@Id
			,@CompanyIdCreated
			,@CompanyName 
			,@CompanyPhoneNumber 
			,@CompanyEmail 
			,@Address1 
			,@Address2 
			,@City 
			,@StateProvinceId 
			,@CountryId

		Select *
		From dbo.Employer
		Where Id = @Id

*/
BEGIN
		UPDATE [dbo].[Employer]
		SET    [DateModified] = GETUTCDATE()
			    ,[EmployerIdCreated] = @EmployerIdCreated
				,[EmployerName] = @EmployerName
				,[EmployerPhoneNumber] = @EmployerPhoneNumber
				,[EmployerEmail] = @EmployerEmail
				,[Address1] = @Address1
				,[Address2] = @Address2
				,[City] = @City
				,[StateProvinceId] = @StateProvinceId
				,[CountryId] = @CountryId
				WHERE @Id = Id
END



GO
/****** Object:  StoredProcedure [dbo].[ExceptionLog_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[ExceptionLog_Insert]
			@Message NVARCHAR(1000)
			,@Type NVARCHAR(100)
			,@StackTrace NVARCHAR(MAX)
			,@ApiUrl NVARCHAR(300)
			,@ViewUrl NVARCHAR(300)
			,@RequestBody NVARCHAR(1000)
			,@AspNetUserId NVARCHAR(128)

AS

/* TEST CODE 

DECLARE		@Message NVARCHAR(1000) = 'Ya blew it'
			,@Type NVARCHAR(100) = 'Typical Tomfoolery'
			,@StackTrace NVARCHAR(MAX) = 'Ya dang self'
			,@ApiUrl NVARCHAR(300)
			,@ViewUrl NVARCHAR(300)
			,@RequestBody NVARCHAR(1000)
			,@AspNetUserId NVARCHAR(128)

EXECUTE dbo.ExceptionLog_Insert
			@Message
			,@Type
			,@StackTrace
			,@ApiUrl
			,@ViewUrl
			,@RequestBody
			,@AspNetUserId

SELECT *
FROM dbo.ExceptionLog


*/

BEGIN

	INSERT INTO [dbo].[ExceptionLog]
			   ([Message]
			   ,[Type]
			   ,[StackTrace]
			   ,ApiUrl
			   ,ViewUrl
			   ,[RequestBody]
			   ,[AspNetUserId])
		 VALUES
			   (@Message
			   ,@Type
			   ,@StackTrace
			   ,@ApiUrl
			   ,@ViewUrl
			   ,@RequestBody
			   ,@AspNetUserId)
END




GO
/****** Object:  StoredProcedure [dbo].[ExceptionLog_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[ExceptionLog_Search]
			@Type NVARCHAR(100)
			,@Message NVARCHAR(1000)
			,@StackTrace NVARCHAR(MAX)
			,@Url NVARCHAR(300)
			,@Person NVARCHAR(200)
			,@StartDate DATETIME2(7)
			,@EndDate DATETIME2(7)
			,@CurrentPage INT
			,@ItemsPerPage INT

AS

/* TEST CODE

DECLARE		@Type NVARCHAR(100) = 'sql'
			,@Message NVARCHAR(1000) = ''
			,@StackTrace NVARCHAR(MAX) = ''
			,@Url NVARCHAR(300) = ''
			,@Person NVARCHAR(200) = ''
			,@StartDate DATETIME2(7)
			,@EndDate DATETIME2(7)
			,@CurrentPage INT = 1
			,@ItemsPerPage INT = 10

EXECUTE dbo.ExceptionLog_Search
			@Type
			,@Message
			,@StackTrace
			,@Url
			,@Person
			,@StartDate
			,@EndDate
			,@CurrentPage
			,@ItemsPerPage

*/

BEGIN

	SELECT EL.[Id]
		  ,[Message]
		  ,[Type]
		  ,[StackTrace]
		  ,ApiUrl
		  ,ViewUrl
		  ,[RequestBody]
		  ,EL.[AspNetUserId]
		  ,P.Id
		  ,P.FirstName
		  ,P.MiddleName
		  ,P.LastName
		  ,P.PhoneNumber
		  ,P.Email
		  ,P.JobTitle
		  ,[LogDate]
		  ,COUNT(*) OVER () TotalRows
	  FROM [dbo].[ExceptionLog] EL
		LEFT JOIN Person P ON EL.AspNetUserId = P.AspNetUserId
	  WHERE ((@Message = '') OR (Message LIKE '%' + @Message + '%'))
		AND ((@Type = '') OR (Type LIKE '%' + @Type + '%'))
		AND ((@StackTrace = '') OR (StackTrace LIKE '%' + @StackTrace + '%'))
		AND ((@Url = '') OR (ApiUrl LIKE '%' + @Url + '%')
						 OR (ViewUrl LIKE '%' + @Url + '%'))
		AND ((@Person = '') OR (P.FirstName LIKE '%' + @Person + '%')
							OR (P.LastName LIKE '%' + @Person + '%')
							OR (P.Email LIKE '%' + @Person + '%')
							OR (P.LastName + ' ' + P.LastName LIKE '%' + @Person + '%')
							OR (P.FirstName + ' ' + P.MiddleName + ' ' + P.LastName LIKE '%' + @Person + '%')
							OR (P.AspNetUserId LIKE '%' + @Person + '%'))
		AND LogDate BETWEEN @StartDate AND @EndDate
	  ORDER BY LogDate DESC
	  OFFSET @ItemsPerPage * (@CurrentPage - 1) ROWS
	  FETCH NEXT @ItemsPerPage ROWS ONLY
END




GO
/****** Object:  StoredProcedure [dbo].[ExceptionLog_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[ExceptionLog_SelectAll]

AS

/* TEST CODE

EXECUTE dbo.ExceptionLog_SelectAll

*/

BEGIN

	SELECT TOP 20
		   EL.[Id]
		  ,[Message]
		  ,[Type]
		  ,[StackTrace]
		  ,ApiUrl
		  ,ViewUrl
		  ,[RequestBody]
		  ,EL.[AspNetUserId]
		  ,P.Id
		  ,P.FirstName
		  ,P.MiddleName
		  ,P.LastName
		  ,P.PhoneNumber
		  ,P.Email
		  ,P.JobTitle
		  ,[LogDate]
		  ,COUNT(*) OVER () TotalRows
	  FROM [dbo].[ExceptionLog] EL
		LEFT JOIN Person P ON EL.AspNetUserId = P.AspNetUserId
	  ORDER BY LogDate DESC

END




GO
/****** Object:  StoredProcedure [dbo].[Faq_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Faq_Delete]
@Id int
			

AS

/* Test Code

DECLARE @Id INT = 3

SELECT *
FROM dbo.Faq
WHERE Id = @Id

EXECUTE dbo.Faq_Delete
		@Id

SELECT *
FROM dbo.Faq
WHERE Id = @Id

*/

BEGIN

DELETE
  FROM [dbo].[Faq]
  WHERE Id=@Id



END






GO
/****** Object:  StoredProcedure [dbo].[Faq_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Faq_Insert]

@UserIdCreated nvarchar(128)
,@Question nvarchar(500)
,@Answer nvarchar(3000)
,@FaqCategoryId int
 ,@Id INT OUTPUT
AS
BEGIN

/*
		DECLARE	
		@Id INT	

		EXEC Faq_Insert 

		1
		,'When was Operation Code founded?'
		,'August 21, 2014'
		,1
		,@Id OUTPUT

		SELECT * FROM Faq
		WHERE Id = @Id

		*/

  INSERT INTO [TestDb].[dbo].[Faq]
    ([UserIdCreated]
      ,[Question]
      ,[Answer]
      ,[FaqCategoryId]
	 )
  
  VALUES
	(@UserIdCreated 
	,@Question 
	,@Answer
	,@FaqCategoryId )

	 SET @Id = SCOPE_IDENTITY()

		
END





GO
/****** Object:  StoredProcedure [dbo].[Faq_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Faq_SelectAll]
			

AS

/* Test Code



EXECUTE dbo.Faq_SelectAll
		

*/

BEGIN
	SELECT f.Id
      ,[DateCreated]
      ,[DateModified]
      ,[UserIdCreated]
      ,[Question]
      ,[Answer]
      ,[FaqCategoryId]
	  ,fc.Name AS CategoryName

	FROM [dbo].[Faq] f
	 JOIN FaqCategory fc
			ON f.FaqCategoryId = fc.Id
	



END






GO
/****** Object:  StoredProcedure [dbo].[Faq_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Faq_SelectById]
			@Id INT

AS

/* Test Code

DECLARE @Id INT = 1

EXECUTE dbo.Faq_SelectById
		@Id
SELECT @Return Value


*/

BEGIN

SELECT f.Id
      ,[DateCreated]
      ,[DateModified]
      ,[UserIdCreated]
      ,[Question]
      ,[Answer]
      ,[FaqCategoryId]
	  ,fc.Name AS CategoryName
	FROM [dbo].[Faq] f
	 JOIN FaqCategory fc
			ON f.FaqCategoryId = fc.Id
  WHERE f.Id = @Id
END






GO
/****** Object:  StoredProcedure [dbo].[Faq_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Faq_Update]

@Id int
,@UserIdCreated nvarchar(128)
,@Question nvarchar(500)
,@Answer nvarchar(3000)
,@FaqCategoryId int
AS
BEGIN
	/*DECLARE @DateModified datetime2(7) = GETUTCDATE();
		@return_value int

	EXEC	@return_value = [dbo].[Faq_Update]
			@Id = 4,
			@UserIdCreated = N'Brendan',
			@Question = N'Test',
			@Answer = N'TEst',
			@FaqCategoryId = 1

	SELECT	'Return Value' = @return_value

	 EXEC Faq_Update 
	SELECT * FROM Faq
	  */
UPDATE [TestDb].[dbo].[Faq]
 
  SET 
      
      UserIdCreated =@UserIdCreated
      ,Question=@Question
      ,Answer=@Answer
      ,FaqCategoryId=@FaqCategoryId
	  ,DateModified=GETUTCDATE()
	  
	  WHERE Id = @Id
	 

END





GO
/****** Object:  StoredProcedure [dbo].[FaqCategory_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[FaqCategory_Delete]
@Id int
			

AS

/* Test Code

DECLARE @Id INT = 3

SELECT *
FROM FaqCategory
WHERE Id = @Id

EXECUTE dbo.FaqCategory_Delete
		@Id 

SELECT *
FROM dbo.FaqCategory
WHERE Id = @Id

*/

BEGIN

DELETE
  FROM [dbo].FaqCategory
  WHERE Id=@Id



END





GO
/****** Object:  StoredProcedure [dbo].[FaqCategory_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FaqCategory_Insert]
	@Id int OUTPUT
	,@Name nvarchar(50)
	, @DisplayOrder int
	
AS
BEGIN
INSERT INTO [dbo].[FaqCategory]
           ([Id]
           ,[Name]
           ,[DisplayOrder])
     VALUES
           (@Id
           ,@Name
           ,@DisplayOrder)
		   SET @Id = SCOPE_IDENTITY()
		   
		   /*
	DECLARE 
	@Name nvarchar(50) = Name
	, @DisplayOrder int = 5
	, @Id int 

	EXEC FaqCategory_Insert
	@Name
	, @DisplayOrder
	, @Id OUTPUT

	SELECT *
	FROM FaqCategory
	WHERE Id = @Id
	*/
END





GO
/****** Object:  StoredProcedure [dbo].[FaqCategory_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FaqCategory_SelectAll]
	
AS

/* Test Code



EXECUTE dbo. FaqCategory_SelectAll
		



*/
BEGIN

SELECT Id
      ,[Name]
      ,DisplayOrder
    
  FROM [dbo].FaqCategory


END




GO
/****** Object:  StoredProcedure [dbo].[FaqCategory_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[FaqCategory_SelectById]
			@Id INT

AS

		/* Test Code

		DECLARE @Id INT = 1

		EXECUTE dbo.FaqCategory_SelectById
				@Id

		*/

BEGIN
SELECT	 Id
		,[Name]
		,DisplayOrder
    
FROM [dbo].FaqCategory
WHERE Id = @Id

END






GO
/****** Object:  StoredProcedure [dbo].[FaqCategory_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FaqCategory_Update]
	@Id int
	, @Name nvarchar(50)
	, @DisplayOrder int
AS
BEGIN
UPDATE [dbo].[FaqCategory]
   SET [Id] = @Id
      ,[Name] = @Name
      ,[DisplayOrder] = @DisplayOrder

  WHERE Id = @Id

 /*
 Declare @Id int = 1
	, @Name nvarchar(128) = 'Company'
	, @DisplayOrder int = 5
	 

EXEC FaqCategory_Update
		@Id
		, @Name
		, @DisplayOrder

		

select *
From FaqCategory
Where Id = @Id
 */
END





GO
/****** Object:  StoredProcedure [dbo].[GlobalEvent_CalendarSelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GlobalEvent_CalendarSelectAll]

AS

/* --- TEST CODE ---

	EXEC dbo.GlobalEvent_CalendarSelectAll

	SELECT *
	FROM dbo.GlobalEvent

*/

BEGIN

	SELECT G.Id
		  , G.Name
		  , G.Address
		  , G.City
		  , G.State
		  , G.ZipCode
		  , G.Country
		  , G.DateStart
		  , G.DateEnd
		  , G.StartTime
		  , G.EndTime
		  , G.Description
		  , G.Latitude
		  , G.Longitude
		  , G.DateCreated
		  , P.FirstName AS PersonFirstName
		  , P.LastName AS PersonLastName
		  , G.IsCanceled
	  FROM [dbo].[GlobalEvent] AS G
		JOIN dbo.Person AS P
		ON G.UserIdCreated = P.AspNetUserId
	  WHERE g.DateStart BETWEEN DATEADD(m, -6, GETDATE()) 
		AND DATEADD(m, 6, GETDATE())
	  ORDER BY DateStart DESC

END

GO
/****** Object:  StoredProcedure [dbo].[GlobalEvent_Cancel]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GlobalEvent_Cancel]
	@id int

AS
/* --- TEST CODE ---

	DECLARE @id int = 1

	EXEC dbo.GlobalEvent_Cancel
		@id

	SELECT *
	FROM dbo.GlobalEvent

*/

BEGIN
	UPDATE dbo.GlobalEvent
	SET IsCanceled = 1
	WHERE Id = @id
END

GO
/****** Object:  StoredProcedure [dbo].[GlobalEvent_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GlobalEvent_Delete]
	@id int

AS

/* --- TEST CODE ---

	DECLARE @id int = 2

	SELECT *
	FROM dbo.GlobalEvent
	WHERE Id = @id

	EXECUTE dbo.GlobalEvent_Delete
		@id

	SELECT *
	FROM dbo.GlobalEvent
	WHERE Id = @id

*/

BEGIN
	DELETE FROM [dbo].[GlobalEvent]
		  WHERE Id = @id
END




GO
/****** Object:  StoredProcedure [dbo].[GlobalEvent_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GlobalEvent_Insert]
	@name nvarchar(50)
	, @address nvarchar(200)
	, @city nvarchar(50)
	, @state nvarchar(50)
	, @zipCode int
	, @country nvarchar(50)
	, @dateStart date
	, @dateEnd date
	, @startTime time(7)
	, @endTime time(7)
	, @description nvarchar(1000)
	, @latitude decimal(18,12)
	, @longitude decimal(18,12)
	, @userId nvarchar(128)
	, @id int OUTPUT

AS

/* --- TEST CODE ---
	
	DECLARE 
		@name nvarchar(50) = 'test event'
		, @address nvarchar(200) = '123 b street'
		, @city nvarchar(50) = 'gainesville'
		, @state nvarchar(50) = 'fl'
		, @zipCode int = 32615
		, @country nvarchar(50) = 'united states'
		, @dateStart date = '2015-05-15'
		, @dateEnd date = '2015-05-15'
		, @startTime time(7) = '01:01:01'
		, @endTime time(7) = '01:05:01'
		, @description nvarchar(1000) = 'test'
		, @latitude decimal(18,12) = 23.18
		, @longitude decimal(18,12) = 118.00
		, @userId nvarchar(128) = '1'
		, @id int = 0

	EXECUTE dbo.GlobalEvent_Insert
		@name
		, @address
		, @city
		, @state
		, @zipCode
		, @country
		, @dateStart
		, @dateEnd
		, @startTime
		, @endTime
		, @description
		, @latitude
		, @longitude
		, @userId
		, @id OUTPUT

	SELECT *
	FROM dbo.GlobalEvent
	WHERE Id = @id
*/

BEGIN
	INSERT INTO [dbo].[GlobalEvent]
			   ([Name]
			   , [Address]
			   , [City]
			   , [State]
			   , [ZipCode]
			   , [Country]
			   , [DateStart]
			   , [DateEnd]
			   , [StartTime]
			   , [EndTime]
			   , [Description]
			   , [Latitude]
			   , [Longitude]
			   , [UserIdCreated])
		 VALUES
			   (@name
			   , @address
			   , @city
			   , @state
			   , @zipCode
			   , @country
			   , @dateStart
			   , @dateEnd
			   , @startTime
			   , @endTime
			   , @description
			   , @latitude
			   , @longitude
			   , @userId)

	UPDATE dbo.GlobalEvent
	SET Geo = GEOGRAPHY::Point(Latitude, Longitude , 4326);

	SET @id = SCOPE_IDENTITY()
END




GO
/****** Object:  StoredProcedure [dbo].[GlobalEvent_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GlobalEvent_Search]
	@searchStr nvarchar(100) = ''
	, @dateFrom datetime2 = ''
	, @dateTo datetime2 = ''

AS

/* --- TEST CODE ---

	DECLARE @searchStr nvarchar(100) = 'ak'
		, @dateFrom datetime2 = ''
		, @dateTo datetime2 = ''

	EXECUTE dbo.GlobalEvent_Search
		@searchStr
		, @dateFrom
		, @dateTo

*/

BEGIN
	SELECT [Id]
	, [Name]
	, [Address]
	, [City]
	, [State]
	, [ZipCode]
	, [Country]
	, [DateStart]
	, [DateEnd]
	, [StartTime]
	, [EndTime]
	, [Description]
	, [Latitude]
	, [Longitude]
	, [Geo]
	, [DateCreated]
	FROM [dbo].[GlobalEvent]
	WHERE ([Name] LIKE '%' + @searchStr + '%'
	OR City LIKE '%' + @searchStr + '%'
	OR State LIKE '%' + @searchStr + '%'
	OR DateStart LIKE '%' + @searchStr + '%'
	OR [Description] LIKE '%' + @searchStr + '%')
	OR DateStart BETWEEN @dateFrom AND @dateTo
	ORDER BY [Name]
END

GO
/****** Object:  StoredProcedure [dbo].[GlobalEvent_SearchRadius]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GlobalEvent_SearchRadius]
	@userLat decimal(18,12)
	, @userLng decimal(18,12)
	, @radius int

AS

/* --- TEST CODE ---

	DECLARE @userLat decimal(18,12) = 29.77
		, @userLng decimal(18,12) = -82.00
		, @radius int = 5000

	EXECUTE dbo.GlobalEvent_SearchRadius
		@userLat
		, @userLng
		, @radius
*/

BEGIN
	DECLARE @userGeo geography;
	SET @userGeo = GEOGRAPHY::Point(@userLat, @userLng , 4326);

	SELECT [Id]
		, [Name]
		, [Address]
		, [City]
		, [State]
		, [ZipCode]
		, [Country]
		, [DateStart]
		, [DateEnd]
		, [StartTime]
		, [EndTime]
		, [Description]
		, [Latitude]
		, [Longitude]
		, [Geo]
		, [DateCreated]
		, @userGeo.STDistance(Geo)/1609.344 AS [Distance in Miles]
		, @userGeo.STDistance(Geo)/1000 AS [Distance in KM]
	FROM [dbo].[GlobalEvent] 
	WHERE @userGeo.STDistance(Geo)/1609.344 < @radius
	OR @userGeo.STDistance(Geo)/1000 < @radius
	ORDER BY @userGeo.STDistance(Geo)
END

GO
/****** Object:  StoredProcedure [dbo].[GlobalEvent_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GlobalEvent_SelectAll]

AS

/* --- TEST CODE ---

	EXEC dbo.GlobalEvent_SelectAll

	SELECT *
	FROM dbo.GlobalEvent

*/

BEGIN

	SELECT G.Id
		  , G.Name
		  , G.Address
		  , G.City
		  , G.State
		  , G.ZipCode
		  , G.Country
		  , G.DateStart
		  , G.DateEnd
		  , G.StartTime
		  , G.EndTime
		  , G.Description
		  , G.Latitude
		  , G.Longitude
		  , G.DateCreated
		  , P.FirstName AS PersonFirstName
		  , P.LastName AS PersonLastName
		  , G.IsCanceled
	  FROM [dbo].[GlobalEvent] AS G
		JOIN dbo.Person AS P
		ON G.UserIdCreated = P.AspNetUserId
	  ORDER BY DateStart DESC

END

GO
/****** Object:  StoredProcedure [dbo].[GlobalEvent_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GlobalEvent_SelectById]
	@id int

AS

/* --- TEST CODE ---

	DECLARE @id int = 1

	EXECUTE dbo.GlobalEvent_SelectById
		@id

*/

BEGIN

	SELECT G.Id
		  , G.Name
		  , G.Address
		  , G.City
		  , G.State
		  , G.ZipCode
		  , G.Country
		  , G.DateStart
		  , G.DateEnd
		  , G.StartTime
		  , G.EndTime
		  , G.Description
		  , G.Latitude
		  , G.Longitude
		  , G.DateCreated
		  , P.FirstName AS PersonFirstName
		  , P.LastName AS PersonLastName
		  , G.IsCanceled
	  FROM [dbo].[GlobalEvent] AS G
		JOIN dbo.Person AS P
		ON G.UserIdCreated = P.AspNetUserId
	  WHERE G.Id = @id

END




GO
/****** Object:  StoredProcedure [dbo].[GlobalEvent_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GlobalEvent_Update]
	@name nvarchar(50)
	, @address nvarchar(200)
	, @city nvarchar(50)
	, @state nvarchar(50)
	, @zipCode int
	, @country nvarchar(50)
	, @dateStart date
	, @dateEnd date
	, @startTime time(7)
	, @endTime time(7)
	, @description nvarchar(1000)
	, @latitude decimal(18,12)
	, @longitude decimal(18,12)
	, @userId nvarchar(128)
	, @id int

AS

/*

	DECLARE 
		@name nvarchar(50) = 'TPA'
		, @address nvarchar(200) = '4100 George J Bean Pkwy'
		, @city nvarchar(50) = 'Tampa'
		, @state nvarchar(50) = 'FL'
		, @zipCode int = 33607
		, @country nvarchar(50) = 'United States'
		, @dateStart date = '2017-04-12'
		, @dateEnd date = '2017-04-12'
		, @startTime time(7) = '12:01:01'
		, @endTime time(7) = '12:05:01'
		, @description nvarchar(1000) = 'update'
		, @latitude decimal(18,12) = 27.9834776
		, @longitude decimal(18,12) = -82.5370781
		, @userId nvarchar(128) = '1'
		, @id int = 27

	SELECT *
	FROM dbo.GlobalEvent
	WHERE Id = @id

	EXECUTE dbo.GlobalEvent_Update
		@name
		, @address
		, @city
		, @state
		, @zipCode
		, @country
		, @dateStart
		, @dateEnd
		, @startTime
		, @endTime
		, @description
		, @latitude
		, @longitude
		, @userId
		, @id

	SELECT *
	FROM dbo.GlobalEvent
	WHERE Id = @id

*/

BEGIN
	DECLARE @dateNow datetime2 = GETUTCDATE()

	UPDATE [dbo].[GlobalEvent]
	   SET [Name] = @name
		  , [Address] = @address
		  , [City] = @city
		  , [State] = @state
		  , [ZipCode] = @zipCode
		  , [Country] = @country
		  , [DateStart] = @dateStart
		  , [DateEnd] = @dateEnd
		  , [StartTime] = @startTime
		  , [EndTime] = @endTime
		  , [Description] = @description
		  , [Latitude] = @latitude
		  , [Longitude] = @longitude
		  , Geo = GEOGRAPHY::Point(@latitude, @longitude , 4326)
		  , [DateModified] = @dateNow
		  , [UserIdCreated] = @userId
	 WHERE Id = @id
 END





GO
/****** Object:  StoredProcedure [dbo].[HomeStatistics_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[HomeStatistics_Insert]
			@Title NVARCHAR(50)
			,@Number NVARCHAR(50)
			,@AutoPopulate BIT

AS

/* TEST CODE

DECLARE		@Title NVARCHAR(50)
			,@Number NVARCHAR(50)
			,@AutoPopulate BIT

EXECUTE		dbo.HomeStatistics_Insert
			@Title
			,@Number
			,@AutoPopulate

SELECT *
FROM HomeStatistics

*/

BEGIN

	INSERT INTO [dbo].[HomeStatistics]
			   ([Title]
			   ,[Number]
			   ,[AutoPopulate])
		 VALUES
			   (@Title
			   ,@Number
			   ,@AutoPopulate)

END



GO
/****** Object:  StoredProcedure [dbo].[HomeStatistics_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[HomeStatistics_SelectAll]

AS

/* TEST CODE

EXECUTE		dbo.HomeStatistics_SelectAll

*/

BEGIN

	SELECT [Id]
		  ,[Title]
		  ,CASE WHEN AutoPopulate = 0 THEN Number
				WHEN AutoPopulate = 1 THEN
					CASE WHEN Id = 1 THEN CONVERT(NVARCHAR(50), (SELECT COUNT(*) FROM Person))
						 WHEN Id = 2 THEN CONVERT(NVARCHAR(50), (SELECT COUNT(*) FROM JobPosting))
						 WHEN Id = 3 THEN CONVERT(NVARCHAR(50), (SELECT COUNT(*) FROM Squad))
						 WHEN Id = 4 THEN CONVERT(NVARCHAR(50), ((SELECT COUNT(*) FROM GlobalEvent) + (SELECT COUNT(*) FROM SquadEvent)))
					END 
				END AS Number
		  ,AutoPopulate
	  FROM [dbo].[HomeStatistics]
END



GO
/****** Object:  StoredProcedure [dbo].[HomeStatistics_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[HomeStatistics_Update]
			@Title1 NVARCHAR(50)
			,@Number1 NVARCHAR(50)
			,@AutoPopulate1 BIT
			,@Title2 NVARCHAR(50)
			,@Number2 NVARCHAR(50)
			,@AutoPopulate2 BIT
			,@Title3 NVARCHAR(50)
			,@Number3 NVARCHAR(50)
			,@AutoPopulate3 BIT
			,@Title4 NVARCHAR(50)
			,@Number4 NVARCHAR(50)
			,@AutoPopulate4 BIT

AS

/* TEST CODE

DECLARE		@Title1 NVARCHAR(50) = 'Members'
			,@Number1 NVARCHAR(50) = 4000
			,@AutoPopulate1 BIT = 1
			,@Title2 NVARCHAR(50) = 'Job Postings'
			,@Number2 NVARCHAR(50) = 245
			,@AutoPopulate2 BIT = 1
			,@Title3 NVARCHAR(50) = 'Squads'
			,@Number3 NVARCHAR(50) = 43
			,@AutoPopulate3 BIT = 1
			,@Title4 NVARCHAR(50) = 'Events'
			,@Number4 NVARCHAR(50) = 75
			,@AutoPopulate4 BIT = 0

EXECUTE		dbo.HomeStatistics_Update
			@Title1
			,@Number1
			,@AutoPopulate1
			,@Title2
			,@Number2
			,@AutoPopulate2
			,@Title3
			,@Number3
			,@AutoPopulate3
			,@Title4
			,@Number4
			,@AutoPopulate4

SELECT *
FROM HomeStatistics

*/

BEGIN

	TRUNCATE TABLE HomeStatistics

	EXECUTE dbo.HomeStatistics_Insert
			@Title1
			,@Number1
			,@AutoPopulate1

	EXECUTE dbo.HomeStatistics_Insert
			@Title2
			,@Number2
			,@AutoPopulate2

	EXECUTE dbo.HomeStatistics_Insert
			@Title3
			,@Number3
			,@AutoPopulate3

	EXECUTE dbo.HomeStatistics_Insert
			@Title4
			,@Number4
			,@AutoPopulate4

END



GO
/****** Object:  StoredProcedure [dbo].[Invoice_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Invoice_Insert] 
	@ProjectsId int 
	,@InvoiceDate datetime = null
	,@Description1 nvarchar(max) = null
	,@Description2 nvarchar(max) = null
	,@LineTotal1 money = null
	,@LineTotal2 money =null
	,@TimeCardTotals money = null
	,@StatusId int = null

	,@Id int output

AS

BEGIN 

	INSERT INTO Invoice
		(ProjectsId
		,InvoiceDate
		,Description1 
		,Description2 
		,LineTotal1 
		,LineTotal2
		,TimeCardTotals
		,StatusId)
	VALUES   
		(@ProjectsId
		,@InvoiceDate
		,@Description1
		,@Description2
		,@LineTotal1
		,@LineTotal2
		,@TimeCardTotals
		,@StatusId)

	SET @Id = SCOPE_IDENTITY();

END
















GO
/****** Object:  StoredProcedure [dbo].[Invoice_update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Invoice_update]
	@Id int
	,@ProjectsId int
	,@InvoiceDate datetime2(7) null
	,@Description1 nvarchar(max) = null
	,@Description2 nvarchar(max) = null
	,@LineTotal1 money = null
	,@LineTotal2 money = null
	,@StatusId int = 2
	,@TimeCardTotals money =null
	
AS

BEGIN

/*TEST CASE

DECLARE	@return_value int

EXEC	@return_value = [dbo].[Invoice_update]
		@Id = 1003,
		@ProjectsId = 4,
		@InvoiceDate = '5/17/2017',
		@TimeCardTotals = 544.99,
		@Description1 = N'''hi''',
		@Description2 = N'''bye''',
		@LineTotal1 = 345.99,
		@LineTotal2 = 342.22,
		@StatusId = 2,
		@TotalInvoice = 3433

SELECT	'Return Value' = @return_value


		
*/
	UPDATE Invoice
		SET
		ProjectsId = @ProjectsId
		,InvoiceDate = @InvoiceDate
		,StatusId = @StatusId
		,Description1 = @Description1 
		,Description2 = @Description2 
		,LineTotal1 = @LineTotal1
		,LineTotal2 = @LineTotal2
		,TimeCardTotals = @TimeCardTotals
		

		WHERE Id = @Id

	DELETE FROM dbo.InvoiceItem
	 WHERE Id = @Id

		INSERT INTO dbo.InvoiceItem 
				(Id
				, [Description1]
				, LineTotal1
				,[Description2]
				, LineTotal2)
				
		SELECT Id
			,[Description1]
			,LineTotal1
			,[Description2]
			,LineTotal2
	
	FROM dbo.InvoiceItem





END

GO
/****** Object:  StoredProcedure [dbo].[JobApplication_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[JobApplication_Delete]
				@Id INT

AS

/* TEST CODE

DECLARE @Id INT = 3

SELECT *
FROM JobApplication
WHERE Id = @Id

EXECUTE dbo.JobApplication_Delete
		@Id

SELECT *
FROM JobApplication
WHERE Id = @Id

*/

BEGIN

	  DELETE FROM [dbo].[JobApplication]
	  WHERE Id = @Id


END




GO
/****** Object:  StoredProcedure [dbo].[JobApplication_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[JobApplication_Insert]
				@PersonId INT
				,@JobPostingId INT
				,@CoverLetter NVARCHAR(4000)
				,@Id INT OUTPUT

AS

/* TEST CODE

DECLARE			@PersonId INT
				,@JobPostingId INT
				,@CoverLetter NVARCHAR(4000)
				,@Id INT

EXECUTE dbo.JobApplication_Insert
				@PersonId
			   ,@JobPostingId
			   ,@CoverLetter
			   ,@Id OUTPUT

SELECT *
FROM dbo.JobApplication
WHERE Id = @Id

*/

BEGIN

	INSERT INTO [dbo].[JobApplication]
			   ([PersonId]
			   ,[JobPostingId]
			   ,[CoverLetter])
		 VALUES
			   (@PersonId
			   ,@JobPostingId
			   ,@CoverLetter)

		SET @Id = SCOPE_IDENTITY()
END




GO
/****** Object:  StoredProcedure [dbo].[JobApplication_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[JobApplication_SelectAll]
				

AS

/* TEST CODE

EXECUTE dbo.JobApplication_SelectAll
		

*/

BEGIN

	SELECT JA.[Id]
		  ,[PersonId]
		  ,[JobPostingId]
		  ,[CoverLetter]
		  ,JAS.Name AS ApplicationStatus
		  ,Notes
		  ,[DateCreated]
		  ,[DateModified]
	  FROM [dbo].[JobApplication] JA
	  JOIN JobApplicationStatus JAS ON JA.StatusId = JAS.Id


END




GO
/****** Object:  StoredProcedure [dbo].[JobApplication_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[JobApplication_SelectById]
				@Id INT

AS

/* TEST CODE

DECLARE @Id INT = 1

EXECUTE dbo.JobApplication_SelectById
		@Id

*/

BEGIN

	SELECT JA.[Id]
		  ,[PersonId]
		  ,[JobPostingId]
		  ,[CoverLetter]
		  ,JAS.Name AS ApplicationStatus
		  ,[DateCreated]
		  ,[DateModified]
	  FROM [dbo].[JobApplication] JA
	  JOIN JobApplicationStatus JAS ON JA.StatusId = JAS.Id
	  WHERE JA.Id = @Id


END




GO
/****** Object:  StoredProcedure [dbo].[JobApplication_SelectByJobPostingId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[JobApplication_SelectByJobPostingId]
				@JobPostingId INT

AS

/* TEST CODE

DECLARE @JobPostingId INT = 32

EXECUTE dbo.JobApplication_SelectByJobPostingId
		@JobPostingId

*/

BEGIN

	SELECT JA.[Id]
		  ,[PersonId]
		  ,[JobPostingId]
		  ,[CoverLetter]
		  ,JAS.Name AS ApplicationStatus
		  ,Notes
		  ,[DateCreated]
		  ,[DateModified]
	  FROM [dbo].[JobApplication] JA
	  JOIN JobApplicationStatus JAS ON JA.StatusId = JAS.Id
	  WHERE JA.JobPostingId = @JobPostingId

	  SELECT Jp.Id
			,CompanyId
			,Co.CompanyName
			,PositionName
			,StreetAddress
			,JP.City
			,JP.StateProvinceId
			,JP.CountryId
			,Compensation
			,CompensationRateId
			,FullPartId
			,ContractPermanentId
			,ExperienceLevelId
			,Description
			,Responsibilities
			,Requirements
			,ContactInformation
			,JobPostingStatusId
			,JP.DateCreated
			,JP.DateModified
			,C.Name AS CountryName
			,SP.Name AS StateProvinceName
			,Location.Lat AS Latitude
			,Location.Long AS Longitude
	  FROM [dbo].[JobPosting] JP
	  LEFT JOIN dbo.Country C ON C.Id = JP.CountryId
	  LEFT JOIN dbo.StateProvince SP ON SP.Id = JP.StateProvinceId
	  LEFT JOIN dbo.Company CO ON CO.Id = JP.CompanyId
	  WHERE JP.Id = @JobPostingId

END




GO
/****** Object:  StoredProcedure [dbo].[JobApplication_SelectByPersonId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[JobApplication_SelectByPersonId]
				@PersonId INT

AS

/* TEST CODE

DECLARE @PersonId INT = 211

EXECUTE dbo.JobApplication_SelectByPersonId
		@PersonId

*/

BEGIN

	SELECT JA.[Id]
		  ,[PersonId]
		  ,[JobPostingId]
		  ,[CoverLetter]
		  ,JAS.Name AS ApplicationStatus
		  ,JA.[DateCreated]
		  ,JA.[DateModified]
	  INTO #TempTable
	  FROM [dbo].[JobApplication] JA
	  JOIN JobApplicationStatus JAS ON JA.StatusId = JAS.Id
	  JOIN JobPosting JP ON JA.JobPostingId = JP.Id
	  JOIN Company C ON JP.CompanyId = C.Id
	  WHERE JA.PersonId = @PersonId

	  SELECT * FROM #TempTable

	  SELECT Jp.Id
			,CompanyId
			,Co.CompanyName
			,PositionName
			,StreetAddress
			,JP.City
			,JP.StateProvinceId
			,JP.CountryId
			,Compensation
			,CompensationRateId
			,FullPartId
			,ContractPermanentId
			,ExperienceLevelId
			,Description
			,Responsibilities
			,Requirements
			,ContactInformation
			,JobPostingStatusId
			,JP.DateCreated
			,JP.DateModified
			,C.Name AS CountryName
			,SP.Name AS StateProvinceName
			,Location.Lat AS Latitude
			,Location.Long AS Longitude
	  FROM [dbo].[JobPosting] JP
	  LEFT JOIN dbo.Country C ON C.Id = JP.CountryId
	  LEFT JOIN dbo.StateProvince SP ON SP.Id = JP.StateProvinceId
	  LEFT JOIN dbo.Company CO ON CO.Id = JP.CompanyId
	  WHERE JP.Id IN (SELECT JobPostingId FROM #TempTable)
END




GO
/****** Object:  StoredProcedure [dbo].[JobApplication_SelectByStatusId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[JobApplication_SelectById]    Script Date: 5/10/2017 10:06:46 AM ******/


CREATE PROC [dbo].[JobApplication_SelectByStatusId]
				@JobPostingId INT
				,@StatusId INT

AS

/* TEST CODE

DECLARE		@JobPostingId INT = 32
			,@StatusId INT = 2

EXECUTE dbo.JobApplication_SelectByStatusId
		@JobPostingId
		,@StatusId

*/

BEGIN

	SELECT JA.Id
			,PersonId
			,P.FirstName
			,P.LastName
			,P.JobTitle
			,P.Resume
			,CoverLetter
			,JAS.Name AS ApplicationStatus
			,Notes
			,JA.DateCreated
	  FROM dbo.JobApplication JA
	  JOIN Person P ON PersonId = P.ID
	  JOIN JobApplicationStatus JAS ON JA.StatusId = JAS.Id
	  WHERE ((@StatusId = 0) OR (JA.StatusId = @StatusId))
		AND JA.JobPostingId = @JobPostingId


END




GO
/****** Object:  StoredProcedure [dbo].[JobApplication_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[JobApplication_Update]
				@Id INT
				,@StatusId INT
				,@Notes NVARCHAR(4000)

AS

/* TEST CODE

DECLARE			@Id INT = 7
				,@StatusId INT = 1
				,@Notes NVARCHAR(4000) = 'Its true, he does'

EXECUTE dbo.JobApplication_Update
				@Id
			   ,@StatusId
			   ,@Notes

SELECT *
FROM dbo.JobApplication
WHERE Id = @Id

*/

BEGIN



	UPDATE [dbo].[JobApplication]
	   SET StatusId = @StatusId
		  ,Notes = ISNULL(@Notes, Notes)
		  ,[DateModified] = GETUTCDATE()
	 WHERE Id = @Id




END




GO
/****** Object:  StoredProcedure [dbo].[JobApplicationStatus_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[JobApplicationStatus_Insert]
			@Name NVARCHAR(50)

AS

/* TEST CODE

DECLARE		@Name NVARCHAR(50) = 'Pending'

EXECUTE		dbo.JobApplicationStatus_Insert
				@Name

SELECT *
FROM dbo.JobApplicationStatus

*/


BEGIN

	INSERT INTO [dbo].[JobApplicationStatus]
			   ([Name])
		 VALUES
			   (@Name)

END




GO
/****** Object:  StoredProcedure [dbo].[JobApplicationStatus_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[JobApplicationStatus_SelectAll]

AS

/* TEST CODE

EXECUTE dbo.JobApplicationStatus_SelectAll

*/

BEGIN

	SELECT [Id]
		  ,[Name]
	  FROM [dbo].[JobApplicationStatus]

END




GO
/****** Object:  StoredProcedure [dbo].[JobPosting_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobPosting_Delete]
			@Id INT

AS

/* Test Code

DECLARE @Id INT = 19

SELECT *
FROM dbo.JobPosting
WHERE Id = @Id

EXECUTE dbo.JobPosting_Delete
		@Id

SELECT *
FROM dbo.JobPosting
WHERE Id = @Id

*/

BEGIN

	DELETE FROM dbo.JobPostingJobTag
	WHERE JobPostingId = @Id

	DELETE FROM dbo.JobApplication
	WHERE JobPostingId = @Id

	DELETE FROM dbo.JobPosting
	  WHERE Id = @Id

END






GO
/****** Object:  StoredProcedure [dbo].[JobPosting_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobPosting_Insert]
			@CompanyId INT
			,@PositionName NVARCHAR(100)
			,@StreetAddress NVARCHAR(100) = null
			,@City NVARCHAR(50) = null
			,@StateProvinceId INT = null
			,@CountryId INT = null
			,@Compensation INT = null
			,@CompensationRateId INT = null
			,@FullPartId INT = null
			,@ContractPermanentId INT = null
			,@ExperienceLevelId INT = null
			,@Description NVARCHAR(4000) = null
			,@Responsibilities NVARCHAR(4000) = null
			,@Requirements NVARCHAR(4000) = null
			,@ContactInformation NVARCHAR(4000) = null
			,@Latitude DECIMAL(10,7) = null
			,@Longitude DECIMAL(10,7) = null
			,@JobPostingStatusId INT = null
			,@UserIdCreated NVARCHAR(128) = null
			,@JobPostingJobTagIds dbo.IntIdTable READONLY
			,@Id INT OUTPUT

AS

/* Test code

DECLARE		@CompanyId INT = 51
			,@PositionName NVARCHAR(100) = 'Test Position'
			,@StreetAddress NVARCHAR(100) = '123 Fake Street'
			,@City NVARCHAR(50) = 'New York City'			
			,@StateProvinceId INT = 54
			,@CountryId INT = 247
			,@Compensation INT = 80
			,@CompensationRateId INT = 1
			,@FullPartId INT = 2
			,@ContractPermanentId INT = 1
			,@ExperienceLevelId INT = 2
			,@Description NVARCHAR(4000) = 'Test Description'
			,@Responsibilities NVARCHAR(4000) = 'Test Responsibilities'
			,@Requirements NVARCHAR(4000) = 'Test Requirements'
			,@ContactInformation NVARCHAR(4000) = 'Test Contact'
			,@Latitude DECIMAL(10,7)
			,@Longitude DECIMAL(10,7)
			,@JobPostingStatusId INT = 1
			,@UserIdCreated NVARCHAR(128) = '123'
			,@JobPostingJobTagIds dbo.IntIdTable
			,@Id INT
			INSERT @JobPostingJobTagIds (data)
			VALUES (4), (5)

EXECUTE dbo.JobPosting_Insert
			@CompanyId
		   ,@PositionName
		   ,@StreetAddress
		   ,@City
		   ,@StateProvinceId
		   ,@CountryId
		   ,@Compensation
		   ,@CompensationRateId
		   ,@FullPartId
		   ,@ContractPermanentId
		   ,@ExperienceLevelId
		   ,@Description
		   ,@Requirements
		   ,@Requirements
		   ,@ContactInformation
		   ,@Latitude
		   ,@Longitude
		   ,@JobPostingStatusId
		   ,@UserIdCreated
		   ,@JobPostingJobTagIds
		   ,@Id OUTPUT

SELECT *
FROM dbo.JobPosting
WHERE Id = @Id

*/

BEGIN
	
	DECLARE @Location GEOGRAPHY
	SET @Location = geography::Point(@Latitude, @Longitude, 4326);

	INSERT INTO [dbo].[JobPosting]
			   ([CompanyId]
			   ,[PositionName]
			   ,StreetAddress
			   ,[City]
			   ,StateProvinceId
			   ,CountryId
			   ,Compensation
			   ,CompensationRateId
			   ,FullPartId
			   ,ContractPermanentId
			   ,ExperienceLevelId
			   ,[Description]
			   ,[Responsibilities]
			   ,[Requirements]
			   ,[ContactInformation]
			   ,Location
			   ,[JobPostingStatusId]
			   ,[UserIdCreated])
		 VALUES
			   (@CompanyId
			   ,@PositionName
			   ,@StreetAddress
			   ,@City
			   ,@StateProvinceId
			   ,@CountryId
			   ,@Compensation
			   ,@CompensationRateId
		       ,@FullPartId
		       ,@ContractPermanentId
		       ,@ExperienceLevelId
			   ,@Description
			   ,@Responsibilities
			   ,@Requirements
			   ,@ContactInformation
		       ,@Location
			   ,@JobPostingStatusId
			   ,@UserIdCreated)

			   SET @Id = SCOPE_IDENTITY()

			   INSERT INTO dbo.JobPostingJobTag (JobPostingId, JobTagId)
			   SELECT @Id, data
			   FROM @JobPostingJobTagIds

END



GO
/****** Object:  StoredProcedure [dbo].[JobPosting_SearchByKeyword]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobPosting_SearchByKeyword]
			@SearchString NVARCHAR(1000)
			,@CurrentPage INT = 1
			,@ItemsPerPage INT = 5
			,@Latitude DECIMAL(10,7) = null
			,@Longitude DECIMAL(10,7) = null
			,@Distance INT = 0
			,@Compensation INT = 0
			,@FullPartId INT = 0
			,@ContractPermanentId INT = 0
			,@ExperienceLevelId INT = 0
			,@IsDeploy BIT = 0
			,@JobTagIds dbo.IntIdTable READONLY
			

AS

/* TEST CODE

DECLARE @SearchString NVARCHAR(1000) = 'developer'
		,@CurrentPage INT = 1
		,@ItemsPerPage INT = 5
		,@Latitude DECIMAL(10,7)
		,@Longitude DECIMAL(10,7)
		,@Distance INT = 0
		,@Compensation INT = 0
		,@FullPartId INT = 0
		,@ContractPermanentId INT = 0
		,@ExperienceLevelId INT = 0
		,@IsDeploy BIT = 0
		,@JobTagIds dbo.IntIdTable
		
			 
		


EXECUTE dbo.JobPosting_SearchByKeyword
		@SearchString
		,@CurrentPage
		,@ItemsPerPage
		,@Latitude
		,@Longitude
		,@Distance
		,@Compensation
		,@FullPartId
		,@ContractPermanentId 
		,@ExperienceLevelId
		,@IsDeploy
		,@JobTagIds

*/

BEGIN
	
	SET @SearchString =
		CASE WHEN @SearchString = ''
			THEN '""'
			ELSE @SearchString
		END

	DECLARE @Location GEOGRAPHY
	IF @Latitude IS NOT NULL AND @Longitude IS NOT NULL
		SET @Location = geography::Point(@Latitude, @Longitude, 4326)

	SELECT DISTINCT 
		   JP.Id
		  ,CompanyId
		  ,CO.CompanyName
		  ,[PositionName]
		  ,StreetAddress
		  ,JP.[City]
		  ,JP.[StateProvinceId]
		  ,JP.[CountryId]
		  ,Compensation
		  ,CompensationRateId
		  ,FullPartId
		  ,ContractPermanentId
		  ,ExperienceLevelId
		  ,[Description]
		  ,[Responsibilities]
		  ,[Requirements]
		  ,[ContactInformation]
		  ,[JobPostingStatusId]
		  ,JP.[DateCreated]
		  ,JP.[DateModified]
		  ,C.Name AS CountryName
		  ,SP.Name AS StateProvinceName
		  ,Location.Lat AS Latitude
		  ,Location.Long AS Longitude
		  ,COUNT(*) OVER () TotalRows
	  INTO #TempTable
	  FROM [dbo].[JobPosting] JP
		  LEFT JOIN dbo.Country C ON C.Id = JP.CountryId
		  LEFT JOIN dbo.StateProvince SP ON SP.Id = JP.StateProvinceId
		  LEFT JOIN dbo.Company CO ON CO.Id = JP.CompanyId
	  WHERE ((@SearchString = '""') OR FREETEXT ((PositionName, JP.City, Description, Responsibilities, Requirements), @SearchString))
		  AND (CO.IsDeploy = @IsDeploy)
		  AND ((@Distance = 0) OR (@Location IS NULL) OR (@Location.STDistance(Location) <= @Distance))
		  AND ((@Compensation = 0) OR (Compensation >= @Compensation))
		  AND ((@FullPartId = 0) OR (FullPartId = @FullPartId))
		  AND ((@ContractPermanentId = 0) OR (ContractPermanentId = @ContractPermanentId))
		  AND ((@ExperienceLevelId = 0) OR (ExperienceLevelId = @ExperienceLevelId))
		  AND (JP.JobPostingStatusId = 1)
		  AND (((SELECT COUNT(data) FROM @JobTagIds) = 0) 
					OR (JP.ID IN (SELECT JPJT.JobPostingId 
									FROM @JobTagIds JTI
									LEFT JOIN JobPostingJobTag JPJT ON JPJT.JobTagId = JTI.Data
									GROUP BY JPJT.JobPostingId
									HAVING COUNT(DISTINCT JPJT.JobTagId) = (SELECT COUNT(data) FROM @JobTagIds))))
	  ORDER BY JP.DateCreated DESC
	  OFFSET @ItemsPerPage * (@CurrentPage - 1) ROWS
	  FETCH NEXT @ItemsPerPage ROWS ONLY

	  SELECT *
	  FROM #TempTable

	  SELECT JP.Id AS JobPostingId
			 ,JT.Id AS JobTagId
			 ,JT.Keyword
			 ,JT.DisplayOrder			
	  FROM [dbo].[JobPosting] JP
	  JOIN dbo.JobPostingJobTag JPJT ON JPJT.JobPostingId = JP.Id
	  JOIN dbo.JobTag JT ON JPJT.JobTagId = JT.Id
	  WHERE JP.Id IN (SELECT Id FROM #TempTable)
END

GO
/****** Object:  StoredProcedure [dbo].[JobPosting_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobPosting_SelectAll]

AS

/* Test Code

EXECUTE dbo.JobPosting_SelectAll

*/

BEGIN

	SELECT JP.[Id]
		  ,CompanyId
		  ,CO.CompanyName
		  ,[PositionName]
		  ,StreetAddress
		  ,JP.[City]
		  ,JP.[StateProvinceId]		  
		  ,JP.[CountryId]		  
		  ,Compensation
		  ,CompensationRateId
		  ,FullPartId
		  ,ContractPermanentId
		  ,ExperienceLevelId
		  ,[Description]
		  ,[Responsibilities]
		  ,[Requirements]
		  ,[ContactInformation]
		  ,[JobPostingStatusId]
		  ,JP.[DateCreated]
		  ,JP.[DateModified]
		  ,C.Name AS CountryName
		  ,SP.Name AS StateProvinceName
		  ,Location.Lat AS Latitude
		  ,Location.Long AS Longitude
		  ,COUNT(*) OVER () TotalRows
	  FROM [dbo].[JobPosting] JP
	  LEFT JOIN dbo.Country C ON C.Id = JP.CountryId
	  LEFT JOIN dbo.StateProvince SP ON SP.Id = JP.StateProvinceId
	  LEFT JOIN dbo.Company CO ON CO.Id = JP.CompanyId

	  SELECT JP.Id AS JobPostingId
			 ,JT.Id AS JobTagId
			 ,JT.Keyword
			 ,JT.DisplayOrder
			
	  FROM [dbo].[JobPosting] JP
	  JOIN dbo.JobPostingJobTag JPJT ON JPJT.JobPostingId = JP.Id
	  JOIN dbo.JobTag JT ON JPJT.JobTagId = JT.Id

END






GO
/****** Object:  StoredProcedure [dbo].[JobPosting_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobPosting_SelectById]
			@Id INT

AS

/* Test Code

DECLARE @Id INT = 32

EXECUTE dbo.JobPosting_SelectById
		@Id


*/

BEGIN

	SELECT JP.Id
		  ,CompanyId
		  ,CO.CompanyName
		  ,[PositionName]
		  ,StreetAddress
		  ,JP.[City]
		  ,JP.[StateProvinceId]
		  ,JP.[CountryId]
		  ,Compensation
		  ,CompensationRateId
		  ,FullPartId
		  ,ContractPermanentId
		  ,ExperienceLevelId
		  ,[Description]
		  ,[Responsibilities]
		  ,[Requirements]
		  ,[ContactInformation]
		  ,[JobPostingStatusId]
		  ,JP.[DateCreated]
		  ,JP.[DateModified]
		  ,C.Name AS CountryName
		  ,SP.Name AS StateProvinceName
		  ,Location.Lat AS Latitude
		  ,Location.Long AS Longitude
		  ,COUNT(*) OVER () TotalRows
	  FROM [dbo].[JobPosting] JP
	  LEFT JOIN dbo.Country C ON C.Id = JP.CountryId
	  LEFT JOIN dbo.StateProvince SP ON SP.Id = JP.StateProvinceId
	  LEFT JOIN dbo.Company CO ON CO.Id = JP.CompanyId
	  WHERE JP.Id = @Id

	  
	  SELECT JP.Id AS JobPostingId
			 ,JT.Id AS JobTagId
			 ,JT.Keyword
			 ,JT.DisplayOrder
			
	  FROM [dbo].[JobPosting] JP
	  JOIN dbo.JobPostingJobTag JPJT ON JPJT.JobPostingId = JP.Id
	  JOIN dbo.JobTag JT ON JPJT.JobTagId = JT.Id
	  WHERE JP.Id = @Id

	  SELECT JA.Id
			,PersonId
			,P.FirstName
			,P.LastName
			,P.JobTitle
			,P.Resume
			,CoverLetter
			,JAS.Name AS ApplicationStatus
			,Notes
			,JA.DateCreated
	  FROM dbo.JobApplication JA
	  JOIN Person P ON PersonId = P.ID
	  JOIN JobApplicationStatus JAS ON JA.StatusId = JAS.Id
	  WHERE JA.JobPostingId = @Id
	  

END






GO
/****** Object:  StoredProcedure [dbo].[JobPosting_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobPosting_Update]
			@Id INT
			,@CompanyId INT
			,@PositionName NVARCHAR(100)
			,@StreetAddress NVARCHAR(100)
			,@City NVARCHAR(50)
			,@StateProvinceId INT
			,@CountryId INT
			,@Compensation INT
			,@CompensationRateId INT
			,@FullPartId INT
			,@ContractPermanentId INT
			,@ExperienceLevelId INT
			,@Description NVARCHAR(4000)
			,@Responsibilities NVARCHAR(4000)
			,@Requirements NVARCHAR(4000)
			,@ContactInformation NVARCHAR(4000)
			,@Latitude DECIMAL(10,7)
			,@Longitude DECIMAL(10,7)
			,@JobPostingStatusId INT
			,@JobPostingJobTagIds dbo.IntIdTable READONLY
			

AS

/* Test code


DECLARE		@Id INT = 13
			,@CompanyId INT = 51
			,@PositionName NVARCHAR(100) = 'Test Pos'
			,@StreetAddress NVARCHAR(100) = '11755 Wilshire Blvd.'
			,@City NVARCHAR(50) = 'Los Angeles'
			,@StateProvinceId INT = 9
			,@CountryId INT = 247
			,@Compensation INT = 80000
			,@CompensationRateId INT
			,@FullPartId INT
			,@ContractPermanentId INT
			,@ExperienceLevelId INT
			,@Description NVARCHAR(4000)
			,@Responsibilities NVARCHAR(4000) = 'Test Resp'
			,@Requirements NVARCHAR(4000) = 'Test Req'
			,@ContactInformation NVARCHAR(4000) = 'Test Con'
			,@JobPostingStatusId INT = 1
			,@JobPostingJobTagIds dbo.IntIdTable
			INSERT @JobPostingJobTagIds (data)
			VALUES (5), (6)
			
SELECT *
FROM dbo.JobPostingJobTag
WHERE JobPostingId = @Id

EXECUTE dbo.JobPosting_Update
			@Id
		   ,@CompanyId
		   ,@PositionName
		   ,@StreetAddress
		   ,@City
		   ,@StateProvinceId
		   ,@CountryId
		   ,@Compensation
		   ,@CompensationRateId
		   ,@FullPartId
		   ,@ContractPermanentId
		   ,@ExperienceLevelId
		   ,@Description
		   ,@Requirements
		   ,@Requirements
		   ,@ContactInformation
		   ,@JobPostingStatusId
		   ,@JobPostingJobTagIds

SELECT *
FROM dbo.JobPostingJobTag
WHERE JobPostingId = @Id

SELECT *
FROM dbo.JobPosting
WHERE Id = @Id

*/

BEGIN

	UPDATE [dbo].[JobPosting]
	   SET CompanyId = @CompanyId
		  ,[PositionName] = @PositionName
		  ,StreetAddress = @StreetAddress
		  ,[City] = @City
		  ,[StateProvinceId] = @StateProvinceId
		  ,[CountryId] = @CountryId
		  ,Compensation = @Compensation
		  ,CompensationRateId = @CompensationRateId
		  ,FullPartId = @FullPartId
		  ,ContractPermanentId = @ContractPermanentId
		  ,ExperienceLevelId = @ExperienceLevelId
		  ,[Description] = @Description
		  ,[Responsibilities] = @Responsibilities
		  ,[Requirements] = @Requirements
		  ,[ContactInformation] = @ContactInformation
		  ,[JobPostingStatusId] = @JobPostingStatusId
		  ,[DateModified] = GETUTCDATE()
	 WHERE Id = @Id

	 DELETE FROM dbo.JobPostingJobTag
	 WHERE JobPostingId = @Id

	 INSERT INTO dbo.JobPostingJobTag (JobPostingId, JobTagId)
	 SELECT @Id, data
	 FROM @JobPostingJobTagIds



END



GO
/****** Object:  StoredProcedure [dbo].[JobPostingClickLog_AddClick]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[JobPostingClickLog_AddClick]
			@JobSearchEngineId INT

AS

/* TEST CODE

SELECT *
FROM JobPostingClickLog

DECLARE		@JobSearchEngineId INT = 1

EXECUTE		dbo.JobPostingClickLog_AddClick
			@JobSearchEngineId

SELECT *
FROM JobPostingClickLog

*/

BEGIN

	UPDATE [dbo].[JobPostingClickLog]
	   SET [Clicks] = Clicks + 1
	 WHERE Id = @JobSearchEngineId

END




GO
/****** Object:  StoredProcedure [dbo].[JobPostingClickLog_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[JobPostingClickLog_Insert]
			@Name NVARCHAR(50)

AS

/* TEST CODE

DECLARE		@Name NVARCHAR(50) = 'UsaJobs.gov'

EXECUTE		dbo.JobPostingClickLog_Insert
			@Name

SELECT *
FROM JobPostingClickLog

*/

BEGIN

	INSERT INTO [dbo].[JobPostingClickLog]
			   ([Name])
		 VALUES
			   (@Name)

END




GO
/****** Object:  StoredProcedure [dbo].[JobPostingJobTag_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobPostingJobTag_Delete]
			@JobPostingId INT
			,@JobTagId INT

AS

/* TEST CODE

DECLARE @JobPostingId INT = 13
		,@JobTagId INT = 5

SELECT *
FROM dbo.JobPostingJobTag
WHERE JobPostingId = @JobPostingId AND JobTagId = @JobTagId

EXECUTE dbo.JobPostingJobTag_Delete
		@JobPostingId
		,@JobTagId

SELECT *
FROM dbo.JobPostingJobTag
WHERE JobPostingId = @JobPostingId AND JobTagId = @JobTagId

*/

BEGIN

DELETE FROM [dbo].[JobPostingJobTag]
      WHERE JobPostingId = @JobPostingId AND JobTagId = @JobTagId



END






GO
/****** Object:  StoredProcedure [dbo].[JobPostingJobTag_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobPostingJobTag_Insert]
			@JobPostingId INT
			,@JobTagId INT

AS

/* TEST CODE

DECLARE @JobPostingId INT = 13
		,@JobTagId INT = 6

EXECUTE dbo.JobPostingJobTag_Insert
		@JobPostingId
		,@JobTagId

SELECT *
FROM dbo.JobPostingJobTag

*/

BEGIN

	INSERT INTO [dbo].[JobPostingJobTag]
			   ([JobPostingId]
			   ,[JobTagId])
		 VALUES
			   (@JobPostingId
			   ,@JobTagId)





END



GO
/****** Object:  StoredProcedure [dbo].[JobPostingJobTag_SelectByJobPostingId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobPostingJobTag_SelectByJobPostingId]
			@JobPostingId INT

AS

/* TEST CODE

DECLARE @JobPostingId INT = 13

EXECUTE dbo.JobPostingJobTag_SelectByJobPostingId
			@JobPostingId

*/

BEGIN

	SELECT [JobTagId]
		  ,dbo.JobTag.Keyword
	  FROM [dbo].[JobPostingJobTag]
	  JOIN dbo.JobTag ON dbo.JobPostingJobTag.JobTagId = dbo.JobTag.Id
	  WHERE JobPostingId = @JobPostingId



END






GO
/****** Object:  StoredProcedure [dbo].[JobTag_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobTag_Delete]
			@Id INT

AS

/* TEST CODE

DECLARE @Id INT = 7

SELECT *
FROM dbo.JobTag
WHERE Id = @Id

EXECUTE dbo.JobTag_Delete
		@Id

SELECT *
FROM dbo.JobTag
WHERE Id = @Id

*/

BEGIN

	DELETE FROM dbo.JobPostingJobTag
		  WHERE JobTagId = @Id

	DELETE FROM [dbo].[JobTag]
		  WHERE Id = @Id


  END






GO
/****** Object:  StoredProcedure [dbo].[JobTag_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[JobTag_Insert]
			@Keyword NVARCHAR(100)
			,@DisplayOrder INT = 10
			,@Id INT OUTPUT

AS

/* TEST CODE

DECLARE		@Keyword NVARCHAR(100) = '.NET'
			,@DisplayOrder INT = 10
			,@Id INT

EXECUTE dbo.JobTag_Insert
			@Keyword
		   ,@DisplayOrder
		   ,@Id OUTPUT

SELECT *
FROM dbo.JobTag
WHERE Id = @Id

*/

BEGIN

	INSERT INTO [dbo].[JobTag]
			   ([Keyword]
			   ,[DisplayOrder])
		 VALUES
			   (@Keyword
			   ,@DisplayOrder)

			   SET @Id = SCOPE_IDENTITY()
END






GO
/****** Object:  StoredProcedure [dbo].[JobTag_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobTag_SelectAll]

AS

/* TEST CODE

EXECUTE dbo.JobTag_SelectAll

*/

BEGIN

	SELECT [Id]
		  ,[Keyword]
		  ,[DisplayOrder]
	  FROM [dbo].[JobTag]


  END






GO
/****** Object:  StoredProcedure [dbo].[JobTag_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobTag_SelectById]
			@Id INT

AS

/* TEST CODE

DECLARE @Id INT = 3

EXECUTE dbo.JobTag_SelectById
		@Id

*/

BEGIN

	SELECT [Id]
		  ,[Keyword]
		  ,[DisplayOrder]
	  FROM [dbo].[JobTag]
	  WHERE Id = @Id


END






GO
/****** Object:  StoredProcedure [dbo].[JobTag_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[JobTag_Update]
			@Keyword NVARCHAR(100)
			,@DisplayOrder INT = 10
			,@Id INT

AS

/* TEST CODE

DECLARE		@Keyword NVARCHAR(100) = 'Front-end'
			,@DisplayOrder INT 
			,@Id INT = 4

EXECUTE dbo.JobTag_Update 
			@Keyword = 'Backend
		   ,@DisplayOrder = 10
		   ,@Id = 4

SELECT *
FROM dbo.JobTag
WHERE Id = @Id 5

*/

BEGIN



	UPDATE [dbo].[JobTag]
	   SET [Keyword] = @Keyword
		  ,[DisplayOrder] = @DisplayOrder
	WHERE Id = @Id



END






GO
/****** Object:  StoredProcedure [dbo].[Language_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Language_Delete]
			@Id INT 

AS

/* 		--- T E S T  C O D E ---

Declare @Id int = 2;

		Select	*
		From	dbo.Language
		Where	Id = @Id

	Execute dbo.Language_Delete 
							
		Select	FROM 
		From	dbo.Language
		Where	Id = @Id

*/

BEGIN


DELETE from dbo.Language
WHERE Id = @Id

END






GO
/****** Object:  StoredProcedure [dbo].[Language_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Language_Insert]
			@Name nvarchar(50),
			@Code nvarchar(20) = '',
			@UserIdCreated nvarchar(50),
			@DisplayOrder int,
			@Inactive bit,
			@Id INT OUTPUT


/* 		--- T E S T  C O D E ---

Declare @Id int = 0;

	Declare @Name nvarchar(50) = 'NileSpeak'
			,@Code nvarchar(20) = 'NS'
			,@UserIdCreated nvarchar(50) = '123'
			,@DisplayOrder int = 0
			,@Inactive bit = 0
			,@Id int = 500
		
	Execute dbo.Language_Insert 
							@Name
							,@Code
							,@UserIdCreated
							,@DisplayOrder
							,@Inactive
							,@Id OUTPUT
		

		Select	*
		From	dbo.Language
		Where	Id = @Id
Select @Id
*/

AS

BEGIN

INSERT INTO [dbo].[Language]
           ([Name]
           ,[Code]
		   ,[UserIdCreated]
		   ,[DisplayOrder]
		   ,[Inactive])
     VALUES
			(@Name,
			@Code,
			@UserIdCreated,
			@DisplayOrder,
			@Inactive)

SET @Id = SCOPE_IDENTITY()

END






GO
/****** Object:  StoredProcedure [dbo].[Language_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Language_SelectAll]

AS

/* 		--- T E S T  C O D E ---
	
	Execute dbo.Language_SelectAll 			
	
*/

BEGIN

	SELECT	[Id]
		,[Name]
		,[Code]
		,[DisplayOrder]
		,[Inactive]
	FROM dbo.Language

END






GO
/****** Object:  StoredProcedure [dbo].[Language_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Language_SelectById]
			@Id int

AS

/* 		--- T E S T  C O D E ---
	
	Declare @Id int = 7;

	Execute dbo.Language_SelectById	@Id	
	
*/

BEGIN

  	SELECT	[Id]
		,[Name]
		,[Code]
		,[DisplayOrder]
		,[Inactive]
	FROM dbo.Language
	Where Id = @Id

END






GO
/****** Object:  StoredProcedure [dbo].[Language_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[Language_Update]
			@Id int
			,@Name nvarchar(250)
			,@Code nvarchar(50) = ''
			,@DisplayOrder int
			,@InActive bit
			,@UserIdCreated nvarchar(128)
			 
AS

/* 		--- T E S T  C O D E ---

Declare @Id int = 2;

	Declare 
			@DisplayOrder int = 10
			,@Name nvarchar(50) = 'French Canadian'
			,@Code nvarchar(20) = 'FR-CA'
			,@InActive bit = '0'
			,@UserIdCreated nvarchar(128) = ''

		Select	*
		From	dbo.Language
		Where	Id = @Id

	Execute dbo.Language_Update 
							@Id 
							,@Name
							,@Code
							,@DisplayOrder
							,@InActive
							,@UserIdCreated
							

		Select	*
		From	dbo.Language
		Where	Id = @Id

*/

BEGIN
	
	UPDATE	[dbo].[Language]
	SET	[Name] = @Name
		,[Code] = @Code
		,[DisplayOrder] = @DisplayOrder
		,[Inactive] = @InActive
		,[UserIdCreated] = @UserIdCreated	
		,[DateModified] = GETUTCDATE()	
	WHERE Id = @Id


END






GO
/****** Object:  StoredProcedure [dbo].[LanguageProficiency_GetAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[LanguageProficiency_GetAll]

	AS

/*





   EXEC LanguageProficiency_GetAll
   CONCAT(l.id,'-',lp.id) as '1',

   */
BEGIN


	SELECT 
		CONVERT(varchar,l.id) + '-' + CONVERT(varchar,lp.id) AS 'Key', 
		lp.code, 
		lp.description, 
		l.DisplayOrder, l.Name
	FROM Language L CROSS JOIN LanguageProficiency LP
		ORDER BY L.DisplayOrder, L.Name, LP.Code
	
END

GO
/****** Object:  StoredProcedure [dbo].[MilitaryBase_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MilitaryBase_Delete]
@Id int
AS
BEGIN
DELETE FROM [dbo].MilitaryBase
      WHERE Id = @Id
	  /*
	  EXEC MilitaryBase_Delete 1
	  SELECT *
	  FROM MilitaryBase
	  */
END




GO
/****** Object:  StoredProcedure [dbo].[MilitaryBase_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MilitaryBase_Insert]
	@MilitaryBase nvarchar(150)
	, @ServiceBranch int = 53
	, @Id int OUTPUT
AS
BEGIN
/*
DECLARE @MilitaryBase nvarchar(150) = 'USS Alabama'
	, @ServiceBranch int = 53
	, @Id int
EXEC MilitaryBase_Insert
	@MilitaryBase
	, @ServiceBranch
	, @Id OUTPUT
	
	SELECT * FROM dbo.MilitaryBase
	WHERE Id = @Id
	*/
INSERT INTO [dbo].[MilitaryBase]
           (MilitaryBase
		   , ServiceBranchId)
     VALUES
           (@MilitaryBase
		   , @ServiceBranch)
	SET @Id = SCOPE_IDENTITY()
END




GO
/****** Object:  StoredProcedure [dbo].[MilitaryBase_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MilitaryBase_SelectAll]

AS
/*

SELECT * FROM ServiceBranch

--EXEC MilitaryBase_SelectAll 
*/

BEGIN

	SELECT mb.Id
	, MilitaryBase
	, ServiceBranchId
	, sb.Name 
	FROM dbo.MilitaryBase AS mb

	JOIN dbo.ServiceBranch AS sb 
		ON mb.ServiceBranchId = sb.Id
		Order By MilitaryBase

END


GO
/****** Object:  StoredProcedure [dbo].[MilitaryBase_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MilitaryBase_SelectById]
	@Id int
AS
--EXEC MilitaryBase_SelectById 666
BEGIN
	SELECT mb.Id
		, mb.MilitaryBase
		, mb.ServiceBranchId
		, sb.Name AS ServiceBranch
	FROM dbo.MilitaryBase AS mb
	JOIN dbo.ServiceBranch AS sb ON mb.ServiceBranchId = sb.Id
	WHERE mb.Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[MilitaryBase_SelectByServiceBranchId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MilitaryBase_SelectByServiceBranchId]
	@Id int

AS

/*
	SELECT * FROM ServiceBranch

	DECLARE @ServiceBranchId int = 18

	EXEC [MilitaryBase_SelectByServiceBranchId] @ServiceBranchId

*/

BEGIN
	SELECT mb.Id
		, mb.MilitaryBase
		, mb.ServiceBranchId
		, sb.Name AS ServiceBranchName
	FROM dbo.MilitaryBase AS mb
	
	JOIN dbo.ServiceBranch AS sb ON mb.ServiceBranchId = sb.Id
	WHERE sb.Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[MilitaryBase_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MilitaryBase_Update]
	@Id int
	, @MilitaryBase nvarchar(150)
	, @ServiceBranchId int = 54
AS
BEGIN
 /*

 Declare @Id int = 665
	, @MilitaryBase nvarchar(150) = 'New Base'
	, @ServiceBranchId int = 18
	 
EXEC MilitaryBase_Update
		@Id
		, @MilitaryBase
		, @ServiceBranchId

SELECT *
From dbo.MilitaryBase
Where Id = @Id
 */
UPDATE [dbo].[MilitaryBase]
   SET MilitaryBase = @MilitaryBase
		, ServiceBranchId = @ServiceBranchId
   WHERE Id = @Id
END




GO
/****** Object:  StoredProcedure [dbo].[NotificationEvent_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[NotificationEvent_Insert]
			@Name NVARCHAR(250)
			,@Code NVARCHAR(50)

AS

/* TEST CODE

DECLARE		@Name NVARCHAR(250) = 'Squad Event Deleted'
			,@Code NVARCHAR(50) = 'SqEventDel'

EXECUTE	dbo.NotificationEvent_Insert
			@Name
			,@Code

SELECT *
FROM NotificationEvent

*/

BEGIN

	INSERT INTO [dbo].[NotificationEvent]
			   ([Name]
			   ,[Code])
		 VALUES
			   (@Name
			   ,@Code)

END




GO
/****** Object:  StoredProcedure [dbo].[NotificationEvent_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NotificationEvent_SelectAll]

AS

/*

	EXECUTE NotificationEvent_SelectAll

*/

BEGIN

SELECT [Id]
      ,[Name]
  FROM [dbo].[NotificationEvent]
  ORDER BY Id

END




GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC	[dbo].[Opportunity_Delete]
			@Id int

AS

/*  ---- TEST CODE ----

	Declare @id int = 4

	Select	*
	From	dbo.Opportunity
	Where	Id = @Id;

	Execute	dbo.Opportunity_Delete @Id

	Select	*
	From	dbo.Opportunity
	Where	Id = @id;

*/

BEGIN

		DELETE FROM dbo.Opportunity
		WHERE Id = @Id


END


GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Opportunity_Insert]

		@Name nvarchar(50)
		,@Description nvarchar(500)
		,@ContactPersonFirstName nvarchar(50)
		,@ContactPersonLastName nvarchar(50)
		,@Email nvarchar(50)
		,@Phone nvarchar(50) = null
		,@Address1 nvarchar(50) = null
		,@Address2 nvarchar(50) = null
		,@City nvarchar(50) = null
		,@StateProvinceId int = null
		,@PostalCode nvarchar(10) = null
		,@CountryId int = null
		,@UserIdCreated nvarchar(128)
		,@DateTimePickerStart datetime2(7) = null
		,@DateTimePickerEnd datetime2(7) = null
		,@Id int OUTPUT

AS 


/* ---- TEST CODE ----

Declare @Id int = 0;

Declare @Name nvarchar(50) = 'Science Fair'
		,@Description nvarchar(500) = 'Fun'
		,@ContactPersonFirstName nvarchar(50) = 'Martin'
		,@ContactPersonLastName nvarchar(50) = 'McFly'
		,@Email nvarchar(50) = 'marty@mcfly.com'
		,@Phone nvarchar(50) = '(818)-555-1954'
		,@Address1 nvarchar(50) = 'Orange Blvd.'
		,@Address2 nvarchar(50) = NULL 
		,@City nvarchar(50) = 'Pasadena'
		,@StateProvinceId int = 9
		,@PostalCode nvarchar(10) = 91695
		,@CountryId int = 247
		,@UserIdCreated nvarchar(128) = '0008'

		--,@DateTimePickerStart datetime2(7) = '04/17/2017 12:01 AM'
		--,@DateTimePickerEnd datetime2(7) = '04/17/2017 12:01 PM'

		,@DateTimePickerStart datetime2(7) = '1991-01-02 12:01:59'
		,@DateTimePickerEnd datetime2(7) = '1991-02-02 13:03:23'

Execute dbo.Opportunity_Insert
		@Name 
		,@Description 
		,@ContactPersonFirstName 
		,@ContactPersonLastName 
		,@Email 
		,@Phone 
		,@Address1 
		,@Address2 
		,@City 
		,@StateProvinceId 
		,@PostalCode 
		,@CountryId 
		,@UserIdCreated 
		,@DateTimePickerStart
		,@DateTimePickerEnd
		,@Id OUTPUT

		Select @Id

		Select	*
		From	dbo.Opportunity
		Where	Id = @Id

*/ 

BEGIN 


INSERT INTO dbo.Opportunity
			([Name]
			,[Description]
			,[ContactPersonFirstName]
			,[ContactPersonLastName]
			,[Email]
			,[Phone]
			,[Address1]
			,[Address2]
			,[City]
			,[StateProvinceId]
			,[PostalCode]
			,[CountryId]
			,[UserIdCreated]
			,DateTimePickerStart
			,DateTimePickerEnd)
     VALUES
			(@Name 
			,@Description 
			,@ContactPersonFirstName 
			,@ContactPersonLastName 
			,@Email 
			,@Phone 
			,@Address1 
			,@Address2 
			,@City 
			,@StateProvinceId 
			,@PostalCode 
			,@CountryId 
			,@UserIdCreated
			,@DateTimePickerStart
			,@DateTimePickerEnd )

		   SET @Id = SCOPE_IDENTITY()
END



GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Opportunity_Search]

		@SearchString NVARCHAR(1000) = ''
		,@CurrentPage INT = 1
		,@ItemsPerPage INT = 3
		,@BeginDate datetime2(7) = null
		,@EndDate datetime2(7) = null
		,@SortByColumn nvarchar(50) = 'Name' -- 'Name' or "DateTimePickerStart".
		,@Descending bit = 0 -- 0 means asc order. 


		/*
			add: 
			*	start date type datetime2-7
			*	end date type datetime2-7
			pass in sort criteria: alphabetical, title, start date, Asc/Des 

			if begin date is before datetimepickerEnd OR if end date is after datetimepickerStart  
					*IF (@BeginDate < o.DateTimePickerEnd) OR (@EndDate > o.DateTimePickerStart)

			sortBycolumn - write a tSql Case Statement that sort by name or dateTimePickerStart.
					CASE bleh
						WHEN something 
						THEN that
						ELSE this (optional)
					END,
			in mid tier add some stuff

			in front end - upcoming events - "page 1 , 3 items"
							search strimg is selection criteria
							add begin and end datepicker
							add dropdown that sorts by name or startime (optional) 
		*/

AS  

/* TEST 

DECLARE	@SearchString NVARCHAR(1000) = '.com'
		,@CurrentPage INT = 1
		,@ItemsPerPage INT = 5
		,@BeginDate datetime2(7) = '2017-05-06 12:01:59'
		,@EndDate datetime2(7) = '2017-05-08 13:03:23'
		,@SortByColumn nvarchar(50) = 'DateTimePickerStart'
		,@Descending bit = 1 

EXEC	dbo.Opportunity_Search
		@SearchString
		,@CurrentPage
		,@ItemsPerPage
		,@BeginDate 
		,@EndDate 
		,@SortByColumn 
		,@Descending

*/

BEGIN

/* ---- ADD INFO TO BE RETURNED HERE ... */

	SELECT	o.Id
			,o.Name
			,o.Description
			,o.ContactPersonFirstName
			,o.ContactPersonLastName
			,o.Email
			,o.Phone
			,o.Address1
			,o.Address2
			,o.City
			,o.StateProvinceId
			,sp.StateProvinceCode
			,sp.Name StateName
			,o.PostalCode
			,o.CountryId
			,c.Name CountryName
			,c.Code CountryCode
			,c.LongCode CountryLongCode
			,o.DateTimePickerStart
			,o.DateTimePickerEnd
			,COUNT(*) OVER () TotalRows
			--INTO	#TempTable  /* this line is not needed. only needed if you need to add more items to your query result */
			FROM	dbo.Opportunity o
			LEFT JOIN StateProvince sp
				ON o.StateProvinceId = sp.Id
			LEFT JOIN Country c
				ON o.CountryId = c.Id
			WHERE (
					o.Name LIKE '%' + @SearchString + '%'
					OR o.Description LIKE '%' + @SearchString + '%'
					OR o.ContactPersonFirstName LIKE '%' + @SearchString + '%'
					OR o.ContactPersonLastName LIKE +  '%' + @SearchString + '%'
					OR o.Email LIKE +  '%' + @SearchString + '%'
					OR o.City LIKE +  '%' + @SearchString + '%'
					OR o.StateProvinceId LIKE +  '%' + @SearchString + '%'
					OR o.PostalCode LIKE +  '%' + @SearchString + '%'
					OR o.CountryId LIKE +  '%' + @SearchString + '%'  
					)
					-- this takes care of the remainder event time.
					AND (
						@BeginDate IS NULL OR @BeginDate < o.DateTimePickerEnd
						)
					AND (
						@EndDate IS NULL OR @EndDate >= o.DateTimePickerStart
						) 
		
			-- sorting --
			ORDER BY 	CASE	WHEN
								@sortByColumn = 'Name' AND @Descending = 0 
								THEN o.Name END,
						CASE WHEN
								 @SortByColumn = 'Name' AND @Descending = 1
								THEN o.Name END DESC, 
						CASE WHEN
								 @SortByColumn = 'DateTimePickerStart' AND @Descending = 0 
								THEN o.DateTimePickerStart END,
						CASE WHEN
								 @SortByColumn = 'DateTimePickerStart' AND @Descending = 1 
								THEN o.DateTimePickerStart END DESC

			OFFSET @ItemsPerPage * (@CurrentPage - 1) ROWS
			FETCH NEXT @ItemsPerPage ROWS ONLY

	--					/*  this block is not needed because tempTable is not needed.  */
	--SELECT	*
	--FROM	#TempTable
	--ORDER BY			CASE WHEN
	--							@sortByColumn = 'Name' AND @Descending = 0 
	--							THEN Name END,
	--					CASE WHEN
	--							 @SortByColumn = 'Name' AND @Descending = 1
	--							THEN Name END DESC, 
	--					CASE WHEN
	--							 @SortByColumn = 'DateTimePickerStart' AND @Descending = 0 
	--							THEN DateTimePickerStart END,
	--					CASE WHEN
	--							 @SortByColumn = 'DateTimePickerStart' AND @Descending = 1 
	--							THEN DateTimePickerStart END DESC

END


GO
/****** Object:  StoredProcedure [dbo].[Opportunity_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Opportunity_SelectAll]
		/* added this 6/1 */
		--@CurrentPage INT = 1
		--,@ItemsPerPage INT = 5

AS

/*

--DECLARE		@CurrentPage INT = 3
--			,@ItemsPerPage INT = 3

Execute dbo.Opportunity_SelectAll
			--@CurrentPage
			--,@ItemsPerPage
*/

BEGIN


	SELECT	o.Id
			,o.Name
			,Description
			,ContactPersonFirstName
			,ContactPersonLastName
			,Email
			,Phone
			,Address1
			,Address2
			,City
			,StateProvinceId
			,sp.StateProvinceCode
			,sp.Name StateName
			,PostalCode      
			,o.CountryId
			,c.Name CountryName
			,c.Code CountryCode
			,c.LongCode CountryLongCode
			,DateTimePickerStart
			,DateTimePickerEnd
			,COUNT(*) OVER () TotalRows
			FROM dbo.Opportunity AS o
			LEFT JOIN StateProvince AS sp	ON o.StateProvinceId = sp.Id
			LEFT JOIN Country AS c	ON o.CountryId = c.Id
			ORDER BY o.Name
			/* added this 6/1 */
			--OFFSET @ItemsPerPage * (@CurrentPage - 1) ROWS
			--FETCH NEXT @ItemsPerPage ROWS ONLY

END



GO
/****** Object:  StoredProcedure [dbo].[Opportunity_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Opportunity_SelectById]
			@Id int

AS

/*

Declare @Id int = 13;

Execute dbo.Opportunity_SelectById @Id

*/

BEGIN


SELECT o.Id
      ,o.Name
      ,Description
      ,ContactPersonFirstName
      ,ContactPersonLastName
      ,Email
      ,Phone
      ,Address1
      ,Address2
      ,City
      ,StateProvinceId
	  ,sp.StateProvinceCode
	  ,sp.Name StateName
      ,PostalCode      
	  ,o.CountryId
	  ,c.Name CountryName
	  ,c.Code CountryCode
	  ,c.LongCode CountryLongCode
  --FROM [dbo].[Opportunity]
  --Where Id = @Id
		,DateTimePickerStart
		,DateTimePickerEnd

  		FROM dbo.Opportunity AS o
		LEFT JOIN StateProvince AS sp	ON o.StateProvinceId = sp.Id
		LEFT JOIN Country AS c			ON o.CountryId = c.Id
		WHERE o.Id = @Id

END



GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC	[dbo].[Opportunity_Update]
			@Name nvarchar(50)
			,@Description nvarchar(500)
			,@ContactPersonFirstName nvarchar(50)
			,@ContactPersonLastName nvarchar(50)
			,@Email nvarchar(50)
			,@Phone nvarchar(50) = null
			,@Address1 nvarchar(50) = null
			,@Address2 nvarchar(50) = null
			,@City nvarchar(50) = null
			,@StateProvinceId int = null
			,@PostalCode nvarchar(10) = null
			,@CountryId int = null
			,@UserIdCreated nvarchar(128) = null
			,@DateTimePickerStart datetime2(7) = null
			,@DateTimePickerEnd datetime2(7) = null
			,@Id int

AS 


/* ---- TEST CODE ----

	Declare  @Name nvarchar(50) = 'Test Name A'
			,@Description nvarchar(500) = 'Test description.'
			,@ContactPersonFirstName nvarchar(50) = 'Test'
			,@ContactPersonLastName nvarchar(50) = 'Ting'
			,@Email nvarchar(50) = 'testing@gmail.com'
			,@Phone nvarchar(50) = '(818)-321-4321'
			,@Address1 nvarchar(50) = '662 Code Court'
			,@Address2 nvarchar(50) = NULL
			,@City nvarchar(50) = 'Pleasantville'
			,@StateProvinceId int = 1001
			,@PostalCode nvarchar(10) = 92001
			,@CountryId int = 2001
			,@UserIdCreated nvarchar(128) = '0001'
			,@DateTimePickerStart datetime2(7) = '1991-01-02 12:01:59'
			,@DateTimePickerEnd datetime2(7) = '1991-02-02 13:03:23'
			,@Id int = 22


	Select	*
	From	dbo.Opportunity
	Where	Id = @Id

	Execute dbo.Opportunity_Update
			@Name 
			,@Description 
			,@ContactPersonFirstName 
			,@ContactPersonLastName 
			,@Email 
			,@Phone 
			,@Address1 
			,@Address2 
			,@City 
			,@StateProvinceId 
			,@PostalCode 
			,@CountryId 
			,@UserIdCreated 
			,@DateTimePickerStart
			,@DateTimePickerEnd
			,@Id 


	Select	*
	From	dbo.Opportunity
	Where	Id = @Id

*/ 

BEGIN 

Declare @datNow datetime2 = getutcdate();

UPDATE		[dbo].[Opportunity]
SET        [Name] = @Name 
			,[Description] = @Description
			,[ContactPersonFirstName] = @ContactPersonFirstName
			,[ContactPersonLastName] = @ContactPersonLastName
			,[Email] = @Email
			,[Phone] = @Phone
			,[Address1] = @Address1
			,[Address2] = @Address2
			,[City] = @City
			,[StateProvinceId] = @StateProvinceId
			,[PostalCode] = @PostalCode
			,[CountryId] = @CountryId
			,[UserIdCreated] = @UserIdCreated
			,DateTimePickerStart = @DateTimePickerStart
			,DateTimePickerEnd = @DateTimePickerEnd


WHERE Id = @Id

END



GO
/****** Object:  StoredProcedure [dbo].[Person_CheckByAspNetUserId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Person_CheckByAspNetUserId]
			@AspNetUserId NVARCHAR(128)
	       ,@Exists BIT OUTPUT
		
AS
/* TEST CASE

SELECT *
FROM dbo.Person

DECLARE		@AspNetUserId NVARCHAR(128) = '186a6dc9-4428-4ee4-9125-858a2a745d95'
	       ,@Exists BIT

EXECUTE dbo.Person_CheckByAspNetUserId
			@AspNetUserId
		   ,@Exists OUTPUT

SELECT @Exists


*/
BEGIN
	
	IF EXISTS (SELECT * FROM Person WHERE AspNetUserId = @AspNetUserId)
		BEGIN
			SET @Exists = 1
		END
	ELSE
		BEGIN
			SET @Exists = 0
		END


END



GO
/****** Object:  StoredProcedure [dbo].[Person_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROC [dbo].[Person_Delete]

@Id int
AS

/* Test Code

DECLARE @Id INT = 122

SELECT *
FROM dbo.Person
WHERE Id = @Id

EXECUTE dbo.Person_Delete
		@Id

SELECT *
FROM dbo.Person
WHERE Id = @Id

*/








BEGIN
    UPDATE Person
	SET IsDeleted = 1
	WHERE Id = @Id
END




GO
/****** Object:  StoredProcedure [dbo].[Person_GetPhotoKey]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Person_GetPhotoKey] 
@ASPNetUSerId nvarchar(50)
AS
BEGIN
	select PhotoKey FROM Person 
	Where person.ASPNetUserId =@ASPNetUserId

	
END


GO
/****** Object:  StoredProcedure [dbo].[Person_GetResume]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROC [dbo].[Person_GetResume] 
@ASPNetUSerId nvarchar(50)
AS
BEGIN
	select  [Resume] from Person
	Where ASPNetUserId =@ASPNetUserId

	
END

-- Exec  person_resume 'dgssgsdgsg.doc', '186a6dc9-4428-4ee4-9125-858a2a745d95'

GO
/****** Object:  StoredProcedure [dbo].[Person_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Person_Insert] 

	@FirstName nvarchar(50)
	, @MiddleName nvarchar(50) = null
	, @LastName nvarchar(50) 
	, @PhoneNumber nvarchar(20) = null
	, @Email nvarchar(50) = null	
	, @JobTitle nvarchar(100) = null
	, @DateOfBirth date = null
	, @Address1 nvarchar(100) = null
	, @Address2 nvarchar(100) = null
	, @City nvarchar(50) = null
	, @StateProvinceId int = null
	, @PostalCode nvarchar(10) = null
	, @CountryId int = null
	, @AspNetUserId nvarchar(128) 
	, @IsVeteran bit = Null
	, @IsEmployer bit = Null
	, @IsFamilyMember bit = Null
	, @Description nvarchar(1000) = Null
	, @EmploymentStatus nvarchar(50) = Null	
	, @IsEmployed bit = null
	, @OpCodeEmployAssist bit = null
	, @PersonMilitaryBaseIds dbo.IntIdTable READONLY
	, @PersonSkillIds dbo.IntIdTable READONLY
	, @PersonLanguageIds dbo.IntIdTable READONLY
	, @EducationLevelId INT = Null
	, @PhotoKey nvarchar(100)='no_photo.jpg'
	, @IsPhonePublic bit = 0
	, @IsAddressPublic bit = 0
	, @IsEmailPublic bit = 0
	, @IsDateOfBirthPublic bit = 0
	
	-- Person is inserted during registration, where the user is not 
	-- logged in, so we don't have their UserIdCreated.
	, @Id int output
		
AS
/* TEST CASE

DECLARE		@FirstName NVARCHAR(50) = 'Delete Me'
			,@MiddleName NVARCHAR(50) = 'Test MiddleName'
			,@LastName NVARCHAR(50) = 'Test LastName'
			,@PhoneNumber NVARCHAR(20) = '18009992222'
			,@Email NVARCHAR(50) = 'Test@email.com'
			,@JobTitle nvarchar(100) = 'developer'
			,@DateOfBirth date = GETUTCDATE()
			,@Address1 NVARCHAR(100) = 'Test Address1'
			,@Address2 NVARCHAR(100) = 'Test Address2'
			,@City NVARCHAR(50) = 'Test City'
			,@StateProvinceId INT = 9
			,@PostalCode NVARCHAR(10) = 12345
			,@CountryId INT = 247
			,@AspNetUserId nvarchar(128) = '3cc3139c-69d8-4c25-926d-8c8a5bfa1486'	
			,@IsVeteran bit = Null
			,@IsEmployer bit = Null
			,@IsFamilyMember bit = Null
			,@Description nvarchar(1000) = Null
			,@EmploymentStatus nvarchar(50) = Null	
			,@IsEmployed bit = null
			,@OpCodeEmployAssist bit = null
			,@PersonLanguageIds dbo.IntIdTable
			,@PersonSkillIds dbo.IntIdTable READONLY
			,@PersonMilitaryBaseIds dbo.IntIdTable	
			,@EducationLevelId INT = 1
			,@IsPhonePublic bit = 0
			,@IsAddressPublic bit = 0
			,@IsEmailPublic bit = 0
			,@IsDateOfBirthPublic bit = 0
			,@Id INT
			
			INSERT @PersonMilitaryBaseIds (data)
			VALUES (4), (5)

EXECUTE dbo.Person_Insert
			@FirstName
			,@MiddleName
			,@LastName
			,@PhoneNumber
			,@Email		   
			,@JobTitle
			,@DateOfBirth
			,@Address1
			,@Address2
			,@City
			,@StateProvinceId
			,@PostalCode
			,@CountryId
			,@AspNetUserId
			,@IsVeteran bit = Null
			,@IsEmployer bit = Null
			,@IsFamilyMember bit = Null
			,@Description nvarchar(1000) = Null
			,@EmploymentStatus nvarchar(50) = Null	
			,@IsEmployed bit = null
			,@OpCodeEmployAssist bit = null
			,@PersonLanguageIds
			,@PersonSkillids
			,@PersonMilitaryBaseIds
			,@EducationLevelId
			, @IsPhonePublic 
			, @IsAddressPublic 
			, @IsEmailPublic 
			, @IsDateOfBirthPublic 
			,@Id OUTPUT
			

SELECT *
FROM Person
WHERE Id = @Id

EXEC Person_SelectById @Id

*/
BEGIN
	
	INSERT INTO Person (FirstName
		, MiddleName
		, LastName
		, PhoneNumber
		, Email		
		, JobTitle
		, DateOfBirth
		, Address1
		, Address2
		, City
		, StateProvinceId
		, PostalCode
		, CountryId
		, AspNetUserId
		, IsVeteran
		, IsEmployer
		, IsFamilyMember
		, Description
		, EmploymentStatus
		, IsEmployed
		, OpCodeEmployAssist
		, UserIdCreated
		, EducationLevelId
		, PhotoKey
		, IsPhonePublic
		, IsAddressPublic
		, IsEmailPublic
		, IsDateOfBirthPublic)
		
		
		
	
	VALUES(@FirstName
		, @MiddleName
		, @LastName
		, @PhoneNumber
		, @Email		
		, @JobTitle
		, @DateOfBirth
		, @Address1
		, @Address2
		, @City
		, @StateProvinceId
		, @PostalCode
		, @CountryId
		, @AspNetUserId
		, @IsVeteran
		, @IsEmployer
		, @IsFamilyMember
		, @Description
		, @EmploymentStatus
		, @IsEmployed
		, @OpCodeEmployAssist
		, @AspNetUserId
		, @EducationLevelId
		, @PhotoKey
		, @IsPhonePublic 
		, @IsAddressPublic 
		, @IsEmailPublic 
		, @IsDateOfBirthPublic)
		

	SET @Id = SCOPE_IDENTITY()  
	
	

	INSERT INTO dbo.PersonLanguage (PersonId, LanguageId)
		SELECT @Id, data
		FROM @PersonLanguageIds

	INSERT INTO dbo.PersonSkill (PersonId, SkillId)
		SELECT @Id, data
		FROM @PersonSkillIds

	INSERT INTO dbo.PersonMilitaryBase(PersonId, MilitaryBaseId)
		SELECT @Id, data
		FROM @PersonMilitaryBaseIds

END



GO
/****** Object:  StoredProcedure [dbo].[Person_Insert_Google_LogIn]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Person_Insert_Google_LogIn] 
	  @FirstName nvarchar(50)
	, @LastName nvarchar(50) 
	, @PhotoKey nvarchar(100)='no_photo.jpg',
	@AspNetUserId nvarchar(50),
	@isPhonePublic bit =0,
	@IsAddressPublic bit =0,
	@IsEmailPublic bit =0,
	@IsDateOfBirthPublic bit=0,
	@Id int output
		
AS
BEGIN
	

	INSERT INTO Person (
	     FirstName
		, LastName
		, AspNetUserId
		, UserIdCreated
		, PhotoKey
		,isPhonePublic 
		,IsEmailPublic
		,IsDateOfBirthPublic
		)
		
		
	
	VALUES(
	      @FirstName
		, @LastName
		, @AspNetUserId
		, @AspNetUserId
		, @PhotoKey
		,@isPhonePublic
		,@IsEmailPublic
		,@IsDateOfBirthPublic
		)
		

	SET @Id = SCOPE_IDENTITY()  

	-- Exec 
END



GO
/****** Object:  StoredProcedure [dbo].[Person_InsertPhotoKey]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Person_InsertPhotoKey] 
@PhotoKey nvarchar(50),
@ASPNetUSerId nvarchar(50)
AS
BEGIN
	Update Person 
	SET PhotoKey =@PhotoKey
	Where person.ASPNetUserId =@ASPNetUserId

	select ASPNetUserId, PhotoKey from Person
END


GO
/****** Object:  StoredProcedure [dbo].[Person_Resume]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Person_Resume] 
@Resume nvarchar(100),
@ASPNetUSerId nvarchar(50)
AS
BEGIN
	Update Person 
	SET Resume =@Resume
	Where person.ASPNetUserId =@ASPNetUserId

	select ASPNetUserId, Resume from Person
END

-- Exec  person_resume 'dgssgsdgsg.doc' 

GO
/****** Object:  StoredProcedure [dbo].[Person_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Person_Search]

	 @SearchStr nvarchar(250) = ''
	,@CurrentPage int = 1
	,@ItemsPerPage int = 10
	,@Latitude decimal(9,6) = null
	,@Longitude decimal(9,6) = null
	,@Radius int = null
	,@IsVeteran bit = null
	,@IsEmployer bit = null
	,@IsFamilyMember bit = null

AS
/* TEST CODE

Declare @SearchStr nvarchar(250) = ''
	   ,@CurrentPage int = 1
	   ,@ItemsPerPage int = 10
	   ,@Latitude decimal(9,6) 
	   ,@Longitude decimal(9,6)
	   ,@Radius int = 0
	   ,@IsVeteran bit = 1
	   ,@IsEmployer bit = 0
	   ,@IsFamilyMember bit = 0

EXECUTE dbo.Person_Search
		@SearchStr
		,@CurrentPage
		,@ItemsPerPage
		,@Latitude
		,@Longitude
		,@Radius
		,@Isveteran
		,@IsEmployer


		EXEC Person_Search @CurrentPage = 1
		EXEC Person_Search @ItemsPerPage = 1000
		EXECUTE Person_Search 'Cat'
		

*/

BEGIN

	DECLARE @location GEOGRAPHY
	IF @Latitude IS NOT NULL AND @Longitude IS NOT NULL
	SET @Location = GEOGRAPHY::Point(@Latitude, @Longitude, 4326)

		Select P.Id
			,FirstName
			,MiddleName
			,LastName
			,PhoneNumber
			,Email
			,JobTitle
			,PhotoKey
			,IsVeteran
			,IsEmployer
			,IsFamilyMember
			,Address1
			,Address2
			,P.City
			,P.StateProvinceId
			,SP.Name AS StateProvinceName
			,P.CountryId
			,C.Name AS CountryName
			,P.Latitude AS Latitude
			,P.Longitude As Longitude
			,COUNT (*) OVER () TotalRows
		INTO #RESULT
		FROM Person P	
		LEFT JOIN dbo.StateProvince SP ON SP.Id = P.StateProvinceId
		LEFT JOIN dbo.Country C ON C.Id = P.CountryId
		WHERE (FirstName LIKE '%' + @SearchStr + '%'
		OR LastName Like '%' + @SearchStr + '%'
		OR FirstName + ' ' + LastName LIKE '%' + @SearchStr + '%'
		OR PhoneNumber LIKE '%' + @SearchStr + '%'
		OR Email LIKE '%' + @SearchStr + '%'
		OR JobTitle LIKE '%' + @SearchStr + '%')
		AND ((@Radius = 0) OR (@Location is NULL) OR (@Location.STDistance(Location)<= @Radius))
		--AND ((@Latitude = 0) OR (@Longitude =0))
		ORDER BY FirstName, LastName
		OFFSET @ItemsPerPage * (@CurrentPage -1) ROWS
		FETCH NEXT @ItemsPerPage ROWS ONLY

		SELECT * FROM #RESULT ORDER BY FirstName, LastName, PhoneNumber,Email, JobTitle
		/*
		SELECT p.Id
		,p.FirstName
		, p.MiddleName
		, p.LastName
		, p.PhoneNumber
		, p.Email
		, p.JobTitle
		, p.PhotoKey

		FROM Person p
		WHERE (p.FirstName LIKE '%' + @SearchStr + '%'
			or p.LastName LIKE '%' + @SearchStr + '%'
			or p.PhoneNumber LIKE '%' + @SearchStr + '%'
			or p.Email LIKE '%' + @SearchStr + '%')
*/
END



GO
/****** Object:  StoredProcedure [dbo].[Person_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Person_SelectAll] 
	
AS
/* Test Code

EXECUTE dbo.Person_SelectAll

*/
BEGIN
	 
	SELECT 
		p.Id
		, p.FirstName
		, p.MiddleName
		, p.LastName
		, p.PhoneNumber
		, p.Email	 
		, p.JobTitle
		, p.DateOfBirth
		, p.Address1
		, p.Address2
		, p.City
		, p.StateProvinceId
		, sp.StateProvinceCode
		, sp.Name StateName
		, p.PostalCode
		, p.CountryId
		, c.LongCode CountryLongCode
		, c.Code CountryCode
		, c.Name CountryName
		, p.AspNetUserId
		, p.PhotoKey
		, p.IsVeteran
		, p.IsEmployer	
		, p.IsFamilyMember
		, p.Description
		, p.EmploymentStatus
		, p.IsEmployed
		, p.OpCodeEmployAssist
		, p.IsPhonePublic
		, p.IsAddressPublic
		, p.IsEmailPublic
		, p.IsDateOfBirthPublic
	 
	 FROM PERSON p
		LEFT JOIN StateProvince sp ON p.StateProvinceId = sp.Id
		LEFT JOIN Country c ON p.CountryId = c.Id
		WHERE IsDeleted = 0
		ORDER BY p.LastName, p.FirstName

		SELECT p.Id AS PersonId
			 ,mb.Id
			 ,mb.MilitaryBase
			 ,sb.Name AS ServiceBranch

	  FROM [dbo].[Person] p
	  LEFT JOIN dbo.PersonMilitaryBase pmb ON pmb.PersonId = p.Id
	  LEFT JOIN dbo.MilitaryBase mb ON pmb.MilitaryBaseId = mb.Id
	  JOIN dbo.ServiceBranch sb ON mb.ServiceBranchId = mb.ServiceBranchId
	  WHERE IsDeleted = 0 AND mb.ServiceBranchId = sb.Id
		
	SELECT p.Id AS PersonId
			,CONVERT(varchar,l.id) + '-' + CONVERT(varchar,lp.id) AS 'Key'
			,l.Id
			,l.Name
			,lp.Id
			,lp.Code
	 FROM [dbo].[Person] p	
	  LEFT JOIN dbo.PersonLanguage pl ON pl.PersonId = p.Id
	  LEFT JOIN	dbo.[Language] l on pl.LanguageId = l.Id
	  LEFT JOIN dbo.LanguageProficiency lp on pl.LanguageProficiencyId = Lp.Id

	 SELECT p.Id AS PersonId
			,sk.Id
			,sk.Name

	 FROM [dbo].[Person] p
	  LEFT JOIN dbo.PersonSkill psk ON psk.PersonId = p.Id
	  LEFT JOIN [dbo].[Skill] sk ON psk.SkillId = sk.Id


	  
	  

END





GO
/****** Object:  StoredProcedure [dbo].[Person_SelectByAspNetUserId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Person_SelectByAspNetUserId]
			@AspNetUserId NVARCHAR(128)

AS

/* TEST CODE

	EXEC Person_SelectByAspNetUserId '186a6dc9-4428-4ee4-9125-858a2a745d95'
*/

BEGIN


	SELECT [Id]
		  ,[FirstName]
		  ,[MiddleName]
		  ,[LastName]
		  ,[PhoneNumber]
		  ,[Email]
		  ,[JobTitle]
	  FROM [dbo].[Person]
	  WHERE AspNetUserId = @AspNetUserId

	SELECT pr.Id,
		pr.ProjectName
	FROM Person p
		JOIN ProjectPerson pp 
	ON pp.PersonId = p.Id
		JOIN Project pr
	ON pr.Id = pp.ProjectId
	WHERE p.AspNetUserId = @AspNetUserId

	SELECT TOP 1 tce.Id
		, tce.ProjectId
		, tce.StartDateTimeUtc
		, tce.EndDateTimeUtc
	FROM Person p	
		JOIN TimecardEntry tce
	ON p.Id = tce.PersonId
	WHERE p.AspNetUserId = @AspNetUserId
	ORDER BY tce.StartDateTimeUtc DESC, tce.Id DESC

END




GO
/****** Object:  StoredProcedure [dbo].[Person_SelectByAspNetUsersEmail]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Person_SelectByAspNetUsersEmail]
            @email nvarchar(50)
AS

BEGIN 
/* test code

DECLARE @email nvarchar(50) = 'stallone@mailinator.com'

EXECUTE dbo.Person_SelectByAspNetUsersEmail
			@email 

*/
	SELECT	dbo.Person.Id
		   ,dbo.Person.FirstName
		   ,dbo.Person.MiddleName
		   ,dbo.Person.LastName
		   ,dbo.Person.PhoneNumber
		   ,dbo.Person.Email
		   ,dbo.Person.JobTitle

	  FROM [dbo].[AspNetUsers]
	  JOIN dbo.Person ON dbo.AspNetUsers.Email = dbo.Person.Email
	  WHERE dbo.AspNetUsers.Email = @email

END




GO
/****** Object:  StoredProcedure [dbo].[Person_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Person_SelectById]

@Id int
--,@isAdmin bit

AS	
BEGIN

/*

EXEC Person_SelectById 293

*/

	SELECT 
	p.Id
	,p.FirstName
	, p.MiddleName
	, p.LastName
	, p.PhoneNumber
	, p.Email  -- CASE WHEN @isAdmin = 1 OR p.PublicEmail = 1 THEN p.Email ELSE NULL END as Email,
	, p.JobTitle
	, p.DateOfBirth
	, p.Address1
	, p.Address2
	, p.City
	, p.StateProvinceId
	, sp.StateProvinceCode
	, sp.Name StateName
	, p.PostalCode
	, p.CountryId
	, c.LongCode CountryLongCode
	, c.Code CountryCode
	, c.Name CountryName
	, p.AspNetUserId 
	, p.PhotoKey
	, p.IsVeteran
	, p.IsEmployer	
	, p.IsFamilyMember
	, p.Description
	, p.EmploymentStatus
	, p.IsEmployed
	, p.OpCodeEmployAssist
	, p.EducationLevelId
	, p.ServiceBranchId
	, p.IsPhonePublic
	, p.IsAddressPublic
	, p.IsEmailPublic
	, p.IsDateOfBirthPublic
	

		FROM PERSON p
		LEFT JOIN StateProvince sp ON p.StateProvinceId = sp.Id
		LEFT JOIN Country c ON p.CountryId = c.Id
		WHERE p.Id = @Id

	SELECT p.Id AS PersonId

			 ,mb.Id
			 ,mb.MilitaryBase
			 ,sb.Id AS ServiceBranchId
			 ,sb.Name as Name

	  FROM [dbo].[Person] p
	  LEFT JOIN dbo.PersonMilitaryBase pmb ON pmb.PersonId = p.Id
	  LEFT JOIN dbo.MilitaryBase mb ON pmb.MilitaryBaseId = mb.Id
	  JOIN dbo.ServiceBranch sb ON mb.ServiceBranchId = mb.ServiceBranchId
	  WHERE p.Id = @Id AND mb.ServiceBranchId = sb.Id
	 
	SELECT p.Id AS PersonId
			,CONVERT(varchar,l.id) + '-' + CONVERT(varchar,lp.id) AS 'Key'
			,l.Id
			,l.Name
			,lp.Id
			,lp.Code
	  FROM [dbo].[Person] p	
	  JOIN dbo.PersonLanguage pl ON pl.PersonId = p.Id
	  JOIN	dbo.[Language] l on pl.LanguageId = l.Id
	  LEFT JOIN dbo.LanguageProficiency lp on pl.LanguageProficiencyId = Lp.Id
	  WHERE p.Id = @Id

	SELECT p.Id AS PersonId
			 ,s.Id
			 ,s.Name 

	  FROM [dbo].[Person] p	
	  JOIN dbo.PersonSkill ps ON ps.PersonId = p.Id
	  JOIN	dbo.Skill s on ps.SkillId = s.Id
	  WHERE p.Id = @Id

	SELECT 
		cp.PersonId
		,cp.CompanyId
		,c.CompanyName
		,c.CompanyPhoneNumber
		,c.CompanyEmail			
	FROM CompanyPerson cp
	JOIN Company c ON cp.CompanyId = c.Id
	WHERE cp.PersonId = @Id

	SELECT 
		  sm.PersonId
		  ,sm.SquadId
		  ,sm.IsLeader
		  ,sm.Id
		  ,sm.MemberStatusId
		  ,s.Name
		  ,s.Mission
		  ,s.Notes
	FROM SquadMember sm
	JOIN Squad s ON sm.SquadId = s.Id
	WHERE sm.PersonId = @Id AND sm.MemberStatusId != 4 AND sm.MemberStatusId != 5

	EXEC PersonNotificationPreference_SelectByPersonId @Id

END



GO
/****** Object:  StoredProcedure [dbo].[Person_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Person_Update]
	
      @Id int
	 ,@FirstName nvarchar(50)
	, @MiddleName nvarchar(50) = Null
	, @LastName nvarchar(50)
	, @PhoneNumber nvarchar(20) = Null	
	, @Email nvarchar(50) = Null	
	, @JobTitle nvarchar(100) = Null
	, @DateOfBirth date = Null
	, @Address1 nvarchar(100) =Null
	, @Address2 nvarchar(100) = Null
	, @City nvarchar(50) = Null
	, @StateProvinceId int = Null
	, @PostalCode nvarchar(10) = Null
	, @CountryId int = Null
	, @IsVeteran bit = Null
	, @IsEmployer bit = Null
	, @IsFamilyMember bit = Null
	, @Description nvarchar(1000) = Null
	, @EmploymentStatus nvarchar(50) = Null	
	, @IsEmployed bit = null
	, @OpCodeEmployAssist bit = null
	, @PersonMilitaryBaseIds dbo.IntIdTable READONLY 
	, @LanguageProficiencyKeys dbo.NvarCharIdTable READONLY 
	, @PersonSkillIds dbo.IntIdTable READONLY
	, @PersonNotificationPreferences dbo.PersonNotificationPreferenceTable READONLY
	, @EducationLevelId int = null
	, @ServiceBranchId int = null
	, @IsPhonePublic bit = 0
	, @IsAddressPublic bit = 0
	, @IsEmailPublic bit = 0
	, @IsDateOfBirthPublic bit = 0

	
	
	AS
BEGIN
/* TEST CASE

DECLARE		@Id INT = 181
			,@FirstName NVARCHAR(50) = 'Johnny'
			,@MiddleName NVARCHAR(50) = 'M'
			,@LastName NVARCHAR(50) = 'Smith'
			,@PhoneNumber NVARCHAR(50) = '909-998-9889'
			,@Email NVARCHAR(50) = 'aquaman@mailinator.com'
			,@JobTitle NVARCHAR(100) = 'Athlete'
			,@DateOfBirth date = GETUTCDATE()
			,@Address1 NVARCHAR(100) = 'New Address'
			,@Address2 NVARCHAR(100) = 'New Address'
			,@City NVARCHAR(50) = 'New City'
			,@StateProvinceId int = 9
			,@PostalCode nvarchar(10) = 'Test'
			,@CountryId INT = 247
			,@IsVeteran bit = Null
			,@IsEmployer bit = Null
			,@IsFamilyMember bit = Null
			,@Description nvarchar(1000) = Null
			,@EmploymentStatus nvarchar(50) = Null
			,@IsEmployed bit = null
			,@OpCodeEmployAssist bit = null
			,@PersonMilitaryBaseIds dbo.IntIdTable
			,@LanguageProficiencyKeys dbo.NvarCharIdTable
			,@PersonSkillIds dbo.IntIdTable
			,@PersonNotificationPreferences dbo.PersonNotificationPreferenceTable
			,@EducationLevelId INT
			,@ServiceBranchId bit
			,@IsPhonePublic bit
			,@IsAddressPublic bit
			,@IsEmailPublic bit
			,@IsDateOfBirthPublic bit
				
			INSERT @PersonMilitaryBaseIds (data)
			VALUES (3), (4)
			INSERT @LanguageProficiencyKeys (data)
			VALUES (125)
			INSERT @PersonSkillIds (data)
			VALUES (11)
			INSERT @PersonNotificationPreferences (data)
			VALUES (1)
			


EXECUTE dbo.Person_Update
				@Id
				,@FirstName
				,@MiddleName
				,@LastName
				,@PhoneNumber
				,@Email
				,@JobTitle
				,@DateOfBirth
				,@Address1
				,@Address2
				,@City
				,@StateProvinceId
				,@PostalCode
				,@CountryId
				,@IsVeteran
				,@IsEmployer
				,@IsFamilyMember
				,@Description
				,@EmploymentStatus
				,@IsEmployed
				,@OpCodeEmployAssist	
				,@PersonMilitaryBaseIds
				,@LanguageProficiencyKeys
				,@PersonSkillIds
				,@PersonNotificationPreferences
				,@EducationLevelId
				,@ServiceBranchId
				,@IsPhonePublic int
				,@IsAddressPublic int
				,@IsEmailPublic int
				,@IsDateOfBirthPublic bit
SELECT *
FROM dbo.PersonMilitaryBase
WHERE PersonId = @Id

SELECT *
FROM dbo.PersonMilitaryBase
WHERE MilitaryBaseId = @Id

SELECT *
FROM dbo.PersonLanguage
WHERE LanguageId = @Id

SELECT *
FROM dbo.PersonSkill
WHERE SkillId = @Id

SELECT *
FROM dbo.Person
WHERE Id = @Id

select * from MilitaryBase
select * from Language
select * from skill

SELECT *
FROM dbo.PersonNotificationPreference
WHERE Id = @Id



*/
    UPDATE Person
	SET 
	
	FirstName = @FirstName
	, MiddleName = @MiddleName
	, LastName = @LastName
	, PhoneNumber = @PhoneNumber
	, Email = @Email
	, JobTitle = @JobTitle
	, DateOfBirth = @DateOfBirth
	, Address1 = @Address1
	, Address2 = @Address2
	, City = @City
	, StateProvinceId = @StateProvinceId
	, PostalCode = @PostalCode
	, CountryId = @CountryId
	, IsVeteran = @IsVeteran
	, IsEmployer = @IsEmployer
	, IsFamilyMember = @IsFamilyMember
	, Description = @Description
	, EmploymentStatus = @EmploymentStatus
	, IsEmployed = @IsEmployed
	, OpCodeEmployAssist = @OpCodeEmployAssist
	,  EducationLevelId = CASE 
        WHEN @EducationLevelId = 0
            THEN NULL
			ELSE @EducationLevelId
			END
	, ServiceBranchId = @ServiceBranchId
	, IsPhonePublic = @IsPhonePublic
	, IsAddressPublic = @IsAddressPublic
	, IsEmailPublic = @IsEmailPublic
	, IsDateOfBirthPublic = @IsDateOfBirthPublic
	, DateModified = GETUTCDate()
	
	WHERE Id = @Id

	DELETE FROM dbo.PersonMilitaryBase
	 WHERE PersonId = @Id

	 INSERT INTO dbo.PersonMilitaryBase (PersonId, MilitaryBaseId)
		SELECT @Id, data
		FROM @PersonMilitaryBaseIds

	 DELETE FROM dbo.PersonLanguage
		WHERE PersonId = @Id

	INSERT INTO dbo.PersonLanguage (PersonId, LanguageId, LanguageProficiencyId)
		SELECT @Id,  SUBSTRING(data, 1, CHARINDEX('-', data)-1),
       SUBSTRING(data, CHARINDEX('-', data) + 1, 1000)

		FROM @LanguageProficiencyKeys
			

	 DELETE FROM dbo.PersonSkill
		WHERE PersonId = @Id

	 INSERT INTO dbo.PersonSkill (PersonId, SkillId)
		SELECT @Id, data
		FROM @PersonSkillIds

	 DELETE FROM dbo.PersonNotificationPreference
		WHERE PersonId = @Id

	INSERT INTO dbo.PersonNotificationPreference
				(PersonId
				, NotificationEventId
				, SendEmail
				, SendText)
	SELECT PersonId
		, NotificationEventId
		, SendEmail
		, SendText
	FROM @PersonNotificationPreferences
		WHERE PersonId = @Id


END



GO
/****** Object:  StoredProcedure [dbo].[PersonLanguage_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PersonLanguage_Delete]
			@PersonId INT
			,@LanguageId INT

AS

/* TEST CODE

DECLARE @PersonId INT = 13
		,@LanguageId INT = 5

SELECT *
FROM dbo.PersonLanguage
WHERE PersonId = @PersonId AND LanguageId = @LanguageId

EXECUTE dbo.PersonLanguage_Delete
		@PersonId
		,@LanguageId

SELECT *
FROM dbo.PersonLanguage
WHERE PersonId = @PersonId AND LanguageId = @LanguageId

*/

BEGIN

DELETE FROM [dbo].[PersonLanguage]
      WHERE PersonId = @PersonId AND LanguageId = @LanguageId



END





GO
/****** Object:  StoredProcedure [dbo].[PersonLanguage_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PersonLanguage_Insert]
			@PersonId INT
			,@LanguageId INT
			,@LanguageProficiencyId INT

AS

/* TEST CODE

DECLARE @PersonId INT 
		,@LanguageId INT 
		,@LanguageProficiencyId INT

EXECUTE dbo.PersonLanguage_Insert
		@PersonId = 217
		,@LanguageId =122
		,@LanguageProficiencyId=5
		
SELECT *
FROM dbo.PersonLanguage

*/

BEGIN

	INSERT INTO PersonLanguage
			   ([PersonId]
			   ,[LanguageId]
			   ,[LanguageProficiencyId])
		 VALUES
			   (@PersonId
			   ,@LanguageId
			   ,@LanguageProficiencyId)

END



GO
/****** Object:  StoredProcedure [dbo].[PersonMilitaryBase_SelectByPersonId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PersonMilitaryBase_SelectByPersonId]
@PersonId int
AS
BEGIN
--EXEC PersonMilitaryBase_SelectByPersonId 122
	SELECT PersonId
	, dbo.MilitaryBase.MilitaryBase
		FROM dbo.PersonMilitaryBase
		LEFT JOIN dbo.MilitaryBase ON dbo.PersonMilitaryBase.MilitaryBaseId = dbo.MilitaryBase.Id
		WHERE PersonId = @PersonId
END


GO
/****** Object:  StoredProcedure [dbo].[PersonNotificationPreference_GetContactUsersPeople]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PersonNotificationPreference_GetContactUsersPeople]
				@AspNetUserRoleId NVARCHAR(128)

AS

/* TEST CODE

DECLARE		@AspNetUserRoleId NVARCHAR(128) = ''

EXECUTE		dbo.PersonNotificationPreference_GetContactUsersPeople
			@AspNetUserRoleId

*/

BEGIN

	SELECT	P.Id
			,P.FirstName
			,P.MiddleName
			,P.LastName
			,P.PhoneNumber
			,P.Email
	  FROM [dbo].[PersonNotificationPreference] PNP
		JOIN Person P ON P.Id = PNP.PersonId
		JOIN AspNetUserRoles ANUR ON ANUR.UserId = P.AspNetUserId
	  WHERE ((ANUR.RoleId = @AspNetUserRoleId) OR (@AspNetUserRoleId = ''))
		AND PNP.NotificationEventId = 10
		AND PNP.SendEmail = 1

END




GO
/****** Object:  StoredProcedure [dbo].[PersonNotificationPreference_GetGlobalEventNotificationPeople]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PersonNotificationPreference_GetGlobalEventNotificationPeople]
				@EventActionTypeId INT

AS

/* TEST CODE

DECLARE		@EventActionTypeId INT = 1

EXECUTE		PersonNotificationPreference_GetGlobalEventNotificationPeople
			@EventActionTypeId

*/

BEGIN

	DECLARE @EventTypeId INT =
		CASE
			WHEN @EventActionTypeId = 1
				THEN 4
			WHEN @EventActionTypeId = 2
				THEN 5
			WHEN @EventActionTypeId = 3
				THEN 6
		END

	SELECT	P.Id
			,P.FirstName
			,P.MiddleName
			,P.LastName
			,P.PhoneNumber
			,P.Email
			,PNP.SendEmail
			,PNP.SendEmail
			,0 AS Placeholder
			,'' AS Placeholder2
	FROM PersonNotificationPreference PNP 
		JOIN Person P ON PNP.PersonId = P.Id
	WHERE PNP.NotificationEventId = @EventTypeId

END



GO
/****** Object:  StoredProcedure [dbo].[PersonNotificationPreference_GetJobApplicationNotifyPeople]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PersonNotificationPreference_GetJobApplicationNotifyPeople]
			@ApplicationId INT

AS

/* TEST CODE

DECLARE		@ApplicationId INT = 18

EXECUTE dbo.PersonNotificationPreference_GetJobApplicationNotifyPeople
			@ApplicationId

*/

BEGIN

	SELECT	P.Id
			,P.FirstName
			,P.MiddleName
			,P.LastName
			,P.PhoneNumber
			,P.Email
			,PNP.SendEmail
			,PNP.SendEmail
			,JP.Id
			,'' AS Placeholder
	FROM dbo.JobApplication JA
		JOIN JobPosting JP ON JA.JobPostingId = JP.Id
		JOIN CompanyPerson CP ON CP.CompanyId = JP.CompanyId
		JOIN Person P ON P.Id = CP.PersonId
		JOIN PersonNotificationPreference PNP ON PNP.PersonId = P.Id
	WHERE JA.Id = @ApplicationId
		AND PNP.NotificationEventId = 1

END




GO
/****** Object:  StoredProcedure [dbo].[PersonNotificationPreference_GetSquadEventNotificationPeople]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[PersonNotificationPreference_GetSquadEventNotificationPeople]
				@EventActionTypeId INT
				,@EventId INT

AS

/* TEST CODE

DECLARE		@EventActionTypeId INT = 1
			,@EventId INT = 9

EXECUTE		PersonNotificationPreference_GetSquadEventNotificationPeople
			@EventActionTypeId
			,@EventId

*/

BEGIN

	DECLARE @EventTypeId INT =
		CASE
			WHEN @EventActionTypeId = 1
				THEN 7
			WHEN @EventActionTypeId = 2
				THEN 8
			WHEN @EventActionTypeId = 3
				THEN 9
		END

	SELECT	P.Id
			,P.FirstName
			,P.MiddleName
			,P.LastName
			,P.PhoneNumber
			,P.Email
			,PNP.SendEmail
			,PNP.SendEmail
			,0 AS Placeholder
			,S.Name
	FROM PersonNotificationPreference PNP 
		JOIN Person P ON PNP.PersonId = P.Id
		JOIN SquadMember SM ON P.Id = SM.PersonId
		JOIN SquadEvent SE ON SE.SquadId = SM.SquadId
		JOIN Squad S ON SE.SquadId = S.Id
	WHERE PNP.NotificationEventId = @EventTypeId
		AND SE.Id = @EventId

END



GO
/****** Object:  StoredProcedure [dbo].[PersonNotificationPreference_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PersonNotificationPreference_Insert]

		(@PersonId int
        , @NotificationEventId int
        , @SendEmail bit
        , @SendText bit
		, @Id int OUTPUT)

AS

/*

	DECLARE @Id int = 0
	
	DECLARE	
			@PersonId int = 234
           , @NotificationEventId int = 1
           , @SendEmail bit = 1
           , @SendText bit = 1
		   
	EXECUTE dbo.PersonNotificationPreference_Insert
	
			@PersonId
           , @NotificationEventId
           , @SendEmail
           , @SendText
		   , @Id OUTPUT

	SELECT @Id

	SELECT *
	FROM dbo.PersonNotificationPreference
	WHERE Id = @Id

*/


BEGIN

	INSERT INTO PersonNotificationPreference
           ([PersonId]
           ,[NotificationEventId]
           ,[SendEmail]
           ,[SendText])
     VALUES
          (@PersonId
           , @NotificationEventId
           , @SendEmail
           , @SendText)

	SET @Id = SCOPE_IDENTITY()

END




GO
/****** Object:  StoredProcedure [dbo].[PersonNotificationPreference_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PersonNotificationPreference_SelectAll]

AS

/*
		EXECUTE [dbo].[PersonNotificationPreference_SelectAll]

		SELECT *
		FROM dbo.[PersonNotificationPreference]
		

*/

BEGIN

	SELECT [Id]
		,[PersonId]
		,[NotificationEventId]
		,[SendEmail]
		,[SendText]
	FROM [dbo].[PersonNotificationPreference]

END




GO
/****** Object:  StoredProcedure [dbo].[PersonNotificationPreference_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PersonNotificationPreference_SelectById]

@Id int

AS

/*
		DECLARE @Id int = 1

		EXECUTE [dbo].[PersonNotificationPreference_SelectById] @Id

*/

BEGIN

	SELECT [Id]
		,[PersonId]
		,[NotificationEventId]
		,[SendEmail]
		,[SendText]
	FROM [dbo].[PersonNotificationPreference]
	WHERE Id = @Id
  

END




GO
/****** Object:  StoredProcedure [dbo].[PersonNotificationPreference_SelectByPersonId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PersonNotificationPreference_SelectByPersonId]

@PersonId int

AS

/*
		DECLARE @PersonId int = 239

		EXECUTE [dbo].[PersonNotificationPreference_SelectByPersonId] @PersonId

*/

BEGIN

	SELECT @PersonId as PersonId
	, ne.Id as NotificationEventId
	, ne.Name as NotificationEventName
	, (SELECT isnull(pnp.SendEmail, 0) 
		FROM PersonNotificationPreference pnp 
		WHERE pnp.NotificationEventId = ne.Id 
			and pnp.PersonId = @PersonId) as SendEmail
	, (SELECT isnull(pnp.SendText, 0) 
		FROM PersonNotificationPreference pnp 
		WHERE pnp.NotificationEventId = ne.Id
			and pnp.PersonId = @PersonId)  as SendText
	FROM NotificationEvent ne
	--LEFT JOIN PersonNotificationPreference pnp
	--ON ne.Id = pnp.notificationEventId
	--WHERE pnp.PersonId IS Null OR pnp.PersonId = @PersonId
	

END

/*
------------Notes---------------
Selecting Person Id and returning a table with the Person Id, the notification Id/event names
and preferences for each event for receiving email/text notifications.

Joined Notification table to PersonNotificationPreference and attaching results to person table.

*/

GO
/****** Object:  StoredProcedure [dbo].[PersonNotificationPreference_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PersonNotificationPreference_Update]

			(@PersonId int
           , @NotificationEventId int
           , @SendEmail bit
           , @SendText bit
		   , @Id int)
AS

/*

	DECLARE @Id int = 0
	
	DECLARE	
			@PersonId int = 
           , @NotificationEventId int = 
           , @SendEmail bit = 
           , @SendText bit = 
		   
	EXECUTE dbo.PersonNotificationPreference_Insert
	
			@PersonId
           , @NotificationEventId
           , @SendEmail
           , @SendText
		   , @Id OUTPUT

	SELECT @Id

	SELECT *
	FROM dbo.PersonNotificationPreference
	WHERE Id = @Id

*/


BEGIN

	UPDATE PersonNotificationPreference
           
     SET
		PersonId = @PersonId
		, NotificationEventId = @NotificationEventId
		, SendEmail = @SendEmail
		, SendText = @SendText

	WHERE Id = @Id

END




GO
/****** Object:  StoredProcedure [dbo].[PersonProject_SelectByPersonId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PersonProject_SelectByPersonId]
			@PersonId int
AS

BEGIN

/*

EXEC dbo.PersonProject_SelectByPersonId
		@PersonId = 168

*/

	SELECT		
		pp.PersonId
		,pp.ProjectId
		,pj.ProjectName
		,pj.Deadline
		,pp.IsLeader
		,pp.StatusId AS PersonProjectStatusId
		,pps.Status
		,c.Id AS CompanyId
		,c.CompanyName
		,c.CompanyPhoneNumber
		,c.CompanyEmail
		,pp.HourlyRate
		,pj.TrelloBoardUrl		
	INTO #result
	FROM ProjectPerson pp
	JOIN Project pj ON pp.ProjectId = pj.Id
	JOIN ProjectPersonStatus pps ON pp.StatusId = pps.Id
	JOIN Company c ON pj.CompanyId = c.Id
	WHERE pp.PersonId = @PersonId AND pp.StatusId = 4 AND (pj.ProjectStatusId = 2 OR pj.ProjectStatusId = 4)

	SELECT
		pp.ProjectId
		,SUM(DATEDIFF(MINUTE, tc.StartDateTimeUtc, tc.EndDateTimeUtc)) AS MinutesOnProj
		,ROUND(SUM(DATEDIFF(MINUTE, tc.StartDateTimeUtc, tc.EndDateTimeUtc)*pp.HourlyRate)/60, 2) AS EarningsOnProj
	INTO #earnings
	FROM ProjectPerson pp
	JOIN TimecardEntry tc ON tc.ProjectId = pp.ProjectId
	WHERE pp.PersonId = @PersonId
	GROUP BY pp.ProjectId

	SELECT 
		r.*
		,e.MinutesOnProj
		,e.EarningsOnProj
	FROM #result r
	LEFT JOIN #earnings e ON e.ProjectId = r.ProjectId

END



GO
/****** Object:  StoredProcedure [dbo].[PersonPublic_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PersonPublic_SelectById]

@Id int

AS

BEGIN
	
	/*
	
	DECLARE @Id int = 234
	
	EXECUTE PersonPublic_SelectById @Id

	*/

	SELECT 

		Person.Id,
		FirstName, LastName, City, sp.Name StateName, PostalCode, Country.Name CountryName, PhotoKey, 
		CASE WHEN IsPhonePublic = 1 THEN PhoneNumber ELSE '' END AS PhoneNumber,
		CASE WHEN IsAddressPublic = 1 THEN Address1 ELSE '' END AS Address1,
		CASE WHEN IsAddressPublic = 1 THEN Address2 ELSE '' END AS Address2,
		CASE WHEN IsEmailPublic = 1 THEN Email ELSE '' END AS Email,
		CASE WHEN IsDateOfBirthPublic = 1 THEN DateOfBirth ELSE '' END AS DateOfBirth,
		Description

	FROM Person
	Left Join StateProvince sp
	ON Person.StateProvinceId = sp.Id
	Left Join Country
	ON Person.CountryId = Country.Id

	WHERE Person.Id = @Id

END



GO
/****** Object:  StoredProcedure [dbo].[PersonSkill_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PersonSkill_Delete]
			@PersonId INT
			,@SkillId INT

AS

/* TEST CODE

DECLARE @PersonId INT = 13
		,@SkillId INT = 5

SELECT *
FROM dbo.PersonSkill
WHERE PersonId = @PersonId AND SkillId = @SkillId

EXECUTE dbo.PersonSkill_Delete
		@PersonId
		,@SkillId

SELECT *
FROM dbo.PersonSkill
WHERE PersonId = @PersonId AND SkillId = @SkillId

*/

BEGIN

DELETE FROM [dbo].[PersonSkill]
      WHERE PersonId = @PersonId AND SkillId = @SkillId



END





GO
/****** Object:  StoredProcedure [dbo].[PersonSkill_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PersonSkill_Insert]
			@PersonId INT
			,@SkillId INT
			,@SkillLevel INT

AS

/* TEST CODE

DECLARE @PersonId INT = 92
		,@SkillId INT = 2
		,@SkillLevel INT = 5

EXECUTE dbo.PersonSkill_Insert
		@PersonId = 97
		,@SkillId = 1
		,@SkillLevel = 1

SELECT *
FROM dbo.PersonSkill

*/

BEGIN

	INSERT INTO PersonSkill
			   ([PersonId]
			   ,[SkillId])
		 VALUES
			   (@PersonId
			   ,@SkillId)

END



GO
/****** Object:  StoredProcedure [dbo].[PersonSkill_SelectByPersonId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PersonSkill_SelectByPersonId]
			@PersonId INT

AS

/* TEST CODE

DECLARE @PersonId INT = 13

EXECUTE dbo.PersonSkill_SelectByPersonId
			@PersonId

*/

BEGIN

	SELECT [SkillId]
		  ,dbo.Skill.Name
	  FROM [dbo].[PersonSkill]
	  JOIN dbo.Skill ON dbo.PersonSkill.SkillId = dbo.Skill.Id
	  WHERE PersonId = @PersonId


	  
END






GO
/****** Object:  StoredProcedure [dbo].[PersonSkill_SelectBySkillId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PersonSkill_SelectBySkillId]
			@SkillId INT

AS

/* TEST CODE

DECLARE @SkillId INT = 1

EXECUTE dbo.PersonSkill_SelectBySkillId
			@SkillId

*/

BEGIN

	SELECT [PersonId]
		  ,dbo.Person.Id
	  FROM [dbo].[PersonSkill]
	  JOIN dbo.Person ON dbo.PersonSkill.PersonId = dbo.Person.Id
	  WHERE SkillId = @SkillId


	  
END

GO
/****** Object:  StoredProcedure [dbo].[Project_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[Project_Delete]
	@Id int


AS

/*

	DECLARE @Id int = 40
			
	SELECT *
	FROM dbo.Project
	WHERE Id = @Id

	EXECUTE dbo.Project_Delete

	SELECT *
	FROM dbo.Project
	WHERE Id = @Id

*/

BEGIN

	

	DELETE FROM dbo.Project
	WHERE Id = @Id;



END



GO
/****** Object:  StoredProcedure [dbo].[Project_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Project_Insert]

		@ProjectName nvarchar(50)
		,@CompanyId int =null
		,@Description nvarchar(3000)
		,@Budget decimal(18,4) = null
		,@Deadline date = null
		,@UserIdCreated nvarchar(128)
		,@Id int OUTPUT

/* ----- TEST CODE -----

DECLARE @Id int = 0;

	DECLARE @ProjectName nvarchar(50) = 'TestProject3'
		,@CompanyId int = 1
		,@Description nvarchar(3000) = 'TestDescription3'
		,@Budget decimal(18,4) = null
		,@Deadline date = null
		,@UserIdCreated nvarchar(128) = 'TestID333'

	EXECUTE dbo.Project_Insert	
								@ProjectName
								,@CompanyId
								,@Description
								,@Budget
								,@Deadline
								,@UserIdCreated
								,@Id OUTPUT

SELECT @Id

SELECT * 
FROM dbo.Project
WHERE Id = @Id;


*/
   

AS

BEGIN



INSERT INTO [dbo].[Project]
           ([ProjectName]
           ,[CompanyId]
           ,[Description]
           ,[Budget]
           ,[Deadline]
           ,[UserIdCreated])
     VALUES
           (@ProjectName
           ,@CompanyId
           ,@Description
           ,@Budget
           ,@Deadline
		   ,@UserIdCreated)

	SET @Id = SCOPE_IDENTITY()

	INSERT INTO ProjectPerson
		(ProjectId
		, PersonId
		, IsLeader
		, HourlyRate
		, StatusId
		, UserIdCreated)
	SELECT
		@Id
		, p.Id
		, 1
		, 30
		, 4
		, @UserIdCreated
		FROM Person p
		WHERE p.AspNetUserId = @UserIdCreated


		   

END



GO
/****** Object:  StoredProcedure [dbo].[Project_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Project_SelectAll]


AS

/*



EXECUTE dbo.Project_SelectAll


*/




BEGIN

	SELECT p.Id
		  , p.ProjectName
		  , p.Description
		  , p.Budget
		  , p.Deadline
		  , p.DateCreated
		  , p.DateModified
		  , p.ProjectStatusId
		  , ps.Status
		  , p.CompanyId		
		  , (SELECT SUM(i.TimeCardTotals) FROM Invoice i WHERE i.ProjectsId = p.Id) as AmountToDate  
	  FROM [dbo].[Project] p
		LEFT JOIN ProjectStatus ps
	  ON ps.Id = p.ProjectStatusId

	  SELECT  ProjectId
			, PersonId
			, IsLeader
			, StatusId
			, [Status]
			, dbo.Person.FirstName
			, dbo.Person.LastName
			, dbo.Person.PhoneNumber
			, dbo.Person.Email
		FROM dbo.ProjectPerson

		JOIN dbo.Person ON dbo.Person.Id=dbo.ProjectPerson.PersonId
		JOIN dbo.Project ON dbo.Project.Id=dbo.ProjectPerson.ProjectId
		JOIN ProjectPersonStatus pps ON ProjectPerson.StatusId = pps.Id


END



GO
/****** Object:  StoredProcedure [dbo].[Project_SelectByCompanyId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Project_SelectByCompanyId]
@companyId int
AS
/*

DECLARE @companyId INT = 51

EXECUTE dbo. Project_SelectByCompanyId
		@companyId


*/
BEGIN

SELECT p.Id, p.ProjectName
FROM Project p JOIN Company c
	ON c.Id = p.companyId 
	Where c.Id = @companyId

END

GO
/****** Object:  StoredProcedure [dbo].[Project_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[Project_SelectById]
	@Id int

AS

/*

DECLARE @Id int = 20;

EXECUTE dbo.Project_SelectById @Id


*/




BEGIN

	SELECT p.[Id]
		  ,[ProjectName]
		  ,[Description]
		  ,[Budget]
		  ,[Deadline]
		  ,[DateCreated]
		  ,[DateModified]
		  , p.ProjectStatusId
		  ,ps.Status
		  ,[CompanyId]
		  , (SELECT SUM(i.TimeCardTotals) FROM Invoice i WHERE i.ProjectsId = p.Id) as AmountToDate
		  ,p.TrelloBoardId
		  ,p.TrelloBoardUrl
	  FROM [dbo].[Project] p
		LEFT JOIN ProjectStatus ps
	  ON ps.Id = p.ProjectStatusId

	  WHERE p.Id = @Id

	  SELECT  ProjectId
			, PersonId
			, IsLeader
			, StatusId
			, [Status]
			, dbo.Person.FirstName
			, dbo.Person.LastName
			, dbo.Person.PhoneNumber
			, dbo.Person.Email
			, dbo.Person.PhotoKey
			, HourlyRate
		FROM dbo.ProjectPerson

		JOIN dbo.Person ON dbo.Person.Id=dbo.ProjectPerson.PersonId
		JOIN dbo.Project ON dbo.Project.Id=dbo.ProjectPerson.ProjectId
		JOIN ProjectPersonStatus pps ON ProjectPerson.StatusId = pps.Id

		WHERE dbo.Project.Id = @Id

END



GO
/****** Object:  StoredProcedure [dbo].[Project_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Project_Update]
		@ProjectName nvarchar(50)
		,@CompanyId int=null
		,@Description nvarchar(3000)
		,@Budget decimal(18,4) = null
		,@Deadline date = null
		,@UserIdCreated nvarchar(128)
		,@Id int
		,@TrelloBoardId nvarchar(30) = null
		,@TrelloBoardUrl nvarchar(150) = null
AS


/* ------ TEST CODE -------

DECLARE @Id int = 0;

	DECLARE @ProjectName nvarchar(50) = 'TestProject3'
		,@CompanyId int = 5
		,@Description nvarchar(3000) = 'TestDescription3'
		,@Budget decimal(18,4) = null
		,@Deadline date = null
		,@UserIdCreated nvarchar(128) = 'TestID333'
		,@TrelloBoardId nvarchar(30) = null
		,@TrelloBoardUrl nvarchar(150) = null

	EXECUTE dbo.Project_Update	
								@ProjectName
								,@CompanyId
								,@Description
								,@Budget
								,@Deadline
								,@UserIdCreated
								,@Id
								,@TrelloBoardId
								,@TrelloBoardUrl

SELECT @Id

SELECT * 
FROM dbo.Project
WHERE Id = @Id;



*/

BEGIN

	DECLARE @DateModified datetime2(7) = GETUTCDATE()
	IF @CompanyId = 0
	BEGIN
		SET @CompanyId = null
	END

	UPDATE [dbo].[Project]
	   SET [ProjectName] = @ProjectName
		  ,[CompanyId] = @CompanyId
		  ,[Description] = @Description
		  ,[Budget] = @Budget
		  ,[Deadline] = @Deadline
		  ,[DateModified] = @DateModified
		  ,[UserIdCreated] = @UserIdCreated
		  ,TrelloBoardId = @TrelloBoardId
		  ,TrelloBoardUrl = @TrelloBoardUrl
	 WHERE Id = @Id


END




GO
/****** Object:  StoredProcedure [dbo].[ProjectPerson_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[ProjectPerson_Delete]
	@ProjectId int
	,@PersonId int
AS



/* ------- TEST CODE ------

	DECLARE @ProjectId int = 4
			, @PersonId int = 202


	SELECT *
	FROM dbo.ProjectPerson
	WHERE ProjectId = @ProjectId
	AND PersonId = @PersonId

	EXECUTE dbo.ProjectPerson_Delete @ProjectId, @PersonId

	SELECT *
	FROM dbo.ProjectPerson
	WHERE ProjectId = @ProjectId
	AND PersonId = @PersonId




*/



BEGIN

	  DELETE FROM dbo.ProjectPerson
      WHERE ProjectId = @ProjectId
	  AND PersonId = @PersonId


END

GO
/****** Object:  StoredProcedure [dbo].[ProjectPerson_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[ProjectPerson_Insert]

		@ProjectId int
		, @PersonId int
		, @IsLeader bit
		, @StatusId int
		, @HourlyRate money
		, @UserIdCreated nvarchar(128)



AS
/* ----- TEST CODE -----

DECLARE	@ProjectId int = 4
		, @PersonId int = 229
		, @IsLeader bit = 0
		, @StatusId int = 4
		, @HourlyRate money = 35.00
		, @UserIdCreated nvarchar(128) = 1

EXECUTE dbo.ProjectPerson_Insert
		@ProjectId
		, @PersonId
		, @IsLeader
		, @StatusId
		, @HourlyRate
		, @UserIdCreated

SELECT *
FROM dbo.ProjectPerson


*/

BEGIN



INSERT INTO [dbo].[ProjectPerson]
           (ProjectId
           , PersonId
           , IsLeader
           , StatusId
		   , HourlyRate
		   , UserIdCreated)
     VALUES
           (@ProjectId
           , @PersonId
           , @IsLeader
           , @StatusId
		   , @HourlyRate
		   , @UserIdCreated)

		   
END

GO
/****** Object:  StoredProcedure [dbo].[ProjectPerson_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[ProjectPerson_Update]

	@ProjectId int
	, @PersonId int
	, @IsLeader bit
	, @StatusId int
	, @HourlyRate money
	, @UserIdCreated nvarchar(128)

AS

/* ----- TEST CODE ------

	DECLARE @ProjectId int = 4
			,@PersonId int = 201

	DECLARE @IsLeader bit = 0
			,@StatusId int = 1
			,@HourlyRate money = 25.50
			,@UserIdCreated nvarchar(128) = 2

	EXECUTE dbo.ProjectPerson_Update
			@ProjectId
			, @PersonId	
			, @IsLeader
			, @StatusId
			, @HourlyRate
			, @UserIdCreated


SELECT * 
FROM dbo.ProjectPerson
WHERE ProjectId = @ProjectId;


*/


BEGIN



UPDATE [dbo].[ProjectPerson]
   SET [IsLeader] = @IsLeader
      ,StatusId = @StatusId
	  ,[HourlyRate] = @HourlyRate
	  ,UserIdCreated = @UserIdCreated

 WHERE ProjectId = @ProjectId
	AND PersonId = @PersonId;




END


GO
/****** Object:  StoredProcedure [dbo].[ProjectPersonStatus_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ProjectPersonStatus_SelectAll]

AS

/*------ TEST CODE -------

	Execute ProjectPersonStatus_SelectAll

*/

BEGIN

	SELECT Id, [Status] 
	FROM dbo.ProjectPersonStatus
	ORDER BY Id

END

GO
/****** Object:  StoredProcedure [dbo].[Proposal_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Proposal_Delete]
	@Id int


AS

/*

	DECLARE @Id int = 1

	EXECUTE dbo.Proposal_Delete
	@Id
	SELECT *
	FROM dbo.Proposal
	WHERE Id = @Id

*/

BEGIN

	

	DELETE FROM dbo.Proposal
	WHERE Id = @Id;



END



GO
/****** Object:  StoredProcedure [dbo].[Proposal_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Proposal_Insert]

		 @Description nvarchar(4000)
		,@Budget int = null
		,@Deadline nvarchar(50) = null
		,@ProjectType nvarchar(50)
		,@FirstName nvarchar(150)
		,@LastName nvarchar(150)=null
		,@Company nvarchar(200)=null
		,@PhoneNumber varchar(24)
		,@Email nvarchar(128)	
		,@Notes	nvarchar(4000) = null
		,@Status int = 4
		,@Id int OUTPUT

/* ----- TEST CODE -----
DECLARE	@Id INT=0
		
EXEC	[dbo].[Proposal_Insert]
		@Description = N'Website to connect classmates',
		@Budget = '5000',
		@Deadline = '01/01/2018',
		@ProjectType = N'Website',
		@FirstName = N'Mark',
		@LastName = N'Zuckerburg',
		@Company = N'Facebook',
		@PhoneNumber = '4152125555',
		@Email = N'mark@mailinator.com',
		@Id = @Id OUTPUT

SELECT	@Id 

SELECT * 
FROM dbo.Proposal
WHERE Id = @Id;

*/
   

AS

BEGIN


INSERT INTO [dbo].[Proposal]
         (
           [Description]
           ,Budget
           ,Deadline
		   ,ProjectType
		   ,FirstName
		   ,LastName
		   ,Company
		   ,PhoneNumber
		   ,Email
		   ,Notes
		   ,[Status]
          )
     VALUES
       ( @Description 
		,@Budget 
		,@Deadline 
		,@ProjectType 
		,@FirstName 
		,@LastName 
		,@Company 
		,@PhoneNumber
		,@Email 
		,@Notes
		,@Status	
		)	

	SET @Id = SCOPE_IDENTITY()

END



GO
/****** Object:  StoredProcedure [dbo].[Proposal_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proposal_Search]
	
	 @Status int =NULL
	 ,@Name nvarchar(50)=NULL

AS
--EXEC Proposal_Search @Name = "Accepted"
BEGIN
	SELECT 
         
			p.Id
           ,[Description]
           ,Budget
           ,Deadline
		   ,ProjectType
		   ,FirstName
		   ,LastName
		   ,Company
		   ,PhoneNumber
		   ,Email
		   ,Notes
		   ,[Status]
		   ,psc.Name AS StatusName

        FROM  [dbo].[Proposal] p
			LEFT JOIN ProposalStatusCategory psc
			ON p.Status = psc.Id
							
		WHERE ((
			@Status IS NULL OR @Status = 0) OR p.Status = @Status) 
			AND (@Name IS NULL OR psc.Name = @Name)
			ORDER BY p.Id Desc
END



GO
/****** Object:  StoredProcedure [dbo].[Proposal_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Proposal_SelectAll]


		/* ----- TEST CODE -----
		
		EXEC dbo.Proposal_SelectAll
	

		*/
   

AS

BEGIN


SELECT 
         
			p.Id
           ,[Description]
           ,Budget
           ,Deadline
		   ,ProjectType
		   ,FirstName
		   ,LastName
		   ,Company
		   ,PhoneNumber
		   ,Email
		   ,Notes
		   ,[Status]
		   ,psc.Name AS StatusName

          
		  FROM  [dbo].[Proposal] p
		  LEFT JOIN ProposalStatusCategory psc
			ON p.Status = psc.Id

			ORDER BY p.Id Desc
	

END



GO
/****** Object:  StoredProcedure [dbo].[Proposal_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[Proposal_SelectById]

@Id int
		/* ----- TEST CODE -----

		DECLARE @Id int = 5;
		EXEC dbo.Proposal_SelectById
		@Id
	


		*/
   

AS

BEGIN


SELECT 
         
			p.Id
           ,[Description]
           ,Budget
           ,Deadline
		   ,ProjectType
		   ,FirstName
		   ,LastName
		   ,Company
		   ,PhoneNumber
		   ,Email
		   ,Notes
		   ,[Status]
           ,psc.Name AS StatusName
		  FROM  [dbo].[Proposal] p
		   JOIN ProposalStatusCategory psc
			ON p.Status = psc.Id

		  WHERE p.Id = @Id
	

END



GO
/****** Object:  StoredProcedure [dbo].[Proposal_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Proposal_Update]
		 @Id int
		,@Description nvarchar(4000)
		,@Budget int = null
		,@Deadline nvarchar(50) = null
		,@ProjectType nvarchar(50)
		,@FirstName nvarchar(150)
		,@LastName nvarchar(150)=null
		,@Company nvarchar(200)=null
		,@PhoneNumber varchar(24)
		,@Email nvarchar(128)
		,@Notes	nvarchar(4000)=null
		,@Status int =null	
		,@UserIdCreated nvarchar(128)
		,@ProjectId int OUTPUT
AS


/* ------ TEST CODE -------

DECLARE  @Id int =5
		,@Description nvarchar(4000) = 'TEst'
		,@Budget int =5500
		,@Deadline nvarchar(50) = '1/1/2018ish'
		,@ProjectType nvarchar(50)='Mobile App'
		,@FirstName nvarchar(150)='Lry'
		,@LastName nvarchar(150)='Ellison'
		,@Company nvarchar(200)='Oracle'
		,@PhoneNumber varchar(24)='5565555555'
		,@Email nvarchar(128)='larry@larry.com'
		,@Notes nvarchar(4000)='Client now wants to focus on his Regatta Racing'	
		,@Status int = 1	
		,@UserIdCreated nvarchar(128)= 'test'
		,@ProjectId int 




EXEC    [dbo].[Proposal_Update]
		@Id
		,@Description 
		,@Budget 
		,@Deadline 
		,@ProjectType 
		,@FirstName 
		,@LastName 
		,@Company 
		,@PhoneNumber
		,@Email
		,@Notes 	
		,@Status		
		,@UserIdCreated
		,@ProjectId OUTPUT
		
		
		SELECT *
		FROM dbo.Proposal
		WHERE Id = @Id

		SELECT *
		FROM dbo.Project



*/
	Declare @PriorStatus int
	

	SELECT         		
		 @PriorStatus=[Status]          
	FROM  [dbo].[Proposal] 		   
	WHERE Id = @Id


	UPDATE [dbo].Proposal 
	   SET  [Description]=@Description
           ,Budget=@Budget
           ,Deadline= @Deadline
		   ,ProjectType=@ProjectType
		   ,FirstName=@FirstName
		   ,LastName=@LastName
		   ,Company=@Company
		   ,PhoneNumber=@PhoneNumber
		   ,Email=@Email
		   ,Notes=@Notes
		   ,[Status]=@Status 
		WHERE Id = @Id

	 IF (@PriorStatus!=1 and @Status =1)
	 BEGIN

	 /*Declare @ProjectName nvarchar(50)
			,@ProposalId int */
			
	 		 
	 /*INSERT INTO [dbo].[Project] 
         (
           [Description]
           ,Budget
           ,Deadline
		   ,UserIdCreated
		   ,ProjectName
		   ,ProposalId 
		   )
	SELECT [Description]
           ,Budget
           ,TRY_PARSE(prop.Deadline AS datetime2(7)) AS Deadline
		   ,@UserIdCreated
		   ,CONCAT(prop.FirstName, ISNULL(prop.LastName, '')) AS ProjectName
		   ,prop.Id AS ProposalId    
	 FROM  [dbo].[Proposal] prop
	 WHERE prop.Id = @Id*/

	 DECLARE @ProjectDeadline datetime2(7)
			, @ProjectName nvarchar(50)
			

		SELECT @ProjectDeadline = TRY_PARSE(prop.Deadline AS datetime2(7))
				, @ProjectName = CONCAT(prop.FirstName, ISNULL(prop.LastName, ''))
				, @Description = Description
		FROM Proposal prop 
		WHERE Prop.Id = @Id
			
		EXEC Project_Insert
			@ProjectName = @ProjectName
			, @Description = @Description
			, @Budget = @Budget
			, @Deadline = @ProjectDeadline
			, @UserIdCreated = @UserIdCreated
			, @Id = @ProjectId OUTPUT


		 /*Select @ProjectId= SCOPE_IDENTITY()*/
	END




GO
/****** Object:  StoredProcedure [dbo].[ProposalStatusCategory_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[ProposalStatusCategory_Delete]
@Id int
			

AS

/* Test Code

DECLARE @Id INT = 3

SELECT *
FROM ProposalStatusCategory
WHERE Id = @Id

EXECUTE dbo.ProposalStatusCategory_Delete
		@Id 

SELECT *
FROM dbo.ProposalStatusCategory
WHERE Id = @Id

*/

BEGIN

DELETE
  FROM [dbo].ProposalStatusCategory
  WHERE Id=@Id



END





GO
/****** Object:  StoredProcedure [dbo].[ProposalStatusCategory_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ProposalStatusCategory_Insert]
	@Id int OUTPUT
	,@Name nvarchar(50)

	
AS
BEGIN
INSERT INTO [dbo].[ProposalStatusCategory]
           ([Id]
           ,[Name]
     )
     VALUES
           (@Id
           ,@Name
		   )
       
		   SET @Id = SCOPE_IDENTITY()
		   
		   /*
	DECLARE 
	@Name nvarchar(50) = Name
	, @Id int 

	EXEC ProposalStatusCategory_Insert
	@Name

	, @Id OUTPUT

	SELECT *
	FROM ProposalStatusCategory
	WHERE Id = @Id
	*/
END





GO
/****** Object:  StoredProcedure [dbo].[ProposalStatusCategory_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ProposalStatusCategory_SelectAll]
	
AS

/* Test Code



EXECUTE dbo. ProposalStatusCategory_SelectAll
		



*/
BEGIN

SELECT Id
      ,[Name]
     
    
  FROM [dbo].ProposalStatusCategory


END




GO
/****** Object:  StoredProcedure [dbo].[ProposalStatusCategory_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ProposalStatusCategory_SelectById]
			@Id INT

AS

		/* Test Code

		DECLARE @Id INT = 1

		EXECUTE dbo.ProposalStatusCategory_SelectById
				@Id

		*/

BEGIN
SELECT	 Id
		,[Name]
		
    
FROM [dbo].ProposalStatusCategory
WHERE Id = @Id

END






GO
/****** Object:  StoredProcedure [dbo].[ProposalStatusCategory_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProposalStatusCategory_Update]
	@Id int
	, @Name nvarchar(50)

AS
BEGIN
UPDATE [dbo].[ProposalStatusCategory]
   SET [Name] = @Name
   

  WHERE Id = @Id

 /*
		 Declare @Id int = 1
			,@Name nvarchar(128) = 'Accepted!'
	
	 

		EXEC ProposalStatusCategory_Update
			@Id
			,@Name
		

		SELECT * From ProposalStatusCategory
		Where Id = @Id
 */
END





GO
/****** Object:  StoredProcedure [dbo].[Rank_selectByBranch]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Exec Rank_selectByBranch 'Marine'
*/

CREATE PROCEDURE [dbo].[Rank_selectByBranch]
@branch nvarchar(20)
AS 
Begin
SELECT R.name AS Rank, R.Code, R.Grade, S.name As ServiceBranch
FROM [dbo].[ServiceBranch] As S
Join [dbo].[Rank] As R
ON 
S.id = R.ServiceBranchId
WHERE S.Name = @branch

End

GO
/****** Object:  StoredProcedure [dbo].[SecurityToken_GetByGuid]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SecurityToken_GetByGuid]
			@TokenGuid UNIQUEIDENTIFIER

AS

/* TEST CODE

DECLARE @TokenGuid UNIQUEIDENTIFIER = '48A6D169-7BA1-4055-B188-4A7A0E1D0CA0'

EXECUTE dbo.SecurityToken_GetByGuid
		@TokenGuid

*/

BEGIN

SELECT [TokenGuid]
      ,[TokenTypeId]
      ,[FirstName]
      ,[LastName]
	  ,[Email]
      ,[AspNetUserId]
      ,[DateCreated]
  FROM [dbo].[SecurityToken]
  WHERE TokenGuid = @TokenGuid


END




GO
/****** Object:  StoredProcedure [dbo].[SecurityToken_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SecurityToken_Insert]
			@TokenGuid UNIQUEIDENTIFIER OUTPUT
			,@TokenTypeId INT
			,@FirstName NVARCHAR(50)
			,@LastName NVARCHAR(50)
			,@Email NVARCHAR(256)
			,@AspNetUserId NVARCHAR(128)
			
AS

/* TEST CODE

DECLARE		@TokenGuid UNIQUEIDENTIFIER
			,@TokenTypeId INT
			,@FirstName NVARCHAR(50)
			,@LastName NVARCHAR(50)
			,@Email NVARCHAR(256)
			,@AspNetUserId NVARCHAR(128)

EXECUTE dbo.SecurityToken_Insert
			@TokenGuid OUTPUT
			,@TokenTypeId = 1
			,@FirstName = 'Dennis'
			,@LastName = 'Reynolds'
			,@Email = 'dennis@mailinator.com'
			,@AspNetUserId = 7

SELECT *
FROM dbo.SecurityToken
WHERE TokenGuid = @TokenGuid


*/

BEGIN

	SET @TokenGuid = NEWID()

	IF(@TokenTypeId = 2)
	BEGIN
		SELECT @AspNetUserId = Id
		FROM AspNetUsers
		WHERE Email = @Email
	END


	INSERT INTO [dbo].[SecurityToken]
			   ([TokenGuid]
			   ,[TokenTypeId]
			   ,[FirstName]
			   ,[LastName]
			   ,[Email]
			   ,[AspNetUserId])
		 VALUES
			   (@TokenGuid
			   ,@TokenTypeId
			   ,@FirstName
			   ,@LastName
			   ,@Email
			   ,@AspNetUserId)

		 
END




GO
/****** Object:  StoredProcedure [dbo].[ServiceBranch_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[ServiceBranch_Delete]
@Id int
AS
BEGIN
Delete ServiceBranch where Id = @Id
END




GO
/****** Object:  StoredProcedure [dbo].[ServiceBranch_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ServiceBranch_Insert]
@Code nvarchar(20), 
@Name nvarchar(50),
@Inactive bit,
@DisplayOrder int,
@UserIdCreated nvarchar(128),
@Id int Output

AS 
BEGIN

			/*  Exex ServiceBranch_Insert 
			*/

	INSERT INTO ServiceBranch(
	Code, 
	Name, 
	Inactive, 
	DisplayOrder, 
	UserIdCreated)
	VALUES(
	@Code, 
	@Name,
	@Inactive, 
	@DisplayOrder, 
	@UserIdCreated
	) 

	SELECT @Id = SCOPE_IDENTITY() 

END



GO
/****** Object:  StoredProcedure [dbo].[ServiceBranch_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ServiceBranch_SelectAll]
AS 

/*

EXEC ServiceBranch_SelectAll

*/


BEGIN
			SELECT Id
			, Code
			, Name
			, Inactive
			, DisplayOrder
			, DateCreated
			, DateModified
			, UserIdCreated
			FROM ServiceBranch
			ORDER BY Name

END



GO
/****** Object:  StoredProcedure [dbo].[ServiceBranch_SelectByID]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ServiceBranch_SelectByID]
@Id int
AS 
Begin
select Id, Code, Name, Inactive, DisplayOrder, DateCreated, DateModified, UserIdCreated
 from ServiceBranch where Id= @Id
End



GO
/****** Object:  StoredProcedure [dbo].[ServiceBranch_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ServiceBranch_Update]
@Id int,
@Code nvarchar(20), 
@Name nvarchar(50),
@Inactive bit,
@DisplayOrder int,
@UserIdCreated nvarchar(128)

AS 
BEGIN

	UPDATE ServiceBranch SET
		Code = @Code, 
		Name =@Name,
		Inactive = @Inactive,
		DisplayOrder = @DisplayOrder,
		DateModified = GetUTCDate(),
		UserIdCreated = @UserIdCreated
	WHERE Id = @Id

END



GO
/****** Object:  StoredProcedure [dbo].[Skill_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Skill_Delete]
@Id int
AS
BEGIN

DELETE FROM [dbo].[PersonSkill]
      WHERE SkillId = @Id

DELETE FROM [dbo].[Skill]
      WHERE Id = @Id

	  
	  /*
	  EXEC Skill_Delete 2
	  SELECT *
	  FROM Skill
	  */
END






GO
/****** Object:  StoredProcedure [dbo].[Skill_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Skill_Insert]
	@Name nvarchar(250)
	,@Code nvarchar(50) = NULL
	, @DisplayOrder int
	, @Id int OUTPUT
AS
BEGIN
INSERT INTO [dbo].[Skill]
            ([Name]
			,[Code]
           ,[DisplayOrder])
     VALUES
           (@Name
		   ,@Code
           ,@DisplayOrder)
	 SET @Id = SCOPE_IDENTITY()
	 /*
	DECLARE @Name nvarchar(250) = 'Javascript'
	, @DisplayOrder int = 10
	, @Id int

	EXEC Skill_Insert
	@Name
	,@Code
	, @DisplayOrder
	, @Id OUTPUT

	SELECT *
	FROM Skill
	WHERE Id = @Id
	*/
END






GO
/****** Object:  StoredProcedure [dbo].[Skill_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Skill_SelectAll]
AS
BEGIN
SELECT [Id]
      ,[Name]
	  ,[Code]
      ,[DisplayOrder]
  FROM [dbo].[Skill]
  --EXEC Skill_SelectAll
END






GO
/****** Object:  StoredProcedure [dbo].[Skill_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Skill_SelectById]
@Id int
AS
BEGIN
SELECT [Id]
      ,[Name]
	  ,[Code]
      ,[DisplayOrder]
  FROM [dbo].[Skill]
  WHERE Id = @Id
  --EXEC Skill_SelectById 1
END






GO
/****** Object:  StoredProcedure [dbo].[Skill_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Skill_Update]
	@Id int
	, @Name nvarchar(250)
	, @Code nvarchar(50) = NULL
	, @DisplayOrder int
AS
BEGIN
UPDATE [dbo].[Skill]
   SET [Name] = @Name
		,[Code] = @Code
		,[DisplayOrder] = @DisplayOrder
	  
 WHERE Id = @Id
  /*

 Declare @Id int = 1
	, @Name nvarchar(250) = 'C#'
	, @Code nvarchar(50) = C2
	, @DisplayOrder int = 10
	 

EXEC Skill_Update
		@Id
		, @Name
		, @Code
		, @DisplayOrder

		

select *
From Skill
Where Id = @Id
 */
END






GO
/****** Object:  StoredProcedure [dbo].[Squad_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Squad_Delete]

	@Id int

AS
BEGIN

	/*
		
	EXEC Squad_Delete 1

	SELECT *

	FROM Squad

	*/
	 DELETE FROM dbo.SquadSquadTag
	 WHERE SquadId = @id

	 EXEC SquadEvent_DeleteBySquad @Id

	 EXEC SquadMember_DeleteBySquad @Id

	 DELETE FROM   dbo.Squad
     WHERE Id = @Id 

END




GO
/****** Object:  StoredProcedure [dbo].[Squad_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Squad_Insert]
	
	@Name nvarchar (100)
	, @Mission nvarchar (1000)
	, @Notes nvarchar (1000) = null
	, @UserIdCreated nvarchar (128)
	, @squadTagIds dbo.IntIdTable READONLY
	, @Id int OUTPUT

AS

/*=========TEST========

	DECLARE @Id int = 0

	DECLARE 
		@Name nvarchar (100) = 'Alpha'
		, @Mission nvarchar (1000) = 'Travel'
		, @Notes nvarchar (1000) = null
		, @UserIdCreated nvarchar (128) = 12
		, @squadTagIds dbo.IntIdTable
		, @id int

INSERT @squadTagIds (data)
	VALUES(8)
INSERT @squadTagIds (data)
	VALUES(9)
			
EXEC dbo.Squad_Insert
			
		@Name
		, @Mission
		, @Notes
		, @UserIdCreated
		, @Id OUTPUT

	SELECT @Id

	SELECT *
	FROM dbo.Squad
	WHERE Id = @Id

*/

BEGIN

	INSERT INTO Squad
		(Name
		, Mission
		, Notes
		, UserIdCreated)
	VALUES
		(@Name
		, @Mission
		, @Notes
		, @UserIdCreated)

	SET @Id = SCOPE_IDENTITY() 

	INSERT INTO SquadMember
		 (SquadId
		, PersonId
		, UserIdCreated
		, MemberStatusId
		, IsLeader)
	SELECT
		@Id
		, p.Id
		, @UserIdCreated
		, 3
		, 1
		FROM Person p
		WHERE p.AspNetUserId = @UserIdCreated

	INSERT INTO [dbo].[SquadSquadTag]
				    ([SquadId],
					 [SquadTagId])
	SELECT @id AS SquadId, data AS SquadTagId
	FROM @SquadTagIds
		
	


END




GO
/****** Object:  StoredProcedure [dbo].[Squad_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Squad_Search]

    @SearchStr nvarchar(100) = ''
	

AS
BEGIN
/* test code
	

	EXEC Squad_Search '' 

*/
	
	
	SELECT Id
		, Name
		, Mission
		, Notes
	INTO #RESULT
	FROM Squad
	WHERE (Name LIKE '%' + @SearchStr + '%'
	or Mission like '%' + @SearchStr + '%')
	ORDER BY Name, Mission

	

	SELECT * FROM #RESULT ORDER BY Name, Mission

	
	SELECT se.Id
		, se.Name
		, se.DateCreated
		, se.DateModified
		, se.UserIdCreated
		, se.EventStart
		, se.EventEnd
		, se.Description
		, se.Location
		, se.SquadId
		, se.Color
		, se.Timezone
	, s.Name AS SquadName
	FROM SquadEvent se
		 JOIN #RESULT s
			ON se.SquadId = s.Id
	
	

	SELECT	sm.Id
		, sm.MemberStatusId
		, sm.SquadId
		, sm.PersonId
		, sm.LeaderComment
		, sm.DateCreated
		, sm.DateModified
		, p.FirstName
		, p.MiddleName
		, p.LastName
		, p.PhoneNumber
		, p.Email
	FROM SquadMember sm
		Join Person p
			on sm.PersonId = p.Id
		JOIN #RESULT s 
			on sm.SquadId = s.Id

    
END


GO
/****** Object:  StoredProcedure [dbo].[Squad_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Squad_SelectAll]
AS
BEGIN
/*

	EXEC Squad_SelectAll

*/

	SELECT Id
		, Name
		, Mission
		, Notes
	FROM Squad
	ORDER BY Name, Mission

	EXEC SquadEvent_SelectAll

	EXEC SquadMember_SelectAll

	EXEC SquadSquadTag_SelectAll



	
END




GO
/****** Object:  StoredProcedure [dbo].[Squad_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Squad_SelectById]

@Id int

AS
BEGIN
	/* Test procedure
	EXEC Squad_SelectById '18'

	EXECUTE dbo.SquadSquadTag_SelectBySquadTagId
			@SquadId
	*/

	SELECT Id, Name, Mission, Notes
	FROM Squad
	WHERE Id = @Id

	EXEC SquadEvent_SelectBySquadId @Id

	EXEC SquadMember_SelectBySquadId @Id

	EXEC SquadSquadTag_SelectBySquadId @Id

END 




GO
/****** Object:  StoredProcedure [dbo].[Squad_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Squad_Update]
	@Id int
	, @Name nvarchar (100)
	, @Mission nvarchar (1000) = null
	, @Notes nvarchar (1000) = null
	, @UserIdCreated nvarchar (128)
	,@squadTagIds dbo.IntIdTable READONLY
AS
/*
DECLARE @Id int = 18
		   ,@Name nvarchar (100) = 'James Bond 2'
		   ,@Mission nvarchar (1000) = 'undercover'
		   ,@Notes nvarchar (1000) = 'dont die'
		   ,@UserIdCreated nvarchar (128) = 12
		   ,@squadTagIds dbo.IntIdTable 
		   			
    EXEC dbo.Squad_Update
					@Id		
				   ,@Name
				   ,@Mission
				   ,@Notes
				   ,@UserIdCreated
				   ,@squadTagIds
				   
	
	SELECT *
	FROM dbo.SquadSquadTag
	WHERE SquadId = @id

	SELECT *
	FROM dbo.Squad
	WHERE Id = @Id

*/
BEGIN

	UPDATE dbo.Squad
		 SET Name = @Name
		, Mission = @Mission
		, Notes = @Notes
		, UserIdCreated = @UserIdCreated
		, DateModified = GETUTCDATE ()
		WHERE Id = @Id

		DELETE FROM dbo.SquadSquadTag
		WHERE SquadId = @Id

		INSERT INTO dbo.SquadSquadTag
					(SquadId,
					SquadTagId)
		SELECT @id AS SquadId, data AS SquadTagId
		FROM @squadTagIds
	

END




GO
/****** Object:  StoredProcedure [dbo].[SquadEvent_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SquadEvent_Delete] 
	-- Add the parameters for the stored procedure here
	@Id int
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	DELETE FROM SquadEvent WHERE Id = @Id

	--Test procedure here
	/*

	 EXEC SquadEvent_Delete 5
	
	 */ 
END




GO
/****** Object:  StoredProcedure [dbo].[SquadEvent_DeleteBySquad]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SquadEvent_DeleteBySquad] 
	-- Add the parameters for the stored procedure here
	@Id int
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	DELETE FROM SquadEvent WHERE SquadId = @Id

	--Test procedure here
	/*

	 EXEC SquadEvent_Delete 5
	
	 */ 
END




GO
/****** Object:  StoredProcedure [dbo].[SquadEvent_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SquadEvent_Insert] 
	-- Add the parameters for the stored procedure here
	@Name nvarchar(50)
	, @UserIdCreated nvarchar(128) 
	, @EventStart datetime2(7)
	, @EventEnd datetime2(7)
	, @Description nvarchar(500)=null
	, @Location nvarchar(50)=null
	, @SquadId int
	, @Color nvarchar(20)
	, @Timezone nvarchar(50)
	, @Id int OUTPUT
	
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	INSERT INTO SquadEvent 
	(Name
	, UserIdCreated
	, EventStart
	, EventEnd
	, Description
	, Location
	, SquadId
	, Color
	, Timezone)
	VALUES 
	(@Name
	, @UserIdCreated
	, @EventStart
	, @EventEnd
	, @Description
	, @Location
	, @SquadId
	, @Color
	, @Timezone)
	SET @Id = SCOPE_IDENTITY()
	--Test procedure here
	/*
	 DECLARE @NewId int 
	 EXEC SquadEvent_Insert 'Test Event Insert'
	 , 'SQL Created'
	 , [2017-05-01 12:59:59]
	 , [2017-05-01 13:30:30]
	 , 'Test Event Description'
	 , 'Test Event Location'
	 , 100
	 , '#00acac'
	 , 'some timezone'
	 , @Id = @NewId OUTPUT 
	 SELECT @NewId AS NewEventId
	 */ 
END




GO
/****** Object:  StoredProcedure [dbo].[SquadEvent_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SquadEvent_Search]

	@SearchStr nvarchar(100) = ''
	, @CurrentPage int = 1
	, @ItemsPerPage int = 5
	, @SquadId int = 0

AS
BEGIN

	/* test code

	EXEC SquadEvent_Search @CurrentPage = 5

	EXEC SquadEvent_Search @ItemsPerPage = 1000

	EXEC SquadEvent_Search ''

	*/
		IF @SearchStr = '' AND @SquadId > 0
			EXEC SquadEvent_SelectBySquadId @SquadId
		ELSE

	SELECT Id
		, Name
		, DateCreated
		, DateModified
		, UserIdCreated
		, EventStart
		, EventEnd
		, Description
		, Location
		, SquadId
		, Color
		, Timezone
		, COUNT(*) OVER () TotalRows
	INTO #RESULT
	FROM SquadEvent
	WHERE (Name LIKE '%' + @SearchStr + '%'
	OR Location LIKE '%' + @SearchStr + '%')
	ORDER BY EventStart, Name, Location
	OFFSET @ItemsPerPage * (@CurrentPage - 1) ROWS
	FETCH NEXT @ItemsPerPage ROWS ONLY

	SELECT * FROM #RESULT ORDER BY EventStart, Name, Location

END

GO
/****** Object:  StoredProcedure [dbo].[SquadEvent_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SquadEvent_SelectAll] 
	-- Add the parameters for the stored procedure here
	
	AS
BEGIN
	/*

	 EXEC SquadEvent_SelectAll 
	
	 */ 

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	SELECT Id
	, Name
	, DateCreated
	, DateModified
	, UserIdCreated
	, EventStart
	, EventEnd
	, Description
	, Location
	, SquadId
	, Color
	, Timezone
	FROM SquadEvent
	ORDER BY EventStart DESC
	--Test procedure here
	
END




GO
/****** Object:  StoredProcedure [dbo].[SquadEvent_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SquadEvent_SelectById] 
	-- Add the parameters for the stored procedure here
	@Id int
	AS
BEGIN
	--Test procedure here
	/*

	 EXEC SquadEvent_SelectById 28
	
	 */ 

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	DECLARE @SquadId int = (SELECT se.SquadId FROM SquadEvent se WHERE se.Id = @Id)

	SELECT Id
	, se.Name
	, se.DateCreated
	, se.DateModified
	, se.UserIdCreated
	, se.EventStart
	, se.EventEnd
	, se.Description
	, se.Location
	, se.SquadId
	, se.Color
	, se.Timezone
	
	FROM SquadEvent se WHERE Id = @Id
	


END




GO
/****** Object:  StoredProcedure [dbo].[SquadEvent_SelectBySquadId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SquadEvent_SelectBySquadId]

@SquadId int

AS
BEGIN
	/*
		 DECLARE @SquadId int = 23
		 EXEC SquadEvent_SelectBySquadId @SquadId
	*/
	SELECT Id AS EventId
		, Name
		, DateCreated
		, DateModified
		, UserIdCreated
		, EventStart
		, EventEnd
		, Description
		, Location
		, SquadId
		, Color
		, Timezone
	FROM SquadEvent
	WHERE SquadId = @SquadId
END 

GO
/****** Object:  StoredProcedure [dbo].[SquadEvent_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SquadEvent_Update] 
	-- Add the parameters for the stored procedure here
	@Id int
	, @Name nvarchar(50)
	, @EventStart datetime2(7)
	, @EventEnd datetime2(7)
	, @Description nvarchar(50)
	, @Location nvarchar(50)
	, @Color nvarchar(20)
	, @Timezone nvarchar(50)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	DECLARE @DateModified datetime2(7) = SYSDATETIME()

	IF EXISTS(SELECT Id FROM SquadEvent WHERE Id=@Id)
		BEGIN
			UPDATE SquadEvent
				SET
					Name = @Name
					, EventStart = @EventStart
					, EventEnd = @EventEnd
					, Description = @Description
					, Location = @Location
					, Color = @Color
					, Timezone = @Timezone
					, DateModified = @DateModified
				WHERE Id=@Id
		END
	ELSE
		BEGIN
			SELECT 'This event does not exist.'
		END


	--Test procedure here
	/*

	 EXEC SquadEvent_Update 36
	 , 'Updated Title'
	 , [2017-05-02 15:15:30]
	 , [2017-05-03 23:59:59]
	 , 'some updated description'
	 , 'some updated location'
	 , '#7B241C'
	 , 'some updated timezone'

	 EXEC SquadEvent_SelectById 36
	
	 */ 
END




GO
/****** Object:  StoredProcedure [dbo].[SquadMember_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[SquadMember_Delete]

@Id int

AS

/*------TEST CODE

		DECLARE @Id int = 3

		SELECT *
		FROM dbo.SquadMember
		WHERE id = @id;

		EXECUTE dbo.SquadMember_Delete @Id

		SELECT * 
		FROM dbo.SquadMember
		WHERE Id =  @id;

		*/

BEGIN

	DELETE
	FROM dbo.SquadMember
	WHERE Id = @Id

END


GO
/****** Object:  StoredProcedure [dbo].[SquadMember_DeleteBySquad]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[SquadMember_DeleteBySquad]

@Id int

AS

/*------TEST CODE

		DECLARE @Id int = 3

		SELECT *
		FROM dbo.SquadMember
		WHERE id = @id;

		EXECUTE dbo.SquadMember_Delete @Id

		SELECT * 
		FROM dbo.SquadMember
		WHERE Id =  @id;

		*/

BEGIN

	DELETE
	FROM dbo.SquadMember
	WHERE SquadId = @Id

END


GO
/****** Object:  StoredProcedure [dbo].[SquadMember_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SquadMember_Insert]

		
		
		@SquadId int
		,@PersonId int
		,@LeaderComment nvarchar(250) = null
		,@UserIdCreated nvarchar(250)
		,@MemberStatusId int
		,@IsLeader bit = 0
		,@Id int OUTPUT

/* ------TEST CODE--------

	DECLARE @Id int = 0

	DECLARE 
			@SquadId int = 18
			,@PersonId int = 206
			,@LeaderComment nvarchar(250) = 'Excellent Recruit'
			,@UserIdCreated nvarchar(250) = 112
			,@MemberStatusId int = 1
			,@IsLeader bit = 0

			
EXEC dbo.SquadMember_Insert
			
			@SquadId
			,@PersonId
			,@LeaderComment
			,@UserIdCreated 
			,@MemberStatusId
			,@IsLeader
			,@Id OUTPUT

	SELECT @Id

	SELECT *
	FROM dbo.SquadMember
	WHERE Id = @Id
		
*/

AS

BEGIN

INSERT INTO [dbo].[SquadMember]
           
			([SquadId]
           ,[PersonId]
           ,[LeaderComment]
		   ,UserIdCreated
		   ,[MemberStatusId]
		   ,IsLeader)
		   
     VALUES
			(@SquadId
			,@PersonId
			,@LeaderComment
			,@UserIdCreated
			,@MemberStatusId
			,@IsLeader)
			
        SET @Id = SCOPE_IDENTITY()

END

--SELECT * FROM SquadMember

--SELECT * FROM Person

GO
/****** Object:  StoredProcedure [dbo].[SquadMember_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[SquadMember_SelectAll]

AS

/*-----TEST CODE-------

		EXECUTE dbo.SquadMember_SelectAll

		SELECT * 
		FROM dbo.SquadMember

*/

BEGIN

	SELECT	sm.Id AS SquadMemberId
		, sm.SquadId
		, sm.PersonId AS PersonalId
		, sm.LeaderComment
		, sm.DateCreated
		, sm.DateModified
		, sms.Id AS StatusId
		, sms.Name AS StatusName
		, p.FirstName
		, p.MiddleName
		, p.LastName
		, p.PhoneNumber
		, p.Email
		, p.PhotoKey
		, sm.IsLeader
		
	FROM SquadMember sm
		Join Person p
		on sm.PersonId = p.Id
		Join SquadMemberStatus sms
		on sm.MemberStatusId = sms.Id
	
END


GO
/****** Object:  StoredProcedure [dbo].[SquadMember_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[SquadMember_SelectById]

@Id int

AS

/*-----TEST CODE-------

DECLARE @id int = 14

EXECUTE dbo.SquadMember_SelectById @id

*/

BEGIN

	SELECT	sm.Id AS SquadMemberId
		, sm.SquadId
		, sm.PersonId AS PersonalId
		, sm.LeaderComment
		, sm.DateCreated
		, sm.DateModified
		, sms.Id AS StatusId
		, sms.Name AS Status
		, p.FirstName
		, p.MiddleName
		, p.LastName
		, p.PhoneNumber
		, p.Email
		, p.PhotoKey
		, sm.IsLeader
		
	FROM SquadMember sm
		Join Person p
			on sm.PersonId = p.Id
		Join SquadMemberStatus sms
			on sm.MemberStatusId = sms.Id
	WHERE sm.Id = @Id

END


GO
/****** Object:  StoredProcedure [dbo].[SquadMember_SelectBySquadId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SquadMember_SelectBySquadId] 

@Id int

AS

/*-----TEST CODE-------

		DECLARE @id int = 21
		EXEC SquadMember_SelectBySquadId 21

*/

BEGIN

	SELECT	sm.Id AS SquadMemberId
		, sm.SquadId
		, sm.PersonId
		, sm.LeaderComment
		, sm.DateCreated
		, sm.DateModified
		, sms.Id AS StatusId
		, sms.Name AS StatusName
		, p.FirstName
		, p.MiddleName
		, p.LastName
		, p.PhoneNumber
		, p.Email
		, p.PhotoKey
		, sm.IsLeader
	
	FROM SquadMember sm
		Join Person p
		on sm.PersonId = p.Id
		Join SquadMemberStatus sms
		on sm.MemberStatusId = sms.Id
	WHERE sm.SquadId = @Id
		
END



GO
/****** Object:  StoredProcedure [dbo].[SquadMember_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[SquadMember_Update]

		@SquadId int
		,@PersonId int
		,@LeaderComment nvarchar(250) = null
		,@UserIdCreated nvarchar(250)
		,@MemberStatusId int
		,@IsLeader bit = 0
		,@Id int --SquadMemberId
		

AS

/*

DECLARE @Id int = 3

	DECLARE @Id int = 0

	DECLARE 
			@SquadId int = 18
			,@PersonId int = 164
			,@LeaderComment nvarchar(250) = 'Excellent Recruit'
			,@UserIdCreated nvarchar(250) = 1
			,@MemberStatusId int = 1
			,@IsLeader bit = 0

			
EXEC dbo.SquadMember_Update
			
			@SquadId
			,@PersonId
			,@LeaderComment
			,@UserIdCreated 
			,@MemberStatusId
			,@IsLeader
			,@Id OUTPUT

	SELECT @Id

	SELECT *
	FROM dbo.SquadMember
	WHERE Id = @Id

*/



BEGIN

	DECLARE @dateNow datetime2 = GETUTCDATE();

	UPDATE dbo.SquadMember
	SET
			SquadId = @SquadId
			,PersonId = @PersonId
			,LeaderComment = @LeaderComment
			,UserIdCreated = @UserIdCreated
			,MemberStatusId = @MemberStatusId
			,IsLeader = @IsLeader
	WHERE Id = @Id

END


GO
/****** Object:  StoredProcedure [dbo].[SquadMemberEvent_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SquadMemberEvent_SelectAll]
	@userId nvarchar(128)

AS

/* --- TEST CODE ---

	EXEC dbo.SquadMemberEvent_SelectAll
		'6bfd9970-2e37-4809-a5fa-25cf7e366802'

	SELECT *
	FROM dbo.SquadEvent

*/

BEGIN

	SELECT 
		P.Id PersonId
		, SM.SquadId
		, SE.Id SquadEventId
		, SE.Name SquadEventName
		, SE.EventStart SquadEventStart
		, SE.EventEnd SquadEventEnd
		, SE.Description SquadEventDescription
		, SE.Location SquadEventLocation
	FROM Person P
		JOIN SquadMember SM
			ON P.Id = SM.PersonId
		JOIN SquadEvent SE
			ON SM.SquadId = SE.SquadId
	WHERE P.AspNetUserId = @userId
		AND SE.EventStart BETWEEN DATEADD(m, -6, GETDATE()) 
		AND DATEADD(m, 6, GETDATE())

END




GO
/****** Object:  StoredProcedure [dbo].[SquadMemberStatus_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SquadMemberStatus_SelectAll]

AS

/*---TEST CODE---

	Execute SquadMemberStatus_SelectAll

*/

BEGIN

	SELECT Id, Name 
	FROM SquadMemberStatus
	ORDER BY Id

END

GO
/****** Object:  StoredProcedure [dbo].[SquadSquadTag_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SquadSquadTag_Delete]
			@SquadId int
			,@SquadTagId int

AS
/*
DECLARE @SquadId int = 8
		,@SquadTagId int = 10
SELECT * 
FROM dbo.SquadSquadTag
WHERE SquadId = @squadId AND SquadTagId = @squadTagId

EXECUTE dbo.SquadSquadTag_Delete
		@SquadId
		,@SquadTagId
SELECT * 
FROM dbo.SquadSquadTag
WHERE SquadId = @squadId AND SquadTagId = @squadTagId

*/
BEGIN
		DELETE FROM dbo.SquadSquadTag
		WHERE SquadId = @squadId AND SquadTagId = @squadTagId
END

GO
/****** Object:  StoredProcedure [dbo].[SquadSquadTag_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[SquadSquadTag_Insert]
			@squadId int,
			@squadTagId int

AS
/* Test Code

DECLARE @squadId int = 18,
		@squadTagId int = 1
EXECUTE dbo.SquadSquadTag_Insert
		@squadId,
		@squadTagId

Select * FROM dbo.SquadSquadTag
 */
BEGIN
		INSERT INTO dbo.SquadSquadTag
					(squadId,
					 squadTagId)			
			VALUES
					(@squadId
					,@squadTagId)
END

GO
/****** Object:  StoredProcedure [dbo].[SquadSquadTag_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SquadSquadTag_SelectAll]
			
AS
--TestCode
/*
 Select * From SquadSquadTag
 Select * From SquadTag
 Select * From Squad
*/

BEGIN
		SELECT sst.SquadId,
		       sst.SquadTagId,
		       st.Keyword,
			   st.DisplayOrder,
			   st.Inactive
		FROM SquadSquadTag sst
		JOIN SquadTag st
		ON sst.SquadTagId = st.Id
END

GO
/****** Object:  StoredProcedure [dbo].[SquadSquadTag_SelectBySquadId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SquadSquadTag_SelectBySquadId]
			@SquadId int
AS
/*
DECLARE @SquadId int = 10
EXECUTE dbo.SquadSquadTag_SelectBySquadTagId
			@SquadId

select * from Squad s
inner join SquadSquadTag sst on sst.SquadId=s.Id
inner join SquadTag st on st.Id=sst.SquadTagId
*/

BEGIN
		SELECT sst.SquadId,
		    sst.SquadTagId,
		    st.Keyword,
			st.DisplayOrder,
			st.Inactive
		FROM SquadSquadTag sst
		JOIN SquadTag st
		ON sst.SquadTagId = st.Id
		WHERE sst.SquadId = @SquadId

END

GO
/****** Object:  StoredProcedure [dbo].[SquadSquadTag_SelectBySquadTagId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SquadSquadTag_SelectBySquadTagId]
			@SquadTagId int
AS
/*
DECLARE @SquadTagId int = 10
EXECUTE dbo.SquadSquadTag_SelectBySquadTagId
			@SquadTagId

select * from Squad s
inner join SquadSquadTag sst on sst.SquadId=s.Id
inner join SquadTag st on st.Id=sst.SquadTagId
*/
BEGIN
		SELECT [SquadId]
			,dbo.Squad.Name
			,dbo.Squad.Mission
			,dbo.Squad.Notes
			,dbo.Squad.UserIdCreated

		FROM dbo.SquadSquadTag
		JOIN dbo.Squad ON dbo.SquadSquadTag.SquadId = dbo.Squad.Id
		WHERE SquadTagId = @squadTagId
		
END

GO
/****** Object:  StoredProcedure [dbo].[SquadTag_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SquadTag_Delete]
@Id int
AS
BEGIN
DELETE FROM [dbo].[SquadTag]
      WHERE Id = @Id
/*
EXEC SquadTag_Delete 1
SELECT *
FROM SquadTag
*/
END






GO
/****** Object:  StoredProcedure [dbo].[SquadTag_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SquadTag_Insert]
	@Keyword nvarchar(128)
	, @DisplayOrder int
	, @Id int OUTPUT
AS
BEGIN
INSERT INTO [dbo].[SquadTag]
           (Keyword
		   , DisplayOrder)
     VALUES
           (@Keyword
           ,@DisplayOrder)
	SET @Id = SCOPE_IDENTITY()

	/*
	DECLARE @Keyword nvarchar(128) = 'test'
	, @DisplayOrder int = 10
	, @Id int

	EXEC SquadTag_Insert
	@Keyword
	, @DisplayOrder
	, @Id OUTPUT

	SELECT *
	FROM SquadTag
	WHERE Id = @Id
	*/
END






GO
/****** Object:  StoredProcedure [dbo].[SquadTag_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SquadTag_SelectAll]
AS
BEGIN
  /* --Test procedure here--

  --EXEC SquadTag_SelectAll

  */

	SELECT Id
      ,Keyword
      ,DisplayOrder
  FROM SquadTag
  ORDER BY Keyword

END






GO
/****** Object:  StoredProcedure [dbo].[SquadTag_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SquadTag_SelectById]
@Id int
AS
BEGIN
SELECT [Id]
      ,Keyword
      ,DisplayOrder

  FROM [dbo].[SquadTag]
  WHERE Id = @Id
  --EXEC SquadTag_SelectById 1
END






GO
/****** Object:  StoredProcedure [dbo].[SquadTag_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SquadTag_Update]
	@Id int
	, @Keyword nvarchar(128)
	, @DisplayOrder int
AS
BEGIN
UPDATE [dbo].[SquadTag]
   SET [Keyword] = @Keyword
      ,[DisplayOrder] = @DisplayOrder

 WHERE Id = @Id
 /*

 Declare @Id int = 1
	, @Keyword nvarchar(128) = 'jim'
	, @DisplayOrder int = 10
	 

EXEC SquadTag_Update
		@Id
		, @Keyword
		, @DisplayOrder

		

select *
From SquadTag
Where Id = @Id
 */
END






GO
/****** Object:  StoredProcedure [dbo].[StateProvince_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[StateProvince_SelectAll]

AS

/* TEST CODE

EXECUTE dbo.StateProvince_SelectAll

*/

BEGIN

SELECT [Id]
      ,[CountryId]
      ,[StateProvinceCode]
      ,[CountryRegionCode]
      ,[IsOnlyStateProvinceFlag]
      ,[Name]
      ,[TerritoryID]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [dbo].[StateProvince]


  END






GO
/****** Object:  StoredProcedure [dbo].[StateProvince_SelectByCountryId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[StateProvince_SelectByCountryId]
			@CountryId INT

AS

/* TEST CODE

DECLARE @CountryId INT = 247

EXECUTE dbo.StateProvince_SelectByCountryId
		@CountryId

*/

BEGIN

SELECT [Id]
      ,[CountryId]
      ,[StateProvinceCode]
      ,[CountryRegionCode]
      ,[IsOnlyStateProvinceFlag]
      ,[Name]
      ,[TerritoryID]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [dbo].[StateProvince]
  WHERE CountryId = @CountryId


  END






GO
/****** Object:  StoredProcedure [dbo].[TestEmployees_Select]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[TestEmployees_Select]
AS
BEGIN
/*

	EXEC dbo.TestEmployees_Select

*/

	SELECT	EmployeeID
      ,LastName
      ,FirstName
      ,Title
      ,BirthDate
      ,Status
	FROM dbo.TestEmployees 


END





GO
/****** Object:  StoredProcedure [dbo].[TestEmployees_SelectByIds]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/

CREATE proc [dbo].[TestEmployees_SelectByIds]

@EmployeeIds dbo.IntIdTable READONLY

/*

	DECLARE @EmployeeIds dbo.IntIdTable 

	INSERT into @EmployeeIds (Data)
		Values(1),(2)

	EXECUTE  dbo.TestEmployees_SelectByIds  @EmployeeIds


*/
as
BEGIN

	SELECT	
		EmployeeID
		,LastName
		,FirstName
		,Title    
		,BirthDate
		,Status
	FROM 
		dbo.TestEmployees e 
		inner join @EmployeeIds tbl
			on tbl.Data = e.EmployeeID


  END








GO
/****** Object:  StoredProcedure [dbo].[Testimonial_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Testimonial_Delete]
@Id int

AS
BEGIN
	/*

	EXEC Testimonial_Delete 1

	SELECT *
	FROM Testimonial

	*/
	DELETE FROM Testimonial
	WHERE Id = @Id
END





GO
/****** Object:  StoredProcedure [dbo].[Testimonial_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Testimonial_Insert]
	  @Testimonial nvarchar(MAX)	
	, @PersonId int
	, @Id int OUTPUT 
	
AS

BEGIN

/*

	DECLARE @Testimonial nvarchar(MAX) = 'failed again'
			, @UserIdCreated nvarchar(128) = 'no'	
			, @Id int
		

	EXEC Testimonial_Insert
	      @Testimonial
		, @UserIdCreated
		, @Id OUTPUT

		
	SELECT *
	FROM Testimonial
	WHERE Id = @Id

*/
	SET NOCOUNT ON;

    

	INSERT INTO Testimonial
		 (Testimonial
		 , PersonId)
	VALUES
		(@Testimonial
		, @PersonId)
  		
	SET @Id = SCOPE_IDENTITY()


END




GO
/****** Object:  StoredProcedure [dbo].[Testimonial_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Testimonial_Search] 	
	@Inactive bit NULL
AS
BEGIN	

/* Test Code

EXEC Testimonial_Search @Inactive=1


*/
	SET NOCOUNT ON;
    SELECT Testimonial.Id
		, Testimonial
		, Testimonial.DateCreated
		, Testimonial.DateModified
		, Person.Id AS PersonId
		, Person.FirstName
		, Person.MiddleName
		, Person.LastName
		, Person.PhoneNumber
		, Person.Email
		, Person.JobTitle
		,Person.PhotoKey
		,Testimonial.Inactive
	FROM Testimonial
	JOIN dbo.Person ON dbo.Testimonial.PersonId = dbo.Person.Id
	WHERE ((
	
	@Inactive IS NULL AND Testimonial.Inactive IS NULL) OR Testimonial.Inactive = @Inactive) 
	
END




GO
/****** Object:  StoredProcedure [dbo].[Testimonial_SelectAll]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Testimonial_SelectAll] 	
AS
BEGIN	

/*

EXEC Testimonial_SelectAll

*/
	SET NOCOUNT ON;

    SELECT Testimonial.Id
		, Testimonial
		, Testimonial.DateCreated
		, Testimonial.DateModified
		, Person.Id AS PersonId
		, Person.FirstName
		, Person.MiddleName
		, Person.LastName
		, Person.PhoneNumber
		, Person.Email
		, Person.JobTitle
		,Person.PhotoKey
		,Testimonial.Inactive

	FROM Testimonial
	JOIN dbo.Person ON dbo.Testimonial.PersonId = dbo.Person.Id



	
END




GO
/****** Object:  StoredProcedure [dbo].[Testimonial_SelectById]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Testimonial_SelectById] 
	@Id int	
AS
BEGIN
	/*
	EXEC Testimonial_SelectById
	@Id = 80
	*/	
	SET NOCOUNT ON;

    SELECT Testimonial.Id
		, Testimonial
		, Testimonial.DateCreated
		, Testimonial.DateModified
		, Person.Id
		, Person.FirstName
		, Person.MiddleName
		, Person.LastName
		, Person.PhoneNumber
		, Person.Email
		, Person.JobTitle
		, Person.PhotoKey
		, Testimonial.Inactive
	FROM Testimonial
	JOIN dbo.Person ON dbo.Testimonial.PersonId = dbo.Person.Id
	WHERE Testimonial.Id = @Id

END




GO
/****** Object:  StoredProcedure [dbo].[Testimonial_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Testimonial_Update]
	@Id int
	,@Inactive bit
	,@Testimonial nvarchar(MAX)
	
AS
BEGIN
	SET NOCOUNT ON;
	 /*

 Declare @Id int = 78
	, @Testimonial nvarchar(MAX) = 'no'
	 

EXEC Testimonial_Update
		@Id
		, @Testimonial

select *
From dbo.Testimonial
Where Id = @Id

 */
	UPDATE Testimonial
	   SET Inactive=@Inactive
	    ,Testimonial = @Testimonial			
		,DateModified = GETUTCDATE()

	 WHERE Id = @Id

END






GO
/****** Object:  StoredProcedure [dbo].[TestTable_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE proc [dbo].[TestTable_Insert]
		@FirstName nvarchar(50) 
		,@Last nvarchar(50) 
		,@Age nvarchar(50) 
		, @Email nvarchar(50) 
		, @Uid uniqueidentifier output

as

/*

Declare @FirstName nvarchar(50) = 'Sally'
		,@Last nvarchar(50) = 'Smith'
		,@Age nvarchar(50) = 87
		, @Email nvarchar(50) = 'sally.smith@mailinator.com'
		, @Uid uniqueidentifier

execute dbo.TestTable_Insert 
		@FirstName  
		,@Last 
		,@Age
		,@Email  
		,@Uid output

select *
From [dbo].[TestTableOne]
Where UID = @Uid

*/

BEGIN





SET @Uid = NewID()

INSERT INTO [dbo].[TestTableOne]
           ([FirstName]
		   , LastName
		   , Age
		   , Email
           ,[UId])
     VALUES
           (@FirstName
		   ,@Last
		   ,@Age
		   , @Email
		   , @Uid)


END

		   --select * from dbo.TestTableOne











GO
/****** Object:  StoredProcedure [dbo].[TestTable_Select]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE proc [dbo].[TestTable_Select]

as


BEGIN


Select Top 50
	t.FirstName 
		,t.LastName
		, t.Age
		
From dbo.TestTableOne t
Order by newid() -- this order by clause will essentially randomize which top 50 get returned

END







GO
/****** Object:  StoredProcedure [dbo].[TestTable_Structured]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create proc [dbo].[TestTable_Structured]
 @ParamName [dbo].[UniqueIdTable] READONLY
as
/*
Declare @ParamName [dbo].[UniqueIdTable]

Insert into @ParamName
			   ([Data]
			   )
		 VALUES
	 
			   ('b5706334-2dad-472c-b59a-676fed1a5eb8'
			   )
 

 execute dbo.TestTable_Structured @ParamName

*/

BEGIN








Select v.FirstName , v.Age
From dbo.TestTableOne v inner join @ParamName t on v.UId = t.Data

END








GO
/****** Object:  StoredProcedure [dbo].[TimecardEntry_Delete]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TimecardEntry_Delete]
	@Id int
AS
/* TEST CODE

	SELECT * 
	FROM TimecardEntry
	WHERE Id = @Id

	EXEC TimecardEntry_Delete 1

	SELECT * 
	FROM TimecardEntry
	WHERE Id = @Id

*/
BEGIN
	DELETE FROM TimecardEntry
	WHERE Id = @Id
END



GO
/****** Object:  StoredProcedure [dbo].[TimecardEntry_Insert]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TimecardEntry_Insert]
	@ProjectId int
	, @PersonId int
	, @TimecardStatusId int = 1
	, @InvoiceId int = NULL
	, @StartDateTimeUtc datetime2(7) = NULL
	, @StartDateTimeLocal datetime2(7) = NULL
	, @EndDateTimeUtc datetime2(7) = NULL
	, @EndDateTimeLocal datetime2(7) = NULL
	, @Id int OUTPUT

AS
/* TEST CODE

	DECLARE @ProjectId int = 4
	, @PersonId int = 168
	, @TimecardStatusId int = 1
	, @InvoiceId int = NULL
	, @StartDateTimeUtc datetime2(7) = '1/1/2001'
	, @StartDateTimeLocal datetime2(7) = '1/1/2001'
	, @EndDateTimeUtc datetime2(7) = '1/1/2001'
	, @EndDateTimeLocal datetime2(7) = '1/1/2001'
	, @Id int

	EXEC TimecardEntry_Insert
		@ProjectId
		, @PersonId
		, @TimecardStatusId
		, @InvoiceId
		, @StartDateTimeUtc
		, @StartDateTimeLocal
		, @EndDateTimeUtc
		, @EndDateTimeLocal
		, @Id OUTPUT

	 SELECT *
	 FROM TimecardEntry
	 WHERE Id = @Id
*/
BEGIN
	INSERT INTO TimecardEntry
		(ProjectId
		, PersonId
		, TimecardStatusId
		, InvoiceId
		, StartDateTimeUtc
		, StartDateTimeLocal
		, EndDateTimeUtc
		, EndDateTimeLocal)
		
		VALUES (@ProjectId
			, @PersonId
			, @TimecardStatusId
			, @InvoiceId
			, @StartDateTimeUtc
			, @StartDateTimeLocal
			, @EndDateTimeUtc
			, @EndDateTimeLocal)

		SET @Id = SCOPE_IDENTITY()
END



GO
/****** Object:  StoredProcedure [dbo].[TimecardEntry_Search]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TimecardEntry_Search]
	@Id int = null
	, @ProjectId int = null
	, @PersonId int = null
	, @TimecardStatusId int = null
	, @StartDateTimeUtc datetime2(7) = null
	, @StartDateTimeLocal datetime2(7) = null
	, @EndDateTimeUtc datetime2(7) = null
	, @EndDateTimeLocal datetime2(7) = null

AS
--EXEC TimecardEntry_Search @PersonId = 168
BEGIN
	SELECT DISTINCT tce.Id
		, p.Id AS ProjectId
		, p.ProjectName
		, pe.FirstName
		, pe.LastName
		, tce.PersonId
		, tce.TimecardStatusId
		, tcs.Status
		, ps.Status AS ProjectStatus
		, tce.StartDateTimeUtc
		, tce.StartDateTimeLocal
		, tce.EndDateTimeUtc
		, tce.EndDateTimeLocal
		FROM TimecardEntry tce
			JOIN Project p 
		ON tce.ProjectId = p.Id
			LEFT JOIN ProjectStatus ps
		ON p.ProjectStatusId = ps.Id
			JOIN Person pe
		ON tce.PersonId = pe.Id
			 LEFT JOIN TimecardStatus tcs
		ON tcs.Id = tce.TimecardStatusId
			LEFT JOIN ProjectPerson pp
		ON pe.Id = pp.PersonId
		WHERE ((@Id IS NULL OR @Id = 0) OR tce.Id = @Id)
			AND ((@ProjectId IS NULL OR @ProjectId = 0) OR tce.ProjectId = @ProjectId) 
			AND ((@PersonId IS NULL OR @PersonId = 0) OR tce.PersonId = @PersonId)
			AND ((@TimecardStatusId IS NULL OR @TimecardStatusId = '') OR (tce.TimecardStatusId = @TimecardStatusId)) 
			AND (@StartDateTimeLocal IS NULL OR (tce.StartDateTimeLocal > @StartDateTimeLocal)) 
			AND (@EndDateTimeLocal IS NULL OR (tce.EndDateTimeLocal < @EndDateTimeLocal)) 
			AND (@StartDateTimeUtc IS NULL OR (tce.StartDateTimeUtc > @StartDateTimeUtc)) 
			AND (@EndDateTimeUtc IS NULL OR (tce.EndDateTimeUtc < @EndDateTimeUtc))
END



GO
/****** Object:  StoredProcedure [dbo].[TimecardEntry_SelectByProjectId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[TimecardEntry_SelectByProjectId]
  @ProjectId int
AS

BEGIN

/*

  DECLARE @ProjectId INT 9

 EXEC TimecardEntry_SelectByProjectId 168

 DECLARE @PersonId INT = 13

EXEC dbo.TimecardEntry_SelectByProjectId
		@ProjectId = 4


*/

Select  tce.Id as timecard
		, tce.ProjectId
		, pj.ProjectName
		, p.LastName
		,ROUND((DATEDIFF(MINUTE, tce.StartDateTimeUtc, tce.EndDateTimeUtc)*pp.HourlyRate)/60, 2) AS EarningsOnProj
		,(DATEDIFF(MINUTE, tce.StartDateTimeUtc, tce.EndDateTimeUtc)) AS MinutesOnProj
		, pp.HourlyRate
		, pj.Id as ProjectId
		, tce.PersonId
		, tce.InvoiceId
		, tce.StartDateTimeUtc
		, tce.EndDateTimeUtc
		, pp.PersonId
		, p.FirstName


	from TimecardEntry tce
	JOIN dbo.Project as pj
	ON tce.ProjectId = pj.Id
	JOIN ProjectPerson pp ON
	tce.PersonId = pp.PersonId and tce.ProjectId = pp.ProjectId
	JOIN Person p ON
	tce.PersonId = p.Id
   
   where tce.ProjectId = @ProjectId and (DATEDIFF(MINUTE, tce.StartDateTimeUtc, tce.EndDateTimeUtc)) > 0 and tce.TimecardStatusId in (1,2)
   Order by p.LastName, p.FirstName, pj.ProjectName, tce.StartDateTimeUtc
	
END



GO
/****** Object:  StoredProcedure [dbo].[TimecardEntry_Update]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TimecardEntry_Update]
	@Id int
	, @ProjectId int
	, @PersonId int
	, @TimecardStatusId int = 1
	, @InvoiceId int = NULL
	, @StartDateTimeUtc datetime2(7) = NULL
	, @StartDateTimeLocal datetime2(7) = NULL
	, @EndDateTimeUtc datetime2(7) = NULL
	, @EndDateTimeLocal datetime2(7) = NULL
AS
/* TEST CODE

DECLARE @Id int = 2
	, @ProjectId int = 4
	, @PersonId int = 168
	, @TimecardStatusId int = 2
	, @InvoiceId int = NULL
	, @StartDateTimeUtc datetime2(7) = '1/1/2002'
	, @StartDateTimeLocal datetime2(7) = '1/1/2002'
	, @EndDateTimeUtc datetime2(7) = '1/1/2002'
	, @EndDateTimeLocal datetime2(7) = '1/1/2002'

SELECT * FROM TimecardEntry
WHERE Id = @Id

EXEC TimecardEntry_Update @Id
	, @ProjectId
	, @PersonId
	, @TimecardStatusId
	, @InvoiceId
	, @StartDateTimeUtc
	, @StartDateTimeLocal
	, @EndDateTimeUtc
	, @EndDateTimeLocal

SELECT * FROM TimecardEntry
WHERE Id = @Id

*/
BEGIN
	UPDATE TimecardEntry
		SET ProjectId = @ProjectId
		, PersonId = @PersonId
		, TimecardStatusId = @TimecardStatusId
		, InvoiceId = @InvoiceId
		, StartDateTimeUtc = @StartDateTimeUtc
		, StartDateTimeLocal = @StartDateTimeLocal
		, EndDateTimeUtc = @EndDateTimeUtc
		, EndDateTimeLocal = @EndDateTimeLocal
		WHERE Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[TimecardPersonForInvoice_SelectByProjectId]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TimecardPersonForInvoice_SelectByProjectId]
  @ProjectId int
AS

BEGIN 

/*
DECLARE @ProjectId int = 4

EXEC TimecardPersonForInvoice_SelectByProjectId 4

*/

Select  tce.Id as timecard, tce.ProjectId as projectsid, tce.PersonId, tce.InvoiceId, tce.StartDateTimeUtc, tce.EndDateTimeUtc, pp.HourlyRate, p.LastName, p.FirstName, 

		(DATEDIFF(MINUTE, tce.StartDateTimeUtc, tce.EndDateTimeUtc)) AS MinutesOnProj
		,ROUND((DATEDIFF(MINUTE, tce.StartDateTimeUtc, tce.EndDateTimeUtc)*pp.HourlyRate)/60, 2) AS EarningsOnProj

  from TimecardEntry tce

  JOIN ProjectPerson pp ON
  tce.PersonId = pp.PersonId and tce.ProjectId = pp.ProjectId
  JOIN Person p ON
  tce.PersonId = p.Id
   
  



   where tce.ProjectId = @ProjectId and (DATEDIFF(MINUTE, tce.StartDateTimeUtc, tce.EndDateTimeUtc)) > 0 and tce.TimecardStatusId in (1,2)
   Order by p.LastName, p.FirstName, tce.StartDateTimeUtc

  
  END
   /*pass into stored  update invoice id onto timecard person*/

GO
/****** Object:  StoredProcedure [dbo].[UpdateBlogComments]    Script Date: 6/23/2017 4:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UpdateBlogComments]
@Id int, 
@Name nvarchar(50),
@Email nvarchar(50),
@comment nvarchar(max)


AS
Begin
Update [Comments]
SET
 Name =@Name, 
 Email=@Email,
 Comment=@comment
where id= @Id
end


GO