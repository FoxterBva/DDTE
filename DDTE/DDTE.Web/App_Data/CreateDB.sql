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

PRINT '-> dbo.Union'
GO
IF OBJECT_ID('Union') IS NULL
BEGIN
	CREATE TABLE dbo.[Union] 
	(
		[UnionId] INT NOT NULL identity(1,1),
		[Name] NVARCHAR(200) NULL,
		[Description] NVARCHAR(1000) NULL,
		[IsActive] BIT NOT NULL CONSTRAINT DF_Union_IsActive DEFAULT(0),
		[CreatedDate] DATETIME NOT NULL,
		[ModifiedDate] DATETIME NOT NULL,
		CONSTRAINT [PK_Union] PRIMARY KEY CLUSTERED 
		(
			[UnionId]
		)
	)
END
GO

PRINT '-> dbo.UnionProgram'
GO
IF OBJECT_ID('UnionProgram') IS NULL
BEGIN
	CREATE TABLE dbo.[UnionProgram] 
	(
		[UnionProgramId] INT NOT NULL identity(1,1),
		[UnionId] INT NOT NULL,
		[Title] NVARCHAR(200) NULL,
		[Name] NVARCHAR(200) NULL,
		[Direction] NVARCHAR(MAX) NULL,
		[EducationDirection] NVARCHAR(MAX) NULL,
		[Goal] NVARCHAR(1000) NULL,
		[EducationTasks] NVARCHAR(MAX) NULL,
		[DevelopingTasks] NVARCHAR(MAX) NULL,
		[EducativeTasks] NVARCHAR(MAX) NULL,
		[Education] NVARCHAR(1000) NULL,
		[Duration] NVARCHAR(50) NULL,
		[Age] NVARCHAR(50) NULL,
		[AcceptConditions] NVARCHAR(1000) NULL,
		[IsActive] BIT NOT NULL CONSTRAINT DF_UnionProgram_IsActive DEFAULT(0),
		[CreatedDate] DATETIME NOT NULL,
		[ModifiedDate] DATETIME NOT NULL,
		CONSTRAINT [PK_UnionProgram] PRIMARY KEY CLUSTERED 
		(
			[UnionProgramId]
		)
	)
END
GO

PRINT '-> Create FK UnionProgram-Union'
GO
ALTER TABLE dbo.UnionProgram ADD 
	CONSTRAINT FK_UnionProgram_UnionId FOREIGN KEY
	(
		UnionId
	) 
	REFERENCES dbo.[Union]
	(
		UnionId
	) ON DELETE CASCADE
GO

PRINT '-> dbo.UnionSchedule'
GO
IF OBJECT_ID('UnionSchedule') IS NULL
BEGIN
	CREATE TABLE dbo.[UnionSchedule] 
	(
		[UnionScheduleId] INT NOT NULL identity(1,1),
		[UnionProgramId] INT NOT NULL,
		[Year] NVARCHAR(20) NULL,
		[LessonDuration] NVARCHAR(20) NULL,
		[HoursDay] NVARCHAR(20) NULL,
		[HoursWeek] NVARCHAR(20) NULL,
		[HoursYear] NVARCHAR(20) NULL,
		[LessonsPerWeek] NVARCHAR(20) NULL,
		[IsActive] BIT NOT NULL CONSTRAINT DF_UnionSchedule_IsActive DEFAULT(0),
		[CreatedDate] DATETIME NOT NULL,
		[ModifiedDate] DATETIME NOT NULL,
		CONSTRAINT [PK_UnionSchedule] PRIMARY KEY CLUSTERED 
		(
			[UnionScheduleId]
		)
	)
END
GO

PRINT '-> Create FK UnionSchedule-UnionProgram'
GO
ALTER TABLE dbo.UnionSchedule ADD 
	CONSTRAINT FK_UnionSchedule_UnionProgramId FOREIGN KEY
	(
		UnionProgramId
	) 
	REFERENCES dbo.[UnionProgram]
	(
		UnionProgramId
	) ON DELETE CASCADE
GO

PRINT '-> dbo.UnionAchievement'
GO
IF OBJECT_ID('UnionAchievement') IS NULL
BEGIN
	CREATE TABLE dbo.[UnionAchievement] 
	(
		[UnionAchievementId] INT NOT NULL identity(1,1),
		[UnionProgramId] INT NOT NULL,
		[Name] NVARCHAR(1000) NULL,
		[Date] NVARCHAR(200) NULL,
		[Participant] NVARCHAR(1000) NULL,
		[Result] NVARCHAR(200) NULL,
		[IsActive] BIT NOT NULL CONSTRAINT DF_UnionAchievement_IsActive DEFAULT(0),
		[CreatedDate] DATETIME NOT NULL,
		[ModifiedDate] DATETIME NOT NULL,
		CONSTRAINT [PK_UnionAchievement] PRIMARY KEY CLUSTERED 
		(
			[UnionAchievementId]
		)
	)
END
GO

PRINT '-> Create FK UnionAchievement-UnionProgram'
GO
ALTER TABLE dbo.UnionAchievement ADD 
	CONSTRAINT FK_UnionAchievement_UnionProgramId FOREIGN KEY
	(
		UnionProgramId
	) 
	REFERENCES dbo.[UnionProgram]
	(
		UnionProgramId
	) ON DELETE CASCADE
GO
