-- Creating Albums
SET IDENTITY_INSERT Album ON
INSERT INTO Album (AlbumId, Description, IsPublic, Title, CreatedDate, ModifiedDate)
SELECT 1, 'This is a first album', 1, 'Firsst Album', '2000-01-01', '2000-01-01' UNION ALL
SELECT 2, 'This is a second album', 1, 'Second Album', '2000-01-01', '2000-01-01' 
GO
SET IDENTITY_INSERT Album OFF

-- Creating Photos
SET IDENTITY_INSERT Photo ON
INSERT INTO Photo (PhotoId, FileName, Description, AlbumId, Title, CreatedDate, ModifiedDate)
SELECT 1, '/Album1/WoWScrnShot_011315_210108.jpg', 'First Photo', 1, 'Photo 1', '2000-01-01', '2000-01-01' UNION ALL
SELECT 2, '/Album1/WoWScrnShot_021715_013612.jpg', 'Second Photo', 1, 'Photo 2', '2000-01-01', '2000-01-01' UNION ALL
SELECT 3, 'http://cs421029.vk.me/v421029555/64e8/CxsOwcNcA8s.jpg', 'Third Photo', 1, 'It''s me', '2000-01-01', '2000-01-01' UNION ALL
SELECT 4, '/Album2/WoWScrnShot_030115_185856.jpg', 'Fourth Photo', 2, 'It''s me too', '2000-01-01', '2000-01-01' 
SET IDENTITY_INSERT Photo OFF