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

SET IDENTITY_INSERT News ON
INSERT INTO News (NewsId, Title, Content, Author, CreatedDate, ModifiedDate, IsPublic)
SELECT 1, 'Первая новость!', 'Контент новости. Он, конечно, меньше чем хотелось бы, но придумывать очень лениво :)', 'Foxter', '2015-03-24 19:19:20', '2015-03-24 19:19:20', 1 UNION ALL
SELECT 2, 'Вторая новость!', 'Вторая новость почему-то тоже размером не блещет...', 'Аноним', '2015-03-24 19:29:20', '2015-03-24 19:29:20', 1 UNION ALL
SELECT 3, 'Новость про квадратик', '<p>Жил был квадратик</p><div style=''border: 1px solid Black;height: 100px;width: 100px; background-color: yellow''></div><p>Жил и <strong>не тужил</strong></p><p>На этой радостной ноте мы заканчиваем нашу новость!</p>', 'Квадратик', '2015-04-29 19:19:20', '2015-04-29 19:19:20', 1 UNION ALL
SELECT 4, 'Длинная новость из будущего', 'Очень странная и длинная новость пришедшая к нам, видимо, из будущего! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ', 'Кто-то', '2016-03-24 19:19:20', '2016-03-24 19:19:20', 1
SET IDENTITY_INSERT News OFF