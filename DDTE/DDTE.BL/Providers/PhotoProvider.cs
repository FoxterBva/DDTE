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
						Title = album.Title
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
			throw new NotImplementedException();

			// TODO: update album fields
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
							Folder = a.FolderName,
							IsPublic = a.IsPublic,
							Title = a.Title,
							Description = a.Description
						};

				albums.AddRange(q.ToList());
			}

			return albums;
		}

		/// <summary>
		/// Deletes album and all its content
		/// </summary>
		public void DeleteAlbum(int id)
		{
			throw new NotImplementedException();
			// TODO: 
			// 1. Delete all related photos
			// 2. Delete all related photo files
			// 3. Delete folder
			// 4. Delete db record
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

		/// <summary>
		/// Adds photo
		/// </summary>
		public void AddPhoto(PhotoDTO photo, Stream photoStream, string photoPath)
		{
			var maxImageHeight = 150;

			// TODO: 
			// 1. add to DB


			// 2. Save file
			Image img = Image.FromStream(photoStream);
			if (File.Exists(photoPath))
				throw new FileExistsException("File '" + photoPath + "' already exists.");

			img.Save(photoPath);

			// 3. Create tumbnail file
			double scale = (double)maxImageHeight / img.Height;
			int tmbWidth = (int)(img.Width * scale);
			int tmbHeight = (int)(img.Height * scale);

			using (Bitmap tmb = new Bitmap(tmbWidth, tmbHeight))
			{
				using (Graphics g = Graphics.FromImage(tmb))
				{
					g.InterpolationMode = InterpolationMode.HighQualityBicubic;
					g.SmoothingMode = SmoothingMode.HighQuality;
					g.CompositingQuality = CompositingQuality.HighQuality;
					g.PixelOffsetMode = PixelOffsetMode.HighQuality;

					g.DrawImage(img, 0, 0, tmbWidth, tmbHeight);

					tmb.Save(String.Format("{0}{1}{2}", Path.GetFileNameWithoutExtension(photoPath), TmbSuffix, "png"), ImageFormat.Png);
				}
			}
		}

		/// <summary>
		/// Updates fields of the photo object
		/// </summary>
		public void UpdatePhoto(PhotoDTO photo)
		{
			throw new NotImplementedException();
			// TODO: update photo fields (title, descr)

			// TODO: do we need a possibility to reassign photo and albums?
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
						ImagePath = String.Empty
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
						ImagePath = p.FileName
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
		public void DeletePhoto(int photoId)
		{
			throw new NotImplementedException();

			// 1. Delete photo file
			// 2. Delete record
		}

		List<Photo> tempPhoto = new List<Photo>() {
			new Photo() { PhotoId = 1, Title = "Photo 1", Description = "First Photo", AlbumId = 1, FileName = "/Album0/WoWScrnShot_011315_210108.jpg" },
			new Photo() { PhotoId = 2, Title = "Photo 2", Description = "Second Photo", AlbumId = 1, FileName = "/Album0/WoWScrnShot_021715_013612.jpg" },
			new Photo() { PhotoId = 3, Title = "It's me", Description = "Third Photo", AlbumId = 1, FileName = "http://cs421029.vk.me/v421029555/64e8/CxsOwcNcA8s.jpg" },
			new Photo() { PhotoId = 4, Title = "It's me too", Description = "Fourth Photo", AlbumId = 2, FileName = "/Album1/WoWScrnShot_030115_185856.jpg" }
		};
	}
}
