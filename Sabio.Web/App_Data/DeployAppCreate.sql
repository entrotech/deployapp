USE [master]
GO

ALTER DATABASE [XYZ] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [XYZ].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [XYZ] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [XYZ] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [XYZ] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [XYZ] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [XYZ] SET ARITHABORT OFF 
GO
ALTER DATABASE [XYZ] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [XYZ] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [XYZ] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [XYZ] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [XYZ] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [XYZ] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [XYZ] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [XYZ] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [XYZ] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [XYZ] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [XYZ] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [XYZ] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [XYZ] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [XYZ] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [XYZ] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [XYZ] SET RECOVERY FULL 
GO
ALTER DATABASE [XYZ] SET  MULTI_USER 
GO
ALTER DATABASE [XYZ] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [XYZ] SET DB_CHAINING OFF 
GO

ALTER DATABASE [XYZ] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [XYZ] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DeployTest', N'ON'
GO
ALTER DATABASE [XYZ] SET QUERY_STORE = OFF
GO
USE [XYZ]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [XYZ]
GO

/****** Object:  FullTextCatalog [JobPostingCatalog]    Script Date: 6/23/2017 4:46:46 PM ******/
CREATE FULLTEXT CATALOG [JobPostingCatalog]WITH ACCENT_SENSITIVITY = OFF

