USE [master]
GO
/****** Object:  Database [Library]    Script Date: 1/28/2020 2:58:51 PM ******/
CREATE DATABASE [Library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\Library.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Library_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\Library_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Library] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Library] SET ARITHABORT OFF 
GO
ALTER DATABASE [Library] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Library] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Library] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Library] SET  MULTI_USER 
GO
ALTER DATABASE [Library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Library] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Library] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Library] SET QUERY_STORE = OFF
GO
USE [Library]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 1/28/2020 2:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[AuthorID] [int] IDENTITY(1,1) NOT NULL,
	[First_Name] [varchar](50) NOT NULL,
	[Last_Name] [varchar](50) NOT NULL,
	[Bio] [varchar](1000) NULL,
	[DateOfBirth] [datetime] NULL,
	[BirthLocation] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 1/28/2020 2:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](100) NULL,
	[Book_Description] [varchar](1000) NULL,
	[Book_Price] [money] NOT NULL,
	[Book_IsPaperBack] [varchar](1) NOT NULL,
	[Book_AuthorID_FK] [int] NULL,
	[GenreID_FK] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genre]    Script Date: 1/28/2020 2:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[GenreID] [int] IDENTITY(1,1) NOT NULL,
	[Genre_Description] [varchar](1000) NULL,
	[Is_Fiction] [varchar](1) NOT NULL,
	[Genre_Name] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Book_Genre_Author]    Script Date: 1/28/2020 2:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_Book_Genre_Author] AS
SELECT Title, Genre_Name, 
First_Name + ' ' + Last_Name AS AuthorName FROM Book b
INNER JOIN Genre g ON g.GenreID = b.GenreID_FK
INNER JOIN Author a ON a.AuthorID = b.Book_AuthorID_FK;
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 1/28/2020 2:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RolesID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](255) NULL,
 CONSTRAINT [PKRolesC4B278203D96CD14] PRIMARY KEY CLUSTERED 
(
	[RolesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/28/2020 2:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [varchar](255) NOT NULL,
	[FirstName] [varchar](255) NOT NULL,
	[UserName] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[RoleID_FK] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Users_Role]    Script Date: 1/28/2020 2:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_Users_Role] AS
SELECT	UserId, 
		FirstName, 
		LastName, UserName, Password, RolesID, RoleName from Users u
INNER JOIN Roles r ON r.RolesID = u.RoleID_FK;
GO
SET IDENTITY_INSERT [dbo].[Author] ON 

INSERT [dbo].[Author] ([AuthorID], [First_Name], [Last_Name], [Bio], [DateOfBirth], [BirthLocation]) VALUES (1, N'Sam', N'Stall', N'Sam Stall is an author, freelance writer, and former editor of Indianapolis Monthly magazine. He has written more than a dozen books specializing in humor and pop culture, including the South Park episode guides. Sam lives in Indianapolis, Indiana.', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Author] OFF
SET IDENTITY_INSERT [dbo].[Book] ON 

INSERT [dbo].[Book] ([BookID], [Title], [Book_Description], [Book_Price], [Book_IsPaperBack], [Book_AuthorID_FK], [GenreID_FK]) VALUES (1, N'Dancing with Jesus: Featuring a Host of Miraculous Moves', N'Are you cursed with two left feet? Are your dance moves unrighteous? Do you refrain from getting down lest others judge you cruelly? Fear not. Salvation is at hand.', 965.9000, N'N', 1, 1)
SET IDENTITY_INSERT [dbo].[Book] OFF
SET IDENTITY_INSERT [dbo].[Genre] ON 

INSERT [dbo].[Genre] ([GenreID], [Genre_Description], [Is_Fiction], [Genre_Name]) VALUES (1, N'A comic novel is usually a work of fiction in which the writer seeks to amuse the reader, sometimes with subtlety and as part of a carefully woven narrative, sometimes above all other considerations. It could indeed be said that comedy fiction is literary work that aims primarily to provoke laughter, but this is not always as obvious as it first may seem.', N'Y', N'Humor')
SET IDENTITY_INSERT [dbo].[Genre] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RolesID], [RoleName]) VALUES (1, N'Administrator')
INSERT [dbo].[Roles] ([RolesID], [RoleName]) VALUES (2, N'Librarian')
INSERT [dbo].[Roles] ([RolesID], [RoleName]) VALUES (3, N'Patron')
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [LastName], [FirstName], [UserName], [Password], [RoleID_FK]) VALUES (1, N'Rhodes', N'Giancarlo', N'grhodes29', N'password123', 1)
INSERT [dbo].[Users] ([UserID], [LastName], [FirstName], [UserName], [Password], [RoleID_FK]) VALUES (2, N'Adams', N'Dillan', N'dillan.adams', N'password123', 3)
INSERT [dbo].[Users] ([UserID], [LastName], [FirstName], [UserName], [Password], [RoleID_FK]) VALUES (3, N'Wells', N'Heather', N'heather.wells', N'password123', 3)
INSERT [dbo].[Users] ([UserID], [LastName], [FirstName], [UserName], [Password], [RoleID_FK]) VALUES (4, N'Colton', N'Nichols', N'colton.nichols', N'password123', 3)
INSERT [dbo].[Users] ([UserID], [LastName], [FirstName], [UserName], [Password], [RoleID_FK]) VALUES (5, N'Teter', N'Derek', N'derek.teter', N'password123', 2)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_BookAuthor] FOREIGN KEY([Book_AuthorID_FK])
REFERENCES [dbo].[Author] ([AuthorID])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_BookAuthor]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Genre] FOREIGN KEY([GenreID_FK])
REFERENCES [dbo].[Genre] ([GenreID])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Genre]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleID_FK])
REFERENCES [dbo].[Roles] ([RolesID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
/****** Object:  StoredProcedure [dbo].[sp_get_users]    Script Date: 1/28/2020 2:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_get_users] 
	-- Add the parameters for the stored procedure here
	@parm_userid int= 0, @parm_username varchar(255) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF (@parm_userid = 0 AND @parm_username = '')
	BEGIN
		SELECT [UserID]
		  ,[LastName]
		  ,[FirstName]
		  ,[UserName]
		  ,[Password]
		  ,[RoleID_FK]
		FROM [Library].[dbo].[Users];
	END
	ELSE IF (@parm_userid <> 0)
	BEGIN
		SELECT 
			[UserID]
		   ,[LastName]
		   ,[FirstName]
		   ,[UserName]
		   ,[Password]
		   ,[RoleID_FK]
		FROM [Library].[dbo].[Users]
		WHERE UserID = @parm_userid;
	END
	ELSE IF (@parm_username <> '')
	BEGIN
		SELECT 
			[UserID]
		   ,[LastName]
		   ,[FirstName]
		   ,[UserName]
		   ,[Password]
		   ,[RoleID_FK]
		FROM [Library].[dbo].[Users]
		WHERE [UserName] = @parm_username;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_register_user]    Script Date: 1/28/2020 2:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_register_user] 
	-- Add the parameters for the stored procedure here
	@parm_FirstName varchar(255),
	@parm_LastName varchar(255),
	@parm_UserName varchar(255),
	@parm_Password varchar(255),
	@parm_RoleID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Users 
		(
			[FirstName],
			[LastName],
			[UserName],
			[Password], 
			[RoleID_FK]
		) 
	VALUES 
		(
			@parm_FirstName, 
			@parm_LastName, 
			@parm_UserName, 
			@parm_Password, 
			@parm_RoleID
		);

END
GO
USE [master]
GO
ALTER DATABASE [Library] SET  READ_WRITE 
GO
