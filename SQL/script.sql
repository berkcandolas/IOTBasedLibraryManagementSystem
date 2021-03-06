USE [LibraryManagementDb]
GO
/****** Object:  Table [dbo].[BookCategories]    Script Date: 21.06.2022 15:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCategories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](30) NULL,
	[Description] [varchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 21.06.2022 15:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](25) NULL,
	[PublisherDate] [date] NULL,
	[AuthorName] [varchar](30) NULL,
	[PageNumber] [int] NULL,
	[CategoryId] [int] NULL,
	[PublisherId] [int] NULL,
	[ISBN] [varchar](50) NULL,
	[LibraryCode] [varchar](20) NULL,
	[IsAvailable] [bit] NULL,
 CONSTRAINT [PK__Books__3DE0C2079B01B588] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loans]    Script Date: 21.06.2022 15:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loans](
	[LoanId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[BookId] [int] NULL,
	[BeginDate] [date] NULL,
	[EndDate] [date] NULL,
	[IsReturned] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[LoanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publishers]    Script Date: 21.06.2022 15:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publishers](
	[PublisherId] [int] IDENTITY(1,1) NOT NULL,
	[PublisherTitle] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[PublisherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 21.06.2022 15:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](30) NULL,
	[UserPassword] [varchar](30) NULL,
	[FirstName] [varchar](30) NULL,
	[LastName] [varchar](30) NULL,
	[RoleName] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK__Books__CategoryI__3D5E1FD2] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[BookCategories] ([CategoryId])
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK__Books__CategoryI__3D5E1FD2]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK__Books__Publisher__3E52440B] FOREIGN KEY([PublisherId])
REFERENCES [dbo].[Publishers] ([PublisherId])
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK__Books__Publisher__3E52440B]
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD  CONSTRAINT [FK__Loans__BookId__4222D4EF] FOREIGN KEY([BookId])
REFERENCES [dbo].[Books] ([BookId])
GO
ALTER TABLE [dbo].[Loans] CHECK CONSTRAINT [FK__Loans__BookId__4222D4EF]
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
/****** Object:  StoredProcedure [dbo].[SP_GetBooks]    Script Date: 21.06.2022 15:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[SP_GetBooks]
As
Select 
	B.*,
	BC.CategoryName,
	P.PublisherTitle
From Books B
Join BookCategories BC On BC.CategoryId = B.CategoryId
Join Publishers P On P.PublisherId = B.PublisherId
GO
/****** Object:  StoredProcedure [dbo].[SP_GetLoans]    Script Date: 21.06.2022 15:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[SP_GetLoans]
As
Select 
	L.*,
	B.Title,
	U.UserName
From Loans L
Join Books B On B.BookId = L.BookId
Join Users U On U.UserId = L.UserId
GO
/****** Object:  Trigger [dbo].[TR_IsAvailable]    Script Date: 21.06.2022 15:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Trigger [dbo].[TR_IsAvailable]
On [dbo].[Loans]
After Insert
As
	Declare @id Int = (Select BookId From inserted)
	Update Books Set IsAvailable = 0 Where BookId = @id
GO
ALTER TABLE [dbo].[Loans] ENABLE TRIGGER [TR_IsAvailable]
GO
