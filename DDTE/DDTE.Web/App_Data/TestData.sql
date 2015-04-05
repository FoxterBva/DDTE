-- Creating Albums
INSERT INTO Album (AlbumId, FolderName, Description, IsPublic, Title)
SELECT 1, 'Album1', 'This is a first album', 1, 'Firsst Album' UNION ALL
SELECT 2, 'Album2', 'This is a second album', 1, 'Second Album' 
GO

-- Creating Photos
SET IDENTITY_INSERT Photo ON
INSERT INTO Photo (PhotoId, FileName, Description, AlbumId, Title)
SELECT 1, '/Album1/WoWScrnShot_011315_210108.jpg', 'First Photo', 1, 'Photo 1' UNION ALL
SELECT 2, '/Album0/WoWScrnShot_021715_013612.jpg', 'Second Photo', 1, 'Photo 2' UNION ALL
SELECT 3, 'http://cs421029.vk.me/v421029555/64e8/CxsOwcNcA8s.jpg', 'Third Photo', 1, 'It''s me' UNION ALL
SELECT 4, '/Album2/WoWScrnShot_030115_185856.jpg', 'Fourth Photo', 2, 'It''s me too' 
SET IDENTITY_INSERT Photo OFF