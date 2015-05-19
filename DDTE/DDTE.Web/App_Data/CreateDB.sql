PRINT '-> dbo.Album'
GO
IF OBJECT_ID('Album') IS NULL
BEGIN
	CREATE TABLE dbo.[Album] 
	(
		[AlbumId] INT NOT NULL identity(1,1),
		[Title] NVARCHAR (200) NULL,
		[Description] NVARCHAR(max) NULL,
		[IsPublic] BIT NOT NULL CONSTRAINT DF_Album_IsPublic DEFAULT(0),
		[CreatedDate] DATETIME NOT NULL,
		[ModifiedDate] DATETIME NOT NULL,
		CONSTRAINT [PK_Album] PRIMARY KEY CLUSTERED 
		(
			[AlbumId]
		)
	)
END
GO

PRINT '-> dbo.Photo'
GO
IF OBJECT_ID('Photo') IS NULL
BEGIN
	CREATE TABLE dbo.[Photo] 
	(
		[PhotoId] INT NOT NULL identity(1,1),
		[AlbumId] INT NOT NULL,
		[FileName] NVARCHAR (1000) NULL,
		[Title] NVARCHAR (200) NULL,
		[Description] NVARCHAR(max) NULL,
		[IsPublic] BIT NOT NULL CONSTRAINT DF_Photo_IsPublic DEFAULT(0),
		[CreatedDate] DATETIME NOT NULL,
		[ModifiedDate] DATETIME NOT NULL,
		CONSTRAINT [PK_Photo] PRIMARY KEY CLUSTERED 
		(
			[PhotoId]
		)
	)
END
GO

PRINT '-> Create FK Photo-Album'
GO
ALTER TABLE dbo.Photo ADD 
	CONSTRAINT FK_Pghoto_AlbumId FOREIGN KEY
	(
		AlbumId
	) 
	REFERENCES dbo.Album
	(
		AlbumId
	)
GO

PRINT '-> dbo.News'
GO
IF OBJECT_ID('News') IS NULL
BEGIN
	CREATE TABLE dbo.[News] 
	(
		[NewsId] INT NOT NULL identity(1,1),
		[Title] NVARCHAR(200) NULL,
		[Content] NVARCHAR(max) NULL,
		[IsPublic] BIT NOT NULL CONSTRAINT DF_News_IsPublic DEFAULT(0),
		[CreatedDate] DATETIME NOT NULL,
		[ModifiedDate] DATETIME NOT NULL,
		[Author] NVARCHAR(100) NULL,
		CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
		(
			[NewsId]
		)
	)
END
GO

PRINT '-> dbo.Staff'
GO
IF OBJECT_ID('Staff') IS NULL
BEGIN
	CREATE TABLE dbo.[Staff] 
	(
		[StaffId] INT NOT NULL identity(1,1),
		[Name] NVARCHAR(200) NULL,
		[PhotoUrl] NVARCHAR(300) NULL,
		[Position] NVARCHAR(200) NULL,
		[Qualification] NVARCHAR(200) NULL,
		[Degree] NVARCHAR(1000) NULL,
		[Education] NVARCHAR(1000) NULL,
		[Speciality] NVARCHAR(1000) NULL,
		[QualificationCourses] NVARCHAR(1000) NULL,
		[GeneralExperience] NVARCHAR(1000) NULL,
		[EducationExperience] NVARCHAR(1000) NULL,
		[Phone] NVARCHAR(100) NULL,
		[Email] NVARCHAR(100) NULL,
		[IsActive] BIT NOT NULL CONSTRAINT DF_Staff_IsActive DEFAULT(0),
		[CreatedDate] DATETIME NOT NULL,
		[ModifiedDate] DATETIME NOT NULL,
		CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
		(
			[StaffId]
		)
	)
END
GO
