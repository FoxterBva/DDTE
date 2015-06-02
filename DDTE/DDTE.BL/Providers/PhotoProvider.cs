using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.BL.Facade;
using DDTE.Common.Exceptions;
using DDTE.Model;
using DDTE.Model.DTO;
using System.Transactions;

namespace DDTE.BL.Providers
{
	public class PhotoProvider : DbProviderBase, IPhotoProvider
	{
		public static readonly string TmbSuffix = "_tmb";
		public static readonly string AlbumFolderPrefix = "Album";

		#region Album

		/// <summary>
		/// Creates album
		/// </summary>
		public void CreateAlbum(AlbumDTO album, string photoAlbumPath)
		{
			using (var db = GetObjectContext())
			{
				using (TransactionScope transaction = new TransactionScope())
				{
					var a = new Album() { 
						Description = album.Description,
						IsPublic = album.IsPublic,
						Title = album.Title,
						CreatedDate = DateTime.UtcNow,
						ModifiedDate = DateTime.UtcNow
					};

					db.Albums.Add(a);

					db.SaveChanges();

					var id = a.AlbumId;

					var path = Path.Combine(photoAlbumPath, AlbumFolderPrefix + id.ToString());
					try
					{
						Directory.CreateDirectory(path);
					}
					catch (Exception ex)
					{
						// TODO: log
						throw;
					}

					transaction.Complete();
				}
			}
		}

		/// <summary>
		/// Updates fields of the album object
		/// </summary>
		public void UpdateAlbum(AlbumDTO album)
		{
			using (var db = GetObjectContext())
			{
				var q = (from a in db.Albums
						 where a.AlbumId == album.Id
						 select a).FirstOrDefault();

				if (q != null)
				{ 
					q.Title = album.Title;
					q.Description = album.Description;
					q.IsPublic = album.IsPublic;
					q.ModifiedDate = DateTime.UtcNow;

					db.SaveChanges();
				}
			}
		}

		/// <summary>
		/// Returns list of albums
		/// </summary>
		public List<AlbumDTO> ListAlbums()
		{
			List<AlbumDTO> albums = new List<AlbumDTO>();

			//albums.Add(new AlbumDTO()
			//{
			//	Id = 1,
			//	Folder = "",
			//	Description = "This is a First Album",
			//	IsPublic = true,
			//	Title = "First Album"
			//});

			//albums.Add(new AlbumDTO()
			//{
			//	Id = 2,
			//	Folder = "",
			//	Description = "This is a Second Album",
			//	IsPublic = true,
			//	Title = "Second Album"
			//});

			using (var db = GetObjectContext())
			{
				var q = from a in db.Albums
						select new AlbumDTO()
						{
							Id = a.AlbumId,
							//Folder = AlbumFolderPrefix + a.AlbumId,
							IsPublic = a.IsPublic,
							Title = a.Title,
							Description = a.Description,
							CreatedDate = a.CreatedDate
						};

				albums.AddRange(q.ToList());
			}

			return albums;
		}

		/// <summary>
		/// Deletes album and all its content
		/// </summary>
		public void DeleteAlbum(int albumId, string path)
		{
			using (var db = GetObjectContext())
			{
				var q = (from a in db.Albums
						 where a.AlbumId == albumId
						 select a).FirstOrDefault();

				if (q == null)
					throw new KeyNotFoundException("Выбранный альбом не найден.");

				var folder = Path.Combine(path, AlbumFolderPrefix + q.AlbumId.ToString());

				using (TransactionScope transaction = new TransactionScope())
				{
					db.Albums.Remove(q);
					db.SaveChanges();

					Directory.Delete(folder, true);

					transaction.Complete();
				}
			}
		}

		/// <summary>
		/// Deletes album and all its content
		/// </summary>
		public void DeleteAlbum(string folder)
		{
			throw new NotImplementedException();
			// TODO: 
			// 1. Delete all related photos
			// 2. Delete all related photo files
			// 3. Delete folder
			// 4. Delete db record
		}

		#endregion

		#region Photo

		/// <summary>
		/// Adds photo
		/// </summary>
		public void AddPhoto(PhotoDTO photo, IFileContainer fileContainer, string photoPath)
		{
			using (var db = GetObjectContext())
			{
				Photo p = new Photo() 
				{
					AlbumId = photo.AlbumId,
					Description = photo.Description,
					FileName = photo.Path,
					Title = photo.Name,
					IsPublic = photo.IsPublic,
					CreatedDate = DateTime.UtcNow,
					ModifiedDate = DateTime.UtcNow
				};

				using (var ts = new TransactionScope())
				{
					if (String.IsNullOrEmpty(photo.Path))
					{
						var fileRelPath = ("\\" + AlbumFolderPrefix + p.AlbumId.ToString() + "\\" + fileContainer.FileName).Replace("\\", "/");
						p.FileName = fileRelPath;
					}

					db.Photos.Add(p);
					db.SaveChanges();

					if (fileContainer != null)
						fileContainer.Save(Path.Combine(photoPath, AlbumFolderPrefix + p.AlbumId.ToString()));

					ts.Complete();
				}
			}
			//var maxImageHeight = 150;

			//// TODO: 
			//// 1. add to DB


			//// 2. Save file
			//Image img = Image.FromStream(photoStream);
			//if (File.Exists(photoPath))
			//	throw new FileExistsException("File '" + photoPath + "' already exists.");

			//img.Save(photoPath);

			//// 3. Create tumbnail file
			//double scale = (double)maxImageHeight / img.Height;
			//int tmbWidth = (int)(img.Width * scale);
			//int tmbHeight = (int)(img.Height * scale);

			//using (Bitmap tmb = new Bitmap(tmbWidth, tmbHeight))
			//{
			//	using (Graphics g = Graphics.FromImage(tmb))
			//	{
			//		g.InterpolationMode = InterpolationMode.HighQualityBicubic;
			//		g.SmoothingMode = SmoothingMode.HighQuality;
			//		g.CompositingQuality = CompositingQuality.HighQuality;
			//		g.PixelOffsetMode = PixelOffsetMode.HighQuality;

			//		g.DrawImage(img, 0, 0, tmbWidth, tmbHeight);

			//		tmb.Save(String.Format("{0}{1}{2}", Path.GetFileNameWithoutExtension(photoPath), TmbSuffix, "png"), ImageFormat.Png);
			//	}
			//}
		}