GO
/****** Object:  UserDefinedTableType [dbo].[IntIdTable]    Script Date: 6/23/2017 4:46:46 PM ******/
CREATE TYPE [dbo].[IntIdTable] AS TABLE(
	[Data] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[Data] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedTableType [dbo].[InvoiceItemTable]    Script Date: 6/23/2017 4:46:46 PM ******/
CREATE TYPE [dbo].[InvoiceItemTable] AS TABLE(
	[Description] [nvarchar](max) NULL,
	[LineTotal] [money] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[NVarCharIdTable]    Script Date: 6/23/2017 4:46:46 PM ******/
CREATE TYPE [dbo].[NVarCharIdTable] AS TABLE(
	[Data] [varchar](128) NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[Data] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedTableType [dbo].[NVarCharTable]    Script Date: 6/23/2017 4:46:47 PM ******/
CREATE TYPE [dbo].[NVarCharTable] AS TABLE(
	[Data] [nvarchar](max) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[PersonNotificationPreferenceTable]    Script Date: 6/23/2017 4:46:47 PM ******/
CREATE TYPE [dbo].[PersonNotificationPreferenceTable] AS TABLE(
	[PersonId] [int] NOT NULL,
	[NotificationEventId] [int] NOT NULL,
	[SendEmail] [bit] NOT NULL,
	[SendText] [bit] NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[NotificationEventId] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedTableType [dbo].[UniqueIdTable]    Script Date: 6/23/2017 4:46:47 PM ******/
CREATE TYPE [dbo].[UniqueIdTable] AS TABLE(
	[Data] [uniqueidentifier] NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[Data] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[SquadMember]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SquadMember](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SquadId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
	[LeaderComment] [nvarchar](max) NULL,
	[UserIdCreated] [nvarchar](250) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[MemberStatusId] [int] NOT NULL,
	[IsLeader] [bit] NULL,
 CONSTRAINT [PK_SquadMember_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SquadEvent]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SquadEvent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserIdCreated] [nvarchar](128) NOT NULL,
	[EventStart] [datetime2](7) NOT NULL,
	[EventEnd] [datetime2](7) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Location] [nvarchar](50) NULL,
	[SquadId] [int] NOT NULL,
	[Color] [nvarchar](20) NULL,
	[Timezone] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SquadEvent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[SquadId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Person]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[DateOfBirth] [date] NULL,
	[Address1] [nvarchar](100) NULL,
	[Address2] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[StateProvinceId] [int] NULL,
	[PostalCode] [nvarchar](10) NULL,
	[CountryId] [int] NULL,
	[DateCreated] [datetime2](7) NULL,
	[DateModified] [datetime2](7) NULL,
	[UserIdCreated] [nvarchar](128) NULL,
	[IsDeleted] [bit] NULL,
	[AspNetUserId] [nvarchar](128) NULL,
	[PhotoKey] [nvarchar](150) NULL,
	[JobTitle] [nvarchar](100) NULL,
	[Resume] [nvarchar](100) NULL,
	[IsVeteran] [bit] NULL,
	[IsEmployer] [bit] NULL,
	[IsFamilyMember] [bit] NULL,
	[Description] [nvarchar](1000) NULL,
	[EmploymentStatus] [nvarchar](50) NULL,
	[Location] [geography] NULL,
	[Latitude] [decimal](18, 12) NULL,
	[Longitude] [decimal](18, 12) NULL,
	[IsEmployed] [bit] NULL,
	[OpCodeEmployAssist] [bit] NULL,
	[EducationLevelId] [int] NULL,
	[ServiceBranchId] [int] NULL,
	[IsPhonePublic] [bit] NOT NULL,
	[IsAddressPublic] [bit] NOT NULL,
	[IsEmailPublic] [bit] NOT NULL,
	[IsDateOfBirthPublic] [bit] NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[SquadMemberEvent]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[SquadMemberEvent] AS
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
WHERE P.AspNetUserId = '6bfd9970-2e37-4809-a5fa-25cf7e366802'

GO
/****** Object:  Table [dbo].[Announcement]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Announcement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Body] [nvarchar](4000) NOT NULL,
	[AnnouncementCategoryId] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserIdCreated] [nvarchar](128) NOT NULL,
	[PhotoKey] [nvarchar](150) NULL,
 CONSTRAINT [PK_Announcement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AnnouncementCategory]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AnnouncementCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AnnouncementCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Blog]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserIdCreated] [nvarchar](128) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[BlogCategory] [nvarchar](50) NOT NULL,
	[Private] [bit] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Blog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BlogBlogPhoto]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogBlogPhoto](
	[BlogId] [int] NOT NULL,
	[BlogPhotoId] [int] NOT NULL,
 CONSTRAINT [PK_BlogBlogPhoto] PRIMARY KEY CLUSTERED 
(
	[BlogId] ASC,
	[BlogPhotoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BlogBlogTag]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogBlogTag](
	[BlogId] [int] NOT NULL,
	[BlogTagId] [int] NOT NULL,
 CONSTRAINT [PK_BlogBlogTag] PRIMARY KEY CLUSTERED 
(
	[BlogId] ASC,
	[BlogTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BlogComment]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogComment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[BlogId] [int] NOT NULL,
	[ParentId] [int] NULL,
	[UserIdCreated] [nvarchar](100) NOT NULL,
	[IsApproved] [bit] NULL,
 CONSTRAINT [PK_BlogComment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BlogPhoto]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogPhoto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PhotoKey] [nvarchar](150) NULL,
 CONSTRAINT [PK_BlogPhoto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BlogTag]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Keyword] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_BlogTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Company]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [datetime2](7) NULL,
	[DateModified] [datetime2](7) NULL,
	[CompanyIdCreated] [nvarchar](128) NULL,
	[CompanyName] [nvarchar](100) NOT NULL,
	[CompanyPhoneNumber] [nvarchar](50) NULL,
	[CompanyEmail] [nvarchar](100) NULL,
	[Address1] [nvarchar](50) NULL,
	[Address2] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[StateProvinceId] [int] NULL,
	[CountryId] [int] NULL,
	[PostalCode] [nvarchar](50) NULL,
	[Inactive] [bit] NULL,
	[IsDeploy] [bit] NULL,
 CONSTRAINT [PK_Company1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CompanyPerson]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyPerson](
	[CompanyId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
 CONSTRAINT [PK_CompanyPerson] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC,
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContactRequest]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[ContactRequestStatusId] [int] NOT NULL,
	[Notes] [nvarchar](250) NULL,
 CONSTRAINT [PK_ContactRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContactRequestStatus]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactRequestStatus](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ContactRequestStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Country]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[LongCode] [nvarchar](50) NULL,
	[DateAdded] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EducationLevel]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EducationLevel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Inactive] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserIdCreated] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_EducationLevel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employer]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[EmployerIdCreated] [nvarchar](128) NOT NULL,
	[EmployerName] [nvarchar](100) NOT NULL,
	[EmployerPhoneNumber] [nvarchar](50) NULL,
	[EmployerEmail] [nvarchar](100) NULL,
	[Address1] [nvarchar](50) NULL,
	[Address2] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[StateProvinceId] [int] NULL,
	[CountryId] [int] NULL,
 CONSTRAINT [PK_Employer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExceptionLog]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExceptionLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](1000) NULL,
	[Type] [nvarchar](100) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[ApiUrl] [nvarchar](300) NULL,
	[ViewUrl] [nvarchar](300) NULL,
	[RequestBody] [nvarchar](1000) NULL,
	[AspNetUserId] [nvarchar](128) NULL,
	[LogDate] [datetime2](7) NULL,
 CONSTRAINT [PK_ExceptionLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faq]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faq](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserIdCreated] [nvarchar](128) NOT NULL,
	[Question] [nvarchar](500) NOT NULL,
	[Answer] [nvarchar](max) NOT NULL,
	[FaqCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_Faq] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FaqCategory]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FaqCategory](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
 CONSTRAINT [PK_FaqCategoryId] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GlobalEvent]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalEvent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[ZipCode] [int] NOT NULL,
	[Country] [nvarchar](50) NULL,
	[DateStart] [date] NOT NULL,
	[DateEnd] [date] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[Latitude] [decimal](18, 12) NULL,
	[Longitude] [decimal](18, 12) NULL,
	[Geo] [geography] NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserIdCreated] [nvarchar](128) NOT NULL,
	[IsCanceled] [bit] NULL,
 CONSTRAINT [PK_GlobalEvent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HomeStatistics]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HomeStatistics](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[Number] [nvarchar](50) NULL,
	[AutoPopulate] [bit] NULL,
 CONSTRAINT [PK_HomeStatistics] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[Id] [int] IDENTITY(1000,1) NOT NULL,
	[ProjectsId] [int] NOT NULL,
	[InvoiceDate] [datetime2](7) NULL,
	[TimeCardTotals] [money] NULL,
	[LineTotal1] [money] NULL,
	[LineTotal2] [money] NULL,
	[Description1] [nvarchar](max) NULL,
	[Description2] [nvarchar](max) NULL,
	[TotalInvoice] [money] NULL,
	[StatusId] [int] NULL,
	[DateModified] [datetime2](7) NULL,
	[DateCreated] [datetime2](7) NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoicedTimecards]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoicedTimecards](
	[Id] [int] IDENTITY(1001,1) NOT NULL,
	[InvoiceId] [int] NOT NULL,
	[ProjectId] [int] NOT NULL,
	[TotalBilled] [money] NOT NULL,
	[DateBilled] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_InvoicedTimecards] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoiceItem]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceItem](
	[Id] [int] NOT NULL,
	[Description1] [nvarchar](max) NULL,
	[Description2] [nvarchar](max) NULL,
	[LineTotal1] [money] NULL,
	[LineTotal2] [money] NULL,
	[DateCreated] [datetime2](7) NULL,
	[DateModified] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobApplication]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobApplication](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[JobPostingId] [int] NOT NULL,
	[CoverLetter] [nvarchar](4000) NULL,
	[StatusId] [int] NULL,
	[Notes] [nvarchar](4000) NULL,
	[DateCreated] [datetime2](7) NULL,
	[DateModified] [datetime2](7) NULL,
 CONSTRAINT [PK_JobApplication] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobApplicationStatus]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobApplicationStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_JobApplicationStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobPosting]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobPosting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[PositionName] [nvarchar](100) NOT NULL,
	[StreetAddress] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[StateProvinceId] [int] NULL,
	[CountryId] [int] NULL,
	[Compensation] [int] NULL,
	[CompensationRateId] [int] NULL,
	[FullPartId] [int] NULL,
	[ContractPermanentId] [int] NULL,
	[ExperienceLevelId] [int] NULL,
	[Description] [nvarchar](4000) NULL,
	[Responsibilities] [nvarchar](4000) NULL,
	[Requirements] [nvarchar](4000) NULL,
	[ContactInformation] [nvarchar](4000) NULL,
	[Location] [geography] NULL,
	[JobPostingStatusId] [int] NULL,
	[DateCreated] [datetime2](7) NULL,
	[DateModified] [datetime2](7) NULL,
	[UserIdCreated] [nvarchar](128) NULL,
 CONSTRAINT [PK_dbo.JobPosting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobPostingClickLog]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobPostingClickLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Clicks] [int] NOT NULL,
 CONSTRAINT [PK_JobPostingClickLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobPostingJobTag]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobPostingJobTag](
	[JobPostingId] [int] NOT NULL,
	[JobTagId] [int] NOT NULL,
 CONSTRAINT [PK_JobPostingJobTag] PRIMARY KEY CLUSTERED 
(
	[JobPostingId] ASC,
	[JobTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobTag]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Keyword] [nvarchar](100) NOT NULL,
	[Inactive] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
 CONSTRAINT [PK_JobTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Language]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](20) NOT NULL,
	[DisplayOrder] [int] NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserIdCreated] [nvarchar](50) NOT NULL,
	[Inactive] [bit] NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LanguageProficiency]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LanguageProficiency](
	[Id] [int] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Description] [nvarchar](100) NULL,
	[DateCreated] [datetime2](7) NULL,
	[DateModified] [datetime2](7) NULL,
 CONSTRAINT [PK_LanguageProficiency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Load_MilitaryBaseBnd]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Load_MilitaryBaseBnd](
	[COMPONENT] [varchar](50) NULL,
	[SITE_NAME] [varchar](50) NULL,
	[JOINT_BASE] [varchar](50) NULL,
	[STATE_TERR] [varchar](50) NULL,
	[BRAC_SITE] [varchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Load_MilitaryBasePt]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Load_MilitaryBasePt](
	[COMPONENT] [varchar](50) NULL,
	[SITE_NAME] [varchar](50) NULL,
	[JOINT_BASE] [varchar](50) NULL,
	[STATE_TERR] [varchar](50) NULL,
	[BRAC_SITE] [varchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MilitaryBase]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MilitaryBase](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MilitaryBase] [nvarchar](150) NOT NULL,
	[ServiceBranchId] [int] NOT NULL,
 CONSTRAINT [PK_MilitaryBase] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NotificationEvent]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationEvent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_NotificationEvent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Opportunity]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opportunity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[ContactPersonFirstName] [nvarchar](50) NOT NULL,
	[ContactPersonLastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](50) NULL,
	[Address1] [nvarchar](50) NULL,
	[Address2] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[StateProvinceId] [int] NULL,
	[PostalCode] [nvarchar](10) NULL,
	[CountryId] [int] NULL,
	[DateCreated] [datetime2](7) NULL,
	[DateModified] [datetime2](7) NULL,
	[UserIdCreated] [nvarchar](128) NULL,
	[DateTimePickerStart] [datetime2](7) NULL,
	[DateTimePickerEnd] [datetime2](7) NULL,
 CONSTRAINT [PK_Resources] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonLanguage]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonLanguage](
	[PersonId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[DateCreated] [datetime2](7) NULL,
	[DateModified] [datetime2](7) NULL,
	[LanguageProficiencyId] [int] NOT NULL,
 CONSTRAINT [PK_PersonLanguage] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonMilitaryBase]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonMilitaryBase](
	[PersonId] [int] NOT NULL,
	[MilitaryBaseId] [int] NOT NULL,
 CONSTRAINT [PK_PersonMilitaryBase] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[MilitaryBaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonNotificationPreference]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonNotificationPreference](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[NotificationEventId] [int] NOT NULL,
	[SendEmail] [bit] NOT NULL,
	[SendText] [bit] NOT NULL,
 CONSTRAINT [PK_PersonNotificationPreferences] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonSkill]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonSkill](
	[PersonId] [int] NOT NULL,
	[SkillId] [int] NOT NULL,
	[SkillLevel] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Project]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [nvarchar](50) NULL,
	[Description] [nvarchar](3000) NOT NULL,
	[Budget] [decimal](18, 4) NULL,
	[Deadline] [date] NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserIdCreated] [nvarchar](128) NULL,
	[CompanyId] [int] NULL,
	[SpentToDate] [decimal](18, 4) NULL,
	[ProjectStatusId] [int] NULL,
	[ProposalId] [int] NULL,
	[TrelloBoardId] [nvarchar](30) NULL,
	[TrelloBoardUrl] [nvarchar](150) NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectPerson]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectPerson](
	[ProjectId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
	[IsLeader] [bit] NULL,
	[HourlyRate] [money] NOT NULL,
	[StatusId] [int] NULL,
	[UserIdCreated] [nvarchar](128) NULL,
 CONSTRAINT [PK_ProjectPerson] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC,
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectPersonStatus]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectPersonStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProjectPersonStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectStatus]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProjectStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Proposal]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proposal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](4000) NOT NULL,
	[Budget] [int] NULL,
	[Deadline] [nvarchar](50) NULL,
	[ProjectType] [nvarchar](200) NOT NULL,
	[FirstName] [nvarchar](150) NOT NULL,
	[LastName] [nvarchar](150) NULL,
	[Company] [nvarchar](200) NULL,
	[PhoneNumber] [varchar](24) NOT NULL,
	[Email] [nvarchar](128) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[Notes] [nvarchar](4000) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Proposal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProposalStatusCategory]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProposalStatusCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProposalStatusCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rank]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rank](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[ServiceBranchId] [int] NOT NULL,
	[Grade] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_Rank] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SecurityToken]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SecurityToken](
	[TokenGuid] [uniqueidentifier] NOT NULL,
	[TokenTypeId] [int] NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Email] [nvarchar](256) NULL,
	[AspNetUserId] [nvarchar](128) NOT NULL,
	[DateCreated] [datetime2](7) NULL,
 CONSTRAINT [PK_SecurityToken] PRIMARY KEY CLUSTERED 
(
	[TokenGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceBranch]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceBranch](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Inactive] [bit] NULL,
	[DisplayOrder] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserIdCreated] [nchar](128) NOT NULL,
 CONSTRAINT [PK_ServiceBranch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Skill]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Skill](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Inactive] [bit] NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_Skill] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Squad]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Squad](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Mission] [nvarchar](1000) NULL,
	[Notes] [nvarchar](1000) NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserIdCreated] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Squad] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SquadMemberStatus]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SquadMemberStatus](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SquadMemberStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SquadSquadTag]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SquadSquadTag](
	[SquadId] [int] NOT NULL,
	[SquadTagId] [int] NOT NULL,
 CONSTRAINT [PK_SquadSquadTag] PRIMARY KEY CLUSTERED 
(
	[SquadId] ASC,
	[SquadTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SquadTag]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SquadTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Keyword] [nvarchar](128) NOT NULL,
	[DisplayOrder] [int] NULL,
	[Inactive] [bit] NOT NULL,
 CONSTRAINT [PK_SquadTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StateProvince]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StateProvince](
	[Id] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
	[StateProvinceCode] [nchar](3) NOT NULL,
	[CountryRegionCode] [nvarchar](3) NOT NULL,
	[IsOnlyStateProvinceFlag] [bit] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[TerritoryID] [int] NOT NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_StateProvince] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TestEmployees]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestEmployees](
	[EmployeeID] [int] NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [image] NULL,
	[Notes] [ntext] NULL,
	[ReportsTo] [int] NULL,
	[PhotoPath] [nvarchar](255) NULL,
	[Status] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Testimonial]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Testimonial](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Testimonial] [nvarchar](max) NOT NULL,
	[Inactive] [bit] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserIdCreated] [nvarchar](128) NULL,
	[PersonId] [int] NULL,
 CONSTRAINT [PK_TestimonialSuccess] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TestTableOne]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTableOne](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[Skills] [nvarchar](50) NULL,
	[Age] [int] NULL,
 CONSTRAINT [PK_TestTableOne] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TimecardEntry]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimecardEntry](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
	[TimecardStatusId] [int] NOT NULL,
	[InvoiceId] [int] NULL,
	[StartDateTimeUtc] [datetime2](7) NULL,
	[StartDateTimeLocal] [datetime2](7) NULL,
	[EndDateTimeUtc] [datetime2](7) NULL,
	[EndDateTimeLocal] [datetime2](7) NULL,
 CONSTRAINT [PK_TimecardEntry] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TimecardStatus]    Script Date: 6/23/2017 4:46:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimecardStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](25) NOT NULL,
 CONSTRAINT [PK_TimecardStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Index [RoleNameIndex]    Script Date: 6/23/2017 4:46:49 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 6/23/2017 4:46:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 6/23/2017 4:46:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 6/23/2017 4:46:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 6/23/2017 4:46:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 6/23/2017 4:46:49 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_JobPosting]    Script Date: 6/23/2017 4:46:49 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [PK_JobPosting] ON [dbo].[JobPosting]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PersonNotificationPreference]    Script Date: 6/23/2017 4:46:49 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_PersonNotificationPreference] ON [dbo].[PersonNotificationPreference]
(
	[PersonId] ASC,
	[NotificationEventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProjectPerson]    Script Date: 6/23/2017 4:46:49 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ProjectPerson] ON [dbo].[ProjectPerson]
(
	[ProjectId] ASC,
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SquadMember]    Script Date: 6/23/2017 4:46:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_SquadMember] ON [dbo].[SquadMember]
(
	[SquadId] ASC,
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Announcement] ADD  CONSTRAINT [DF_Announcement_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Announcement] ADD  CONSTRAINT [DF_Announcement_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Blog] ADD  CONSTRAINT [DF_Blog_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Blog] ADD  CONSTRAINT [DF_Blog_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[BlogComment] ADD  CONSTRAINT [DF_BlogComment_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[BlogComment] ADD  CONSTRAINT [DF_BlogComment_DateModified]  DEFAULT (getdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company1_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company1_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[ContactRequest] ADD  CONSTRAINT [DF_ContactRequest_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ContactRequest] ADD  CONSTRAINT [DF_ContactRequest_ContactRequestStatusId]  DEFAULT ((1)) FOR [ContactRequestStatusId]
GO
ALTER TABLE [dbo].[EducationLevel] ADD  CONSTRAINT [DF_EducationLevel_Inactive]  DEFAULT ((0)) FOR [Inactive]
GO
ALTER TABLE [dbo].[EducationLevel] ADD  CONSTRAINT [DF_EducationLevel_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[EducationLevel] ADD  CONSTRAINT [DF_EducationLevel_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Employer] ADD  CONSTRAINT [DF_Employer_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Employer] ADD  CONSTRAINT [DF_Employer_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[ExceptionLog] ADD  CONSTRAINT [DF_ExceptionLog_LogDate]  DEFAULT (getutcdate()) FOR [LogDate]
GO
ALTER TABLE [dbo].[Faq] ADD  CONSTRAINT [DF_Faq_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Faq] ADD  CONSTRAINT [DF_Faq_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[GlobalEvent] ADD  CONSTRAINT [DF_GlobalEvent_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[GlobalEvent] ADD  CONSTRAINT [DF_GlobalEvent_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[GlobalEvent] ADD  CONSTRAINT [DF_GlobalEvent_IsCanceled]  DEFAULT ((0)) FOR [IsCanceled]
GO
ALTER TABLE [dbo].[HomeStatistics] ADD  CONSTRAINT [DF_HomeStatistics_AutoPopulate]  DEFAULT ((0)) FOR [AutoPopulate]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[InvoiceItem] ADD  CONSTRAINT [DF_InvoiceItem_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[InvoiceItem] ADD  CONSTRAINT [DF_InvoiceItem_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[JobApplication] ADD  CONSTRAINT [DF_JobApplication_StatusId]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[JobApplication] ADD  CONSTRAINT [DF_JobApplication_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[JobApplication] ADD  CONSTRAINT [DF_JobApplication_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[JobPosting] ADD  CONSTRAINT [DF_JobPosting_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[JobPosting] ADD  CONSTRAINT [DF_JobPosting_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[JobPostingClickLog] ADD  CONSTRAINT [DF_JobPostingClickLog_Clicks]  DEFAULT ((0)) FOR [Clicks]
GO
ALTER TABLE [dbo].[JobTag] ADD  CONSTRAINT [DF_JobTag_Inactive]  DEFAULT ((0)) FOR [Inactive]
GO
ALTER TABLE [dbo].[Language] ADD  CONSTRAINT [DF_Languages_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Language] ADD  CONSTRAINT [DF_Languages_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Language] ADD  CONSTRAINT [DF_Language_Inactive]  DEFAULT ((0)) FOR [Inactive]
GO
ALTER TABLE [dbo].[Opportunity] ADD  CONSTRAINT [DF_Resources_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Opportunity] ADD  CONSTRAINT [DF_Resources_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [Default_photoKey]  DEFAULT (N'/no_photo.jpg') FOR [PhotoKey]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_IsPhonePublic]  DEFAULT ((0)) FOR [IsPhonePublic]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_IsAddressPublic]  DEFAULT ((0)) FOR [IsAddressPublic]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_IsEmailPublic]  DEFAULT ((0)) FOR [IsEmailPublic]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_IsDateOfBirthPublic]  DEFAULT ((0)) FOR [IsDateOfBirthPublic]
GO
ALTER TABLE [dbo].[PersonLanguage] ADD  CONSTRAINT [DF_PersonLanguage_LanguageProficiencyId]  DEFAULT ((3)) FOR [LanguageProficiencyId]
GO
ALTER TABLE [dbo].[PersonNotificationPreference] ADD  CONSTRAINT [DF_PersonNotificationPreferences_SendEmail]  DEFAULT ((1)) FOR [SendEmail]
GO
ALTER TABLE [dbo].[PersonNotificationPreference] ADD  CONSTRAINT [DF_PersonNotificationPreferences_SendText]  DEFAULT ((1)) FOR [SendText]
GO
ALTER TABLE [dbo].[PersonSkill] ADD  CONSTRAINT [DF_PersonSkill_SkillLevel]  DEFAULT ((1)) FOR [SkillLevel]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Proposal] ADD  CONSTRAINT [DF_Proposal_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Proposal] ADD  CONSTRAINT [DF_Proposal_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Proposal] ADD  CONSTRAINT [DF_Proposal_Status]  DEFAULT ('4') FOR [Status]
GO
ALTER TABLE [dbo].[SecurityToken] ADD  CONSTRAINT [DF_SecurityToken_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ServiceBranch] ADD  CONSTRAINT [DF_ServiceBranch_Inactive]  DEFAULT ((0)) FOR [Inactive]
GO
ALTER TABLE [dbo].[ServiceBranch] ADD  CONSTRAINT [DF_ServiceBranch_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ServiceBranch] ADD  CONSTRAINT [DF_ServiceBranch_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Skill] ADD  CONSTRAINT [DF_Skill_Inactive]  DEFAULT ((0)) FOR [Inactive]
GO
ALTER TABLE [dbo].[Squad] ADD  CONSTRAINT [DF_Squad_DateCreated]  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Squad] ADD  CONSTRAINT [DF_Squad_DateModified]  DEFAULT (sysutcdatetime()) FOR [DateModified]
GO
ALTER TABLE [dbo].[SquadEvent] ADD  CONSTRAINT [DF_SquadEvent_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[SquadEvent] ADD  CONSTRAINT [DF_SquadEvent_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[SquadEvent] ADD  CONSTRAINT [DF_SquadEvent_Color]  DEFAULT (N'#00acac') FOR [Color]
GO
ALTER TABLE [dbo].[SquadEvent] ADD  CONSTRAINT [DF_SquadEvent_Timezone]  DEFAULT (sysdatetimeoffset()) FOR [Timezone]
GO
ALTER TABLE [dbo].[SquadMember] ADD  CONSTRAINT [DF_SquadMember_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[SquadMember] ADD  CONSTRAINT [DF_SquadMember_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[SquadMember] ADD  CONSTRAINT [DF_SquadMember_MemberStatusId]  DEFAULT ((1)) FOR [MemberStatusId]
GO
ALTER TABLE [dbo].[SquadMember] ADD  CONSTRAINT [DF_SquadMember_IsLeader]  DEFAULT ((0)) FOR [IsLeader]
GO
ALTER TABLE [dbo].[SquadTag] ADD  CONSTRAINT [DF_SquadTag_Inactive]  DEFAULT ((0)) FOR [Inactive]
GO
ALTER TABLE [dbo].[TestEmployees] ADD  CONSTRAINT [DF_Employees_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Testimonial] ADD  CONSTRAINT [DF_TestimonialSuccess_Inactive]  DEFAULT ((0)) FOR [Inactive]
GO
ALTER TABLE [dbo].[Testimonial] ADD  CONSTRAINT [DF_TestimonialSuccess_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Testimonial] ADD  CONSTRAINT [DF_TestimonialSuccess_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Announcement]  WITH CHECK ADD  CONSTRAINT [FK_Announcement_AnnouncementCategory] FOREIGN KEY([AnnouncementCategoryId])
REFERENCES [dbo].[AnnouncementCategory] ([Id])
GO
ALTER TABLE [dbo].[Announcement] CHECK CONSTRAINT [FK_Announcement_AnnouncementCategory]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[BlogBlogTag]  WITH CHECK ADD  CONSTRAINT [FK_BlogBlogTag_Blog] FOREIGN KEY([BlogId])
REFERENCES [dbo].[Blog] ([Id])
GO
ALTER TABLE [dbo].[BlogBlogTag] CHECK CONSTRAINT [FK_BlogBlogTag_Blog]
GO
ALTER TABLE [dbo].[BlogBlogTag]  WITH CHECK ADD  CONSTRAINT [FK_BlogBlogTag_BlogTag] FOREIGN KEY([BlogTagId])
REFERENCES [dbo].[BlogTag] ([Id])
GO
ALTER TABLE [dbo].[BlogBlogTag] CHECK CONSTRAINT [FK_BlogBlogTag_BlogTag]
GO
ALTER TABLE [dbo].[BlogComment]  WITH CHECK ADD  CONSTRAINT [FK_BlogComment_Blog] FOREIGN KEY([BlogId])
REFERENCES [dbo].[Blog] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BlogComment] CHECK CONSTRAINT [FK_BlogComment_Blog]
GO
ALTER TABLE [dbo].[CompanyPerson]  WITH CHECK ADD  CONSTRAINT [FK_CompanyPerson_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[CompanyPerson] CHECK CONSTRAINT [FK_CompanyPerson_Company]
GO
ALTER TABLE [dbo].[CompanyPerson]  WITH CHECK ADD  CONSTRAINT [FK_CompanyPerson_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[CompanyPerson] CHECK CONSTRAINT [FK_CompanyPerson_Person]
GO
ALTER TABLE [dbo].[ContactRequest]  WITH CHECK ADD  CONSTRAINT [FK_ContactRequest_ContactRequestStatus] FOREIGN KEY([ContactRequestStatusId])
REFERENCES [dbo].[ContactRequestStatus] ([Id])
GO
ALTER TABLE [dbo].[ContactRequest] CHECK CONSTRAINT [FK_ContactRequest_ContactRequestStatus]
GO
ALTER TABLE [dbo].[Faq]  WITH CHECK ADD  CONSTRAINT [FK_Faq_Faq] FOREIGN KEY([FaqCategoryId])
REFERENCES [dbo].[FaqCategory] ([Id])
GO
ALTER TABLE [dbo].[Faq] CHECK CONSTRAINT [FK_Faq_Faq]
GO
ALTER TABLE [dbo].[JobApplication]  WITH CHECK ADD  CONSTRAINT [FK_JobApplication_JobApplicationStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[JobApplicationStatus] ([Id])
GO
ALTER TABLE [dbo].[JobApplication] CHECK CONSTRAINT [FK_JobApplication_JobApplicationStatus]
GO
ALTER TABLE [dbo].[JobApplication]  WITH CHECK ADD  CONSTRAINT [FK_JobApplication_JobPosting] FOREIGN KEY([JobPostingId])
REFERENCES [dbo].[JobPosting] ([Id])
GO
ALTER TABLE [dbo].[JobApplication] CHECK CONSTRAINT [FK_JobApplication_JobPosting]
GO
ALTER TABLE [dbo].[JobApplication]  WITH CHECK ADD  CONSTRAINT [FK_JobApplication_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[JobApplication] CHECK CONSTRAINT [FK_JobApplication_Person]
GO
ALTER TABLE [dbo].[JobPosting]  WITH CHECK ADD  CONSTRAINT [FK_JobPosting_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[JobPosting] CHECK CONSTRAINT [FK_JobPosting_Company]
GO
ALTER TABLE [dbo].[JobPostingJobTag]  WITH CHECK ADD  CONSTRAINT [FK_JobPostingJobTag_JobPosting] FOREIGN KEY([JobPostingId])
REFERENCES [dbo].[JobPosting] ([Id])
GO
ALTER TABLE [dbo].[JobPostingJobTag] CHECK CONSTRAINT [FK_JobPostingJobTag_JobPosting]
GO
ALTER TABLE [dbo].[JobPostingJobTag]  WITH CHECK ADD  CONSTRAINT [FK_JobPostingJobTag_JobTag] FOREIGN KEY([JobTagId])
REFERENCES [dbo].[JobTag] ([Id])
GO
ALTER TABLE [dbo].[JobPostingJobTag] CHECK CONSTRAINT [FK_JobPostingJobTag_JobTag]
GO
ALTER TABLE [dbo].[MilitaryBase]  WITH CHECK ADD  CONSTRAINT [FK_MilitaryBase_ServiceBranch] FOREIGN KEY([ServiceBranchId])
REFERENCES [dbo].[ServiceBranch] ([Id])
GO
ALTER TABLE [dbo].[MilitaryBase] CHECK CONSTRAINT [FK_MilitaryBase_ServiceBranch]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_AspNetUsers] FOREIGN KEY([AspNetUserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_AspNetUsers]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_EducationLevel] FOREIGN KEY([EducationLevelId])
REFERENCES [dbo].[EducationLevel] ([Id])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_EducationLevel]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_ServiceBranch] FOREIGN KEY([ServiceBranchId])
REFERENCES [dbo].[ServiceBranch] ([Id])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_ServiceBranch]
GO
ALTER TABLE [dbo].[PersonLanguage]  WITH CHECK ADD  CONSTRAINT [FK_PersonLanguage_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([Id])
GO
ALTER TABLE [dbo].[PersonLanguage] CHECK CONSTRAINT [FK_PersonLanguage_Language]
GO
ALTER TABLE [dbo].[PersonLanguage]  WITH CHECK ADD  CONSTRAINT [FK_PersonLanguage_LanguageProficiency] FOREIGN KEY([LanguageProficiencyId])
REFERENCES [dbo].[LanguageProficiency] ([Id])
GO
ALTER TABLE [dbo].[PersonLanguage] CHECK CONSTRAINT [FK_PersonLanguage_LanguageProficiency]
GO
ALTER TABLE [dbo].[PersonLanguage]  WITH CHECK ADD  CONSTRAINT [FK_PersonLanguage_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[PersonLanguage] CHECK CONSTRAINT [FK_PersonLanguage_Person]
GO
ALTER TABLE [dbo].[PersonMilitaryBase]  WITH CHECK ADD  CONSTRAINT [FK_PersonMilitaryBase_MilitaryBase] FOREIGN KEY([PersonId])
REFERENCES [dbo].[MilitaryBase] ([Id])
GO
ALTER TABLE [dbo].[PersonMilitaryBase] CHECK CONSTRAINT [FK_PersonMilitaryBase_MilitaryBase]
GO
ALTER TABLE [dbo].[PersonMilitaryBase]  WITH CHECK ADD  CONSTRAINT [FK_PersonMilitaryBase_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[PersonMilitaryBase] CHECK CONSTRAINT [FK_PersonMilitaryBase_Person]
GO
ALTER TABLE [dbo].[PersonSkill]  WITH CHECK ADD  CONSTRAINT [FK_PersonSkill_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[PersonSkill] CHECK CONSTRAINT [FK_PersonSkill_Person]
GO
ALTER TABLE [dbo].[PersonSkill]  WITH CHECK ADD  CONSTRAINT [FK_PersonSkill_Skill] FOREIGN KEY([SkillId])
REFERENCES [dbo].[Skill] ([Id])
GO
ALTER TABLE [dbo].[PersonSkill] CHECK CONSTRAINT [FK_PersonSkill_Skill]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_Company]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_ProjectStatus] FOREIGN KEY([ProjectStatusId])
REFERENCES [dbo].[ProjectStatus] ([Id])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_ProjectStatus]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Proposal] FOREIGN KEY([ProposalId])
REFERENCES [dbo].[Proposal] ([Id])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_Proposal]
GO
ALTER TABLE [dbo].[ProjectPerson]  WITH CHECK ADD  CONSTRAINT [FK_ProjectPerson_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[ProjectPerson] CHECK CONSTRAINT [FK_ProjectPerson_Person]
GO
ALTER TABLE [dbo].[ProjectPerson]  WITH CHECK ADD  CONSTRAINT [FK_ProjectPerson_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([Id])
GO
ALTER TABLE [dbo].[ProjectPerson] CHECK CONSTRAINT [FK_ProjectPerson_Project]
GO
ALTER TABLE [dbo].[ProjectPerson]  WITH CHECK ADD  CONSTRAINT [FK_ProjectPerson_ProjectPersonStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[ProjectPersonStatus] ([Id])
GO
ALTER TABLE [dbo].[ProjectPerson] CHECK CONSTRAINT [FK_ProjectPerson_ProjectPersonStatus]
GO
ALTER TABLE [dbo].[Proposal]  WITH CHECK ADD  CONSTRAINT [FK_Proposal_ProposalStatusCategory] FOREIGN KEY([Status])
REFERENCES [dbo].[ProposalStatusCategory] ([Id])
GO
ALTER TABLE [dbo].[Proposal] CHECK CONSTRAINT [FK_Proposal_ProposalStatusCategory]
GO
ALTER TABLE [dbo].[Rank]  WITH CHECK ADD  CONSTRAINT [FK_Rank_Rank] FOREIGN KEY([ServiceBranchId])
REFERENCES [dbo].[ServiceBranch] ([Id])
GO
ALTER TABLE [dbo].[Rank] CHECK CONSTRAINT [FK_Rank_Rank]
GO
ALTER TABLE [dbo].[SquadEvent]  WITH CHECK ADD  CONSTRAINT [FK_SquadEvent_Squad] FOREIGN KEY([SquadId])
REFERENCES [dbo].[Squad] ([Id])
GO
ALTER TABLE [dbo].[SquadEvent] CHECK CONSTRAINT [FK_SquadEvent_Squad]
GO
ALTER TABLE [dbo].[SquadMember]  WITH CHECK ADD  CONSTRAINT [FK_SquadMember_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[SquadMember] CHECK CONSTRAINT [FK_SquadMember_Person]
GO
ALTER TABLE [dbo].[SquadMember]  WITH CHECK ADD  CONSTRAINT [FK_SquadMember_Squad] FOREIGN KEY([SquadId])
REFERENCES [dbo].[Squad] ([Id])
GO
ALTER TABLE [dbo].[SquadMember] CHECK CONSTRAINT [FK_SquadMember_Squad]
GO
ALTER TABLE [dbo].[SquadMember]  WITH CHECK ADD  CONSTRAINT [FK_SquadMember_SquadMemberStatus] FOREIGN KEY([MemberStatusId])
REFERENCES [dbo].[SquadMemberStatus] ([Id])
GO
ALTER TABLE [dbo].[SquadMember] CHECK CONSTRAINT [FK_SquadMember_SquadMemberStatus]
GO
ALTER TABLE [dbo].[SquadSquadTag]  WITH CHECK ADD  CONSTRAINT [FK_SquadSquadTag_Squad] FOREIGN KEY([SquadId])
REFERENCES [dbo].[Squad] ([Id])
GO
ALTER TABLE [dbo].[SquadSquadTag] CHECK CONSTRAINT [FK_SquadSquadTag_Squad]
GO
ALTER TABLE [dbo].[SquadSquadTag]  WITH CHECK ADD  CONSTRAINT [FK_SquadSquadTag_SquadTag] FOREIGN KEY([SquadTagId])
REFERENCES [dbo].[SquadTag] ([Id])
GO
ALTER TABLE [dbo].[SquadSquadTag] CHECK CONSTRAINT [FK_SquadSquadTag_SquadTag]
GO
ALTER TABLE [dbo].[Testimonial]  WITH CHECK ADD  CONSTRAINT [FK_Testimonial_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[Testimonial] CHECK CONSTRAINT [FK_Testimonial_Person]
GO
ALTER TABLE [dbo].[TimecardEntry]  WITH CHECK ADD  CONSTRAINT [FK_TimecardEntry_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[TimecardEntry] CHECK CONSTRAINT [FK_TimecardEntry_Person]
GO
ALTER TABLE [dbo].[TimecardEntry]  WITH CHECK ADD  CONSTRAINT [FK_TimecardEntry_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([Id])
GO
ALTER TABLE [dbo].[TimecardEntry] CHECK CONSTRAINT [FK_TimecardEntry_Project]
GO
ALTER TABLE [dbo].[TimecardEntry]  WITH CHECK ADD  CONSTRAINT [FK_TimecardEntry_TimecardStatus] FOREIGN KEY([TimecardStatusId])
REFERENCES [dbo].[TimecardStatus] ([Id])
GO
ALTER TABLE [dbo].[TimecardEntry] CHECK CONSTRAINT [FK_TimecardEntry_TimecardStatus]
GO


ALTER DATABASE [XYZ] SET  READ_WRITE 
GO

CREATE FULLTEXT INDEX ON JobPosting
		(PositionName
		,City
		,Description
		,Responsibilities
		,Requirements)
	KEY INDEX PK_JobPosting
		ON JobPostingCatalog


