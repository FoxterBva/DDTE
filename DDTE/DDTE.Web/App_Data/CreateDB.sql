PRINT '-> dbo.Album'
GO
IF OBJECT_ID('Album') IS NULL
BEGIN
	CREATE TABLE dbo.[Album] 
	(
		[AlbumId] INT NOT NULL identity(1,1),
		[Title] NVARCHAR (200) NULL,
		[Description] NVARCHAR(max) NULL,
		[FolderName] NVARCHAR(50) NOT NULL,
		[IsPublic] BIT NOT NULL CONSTRAINT DF_Album_IsPublic DEFAULT(0),
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