		/// <summary>
		/// Updates fields of the photo object
		/// </summary>
		public void UpdatePhoto(PhotoDTO photo)
		{
			using (var db = GetObjectContext()) 
			{
				var q = (from p in db.Photos
						 where p.PhotoId == photo.Id
						 select p).FirstOrDefault();

				if (q == null)
					throw new KeyNotFoundException("Выбранная фотография не найдена.");

				q.Title = photo.Name;
				q.Description = photo.Description;
				q.IsPublic = photo.IsPublic;
				q.ModifiedDate = DateTime.UtcNow;

				db.SaveChanges();
			}
		}

		/// <summary>
		/// Returns display items for photo viewer
		/// </summary>
		public List<PhotoViewerItem> ListPhotoItems(int? albumId)
		{
			List<PhotoViewerItem> res = new List<PhotoViewerItem>();

			if (albumId == null)
			{
				var albums = ListAlbums();
				foreach (var album in albums)
				{
					res.Add(new PhotoViewerItem()
					{
						Id = album.Id,
						Description = album.Description,
						ItemType = PhotoViewerItemType.Album,
						Title = album.Title,
						ImagePath = String.Empty,
						IsPublic = album.IsPublic,
						CreatedDate = album.CreatedDate
					});
				}
			}
			else
			{
				var photos = ListPhotos(albumId.Value);
				foreach (var p in photos)
				{
					res.Add(new PhotoViewerItem() {
						Id = p.PhotoId,
						Description = p.Description,
						Title = p.Title,
						ItemType = PhotoViewerItemType.Photo,
						ImagePath = p.FileName,
						IsPublic = p.IsPublic,
						CreatedDate = p.CreatedDate
					});
				}
			}

			return res;
		}

		/// <summary>
		/// Returns list of photo associated with given album
		/// </summary>
		public List<Photo> ListPhotos(int albumId)
		{
			var res = new List<Photo>();

			//res = tempPhoto.Where(p => p.AlbumId == albumId || albumId == 0).ToList();
			using (var db = GetObjectContext())
			{
				var q = from p in db.Photos
						where p.AlbumId == albumId || albumId == 0
						select p;

				res.AddRange(q.ToList());
			}

			return res;
		}

		/// <summary>
		/// Deletes photo
		/// </summary>
		public void DeletePhoto(int photoId, string path)
		{
			using (var db = GetObjectContext())
			{
				var q = (from p in db.Photos.Include("Album")
						 where p.PhotoId == photoId
						 select p).FirstOrDefault();

				if (q == null)
					throw new KeyNotFoundException("Выбранная фотография не найдена.");

				if (q.FileName.StartsWith("http"))
				{
					db.Photos.Remove(q);
					db.SaveChanges();
				}
				else
				{
					using (var ts = new TransactionScope())
					{
						db.Photos.Remove(q);
						db.SaveChanges();

						var filePath = Path.Combine(path, q.FileName);
						if (File.Exists(filePath))
							File.Delete(filePath);

						ts.Complete();
					}
				}
			}

			// 1. Delete photo file
			// 2. Delete record
		}

		public string GetRandomPublicPhotoUrl()
		{
			using (var db = GetObjectContext())
			{
				var q = (from p in db.Photos
						 where p.IsPublic
						 orderby p.CreatedDate
						 select p.FileName);
				
				int count = q.Count();
				int index = new Random((int)DateTime.UtcNow.Ticks).Next(count);

				return q.Skip(index).FirstOrDefault();
			}
		}

		#endregion Photo

		List<Photo> tempPhoto = new List<Photo>() {
			new Photo() { PhotoId = 1, Title = "Photo 1", Description = "First Photo", AlbumId = 1, FileName = "/Album0/WoWScrnShot_011315_210108.jpg" },
			new Photo() { PhotoId = 2, Title = "Photo 2", Description = "Second Photo", AlbumId = 1, FileName = "/Album0/WoWScrnShot_021715_013612.jpg" },
			new Photo() { PhotoId = 3, Title = "It's me", Description = "Third Photo", AlbumId = 1, FileName = "http://cs421029.vk.me/v421029555/64e8/CxsOwcNcA8s.jpg" },
			new Photo() { PhotoId = 4, Title = "It's me too", Description = "Fourth Photo", AlbumId = 2, FileName = "/Album1/WoWScrnShot_030115_185856.jpg" }
		};
	}
}
