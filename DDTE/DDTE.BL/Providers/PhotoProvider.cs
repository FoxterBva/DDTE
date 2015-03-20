using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.BL.Facade;
using DDTE.Model;
using DDTE.Model.DTO;

namespace DDTE.BL.Providers
{
	public class PhotoProvider : IPhotoProvider
	{

		public void AddAlbum(AlbumDTO album)
		{
			throw new NotImplementedException();
		}

		public void UpdateAlbum(AlbumDTO album)
		{
			throw new NotImplementedException();
		}

		public List<AlbumDTO> ListAlbums()
		{
			List<AlbumDTO> albums = new List<AlbumDTO>();

			albums.Add(new AlbumDTO()
			{
				Id = 1,
				Folder = "",
				Description = "This is a First Album",
				IsPublic = true,
				Title = "First Album"
			});

			albums.Add(new AlbumDTO()
			{
				Id = 2,
				Folder = "",
				Description = "This is a Second Album",
				IsPublic = true,
				Title = "Second Album"
			});

			return albums;
		}

		public void DeleteAlbum(int id)
		{
			throw new NotImplementedException();
		}

		public void DeleteAlbum(string folder)
		{
			throw new NotImplementedException();
		}

		public void AddPhoto(PhotoDTO photo)
		{
			throw new NotImplementedException();
		}

		public void UpdatePhoto(PhotoDTO photo)
		{
			throw new NotImplementedException();
		}

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
						Id = p.Id,
						Description = p.Description,
						Title = p.Title,
						ItemType = PhotoViewerItemType.Photo,
						ImagePath = p.FileName
					});
				}
			}

			return res;
		}

		public List<Photo> ListPhotos(int albumId)
		{
			var res = new List<Photo>();

			res = tempPhoto.Where(p => p.AlbumId == albumId || albumId == 0).ToList();

			//var listFiles = new List<System.IO.FileInfo>();
			//var listDbPhotos = new List<Photo>();

			//var res = new List<PhotoResultDTO>();

			//foreach (var file in listFiles)
			//{
			//	var dbPhoto = listDbPhotos.FirstOrDefault(p => file.Name.Equals(p.FileName, StringComparison.InvariantCultureIgnoreCase));

			//	if (dbPhoto == null)
			//		dbPhoto = new Photo();

			//	res.Add(new PhotoResultDTO() { 
			//		Description = dbPhoto.Description,
			//		Title = dbPhoto.Title,
					
			//	});
			//}

			return res;
		}

		public void DeletePhoto(int photoId)
		{ 

		}

		List<Photo> tempPhoto = new List<Photo>() {
			new Photo() { Id = 1, Title = "Photo 1", Description = "First Photo", AlbumId = 1, FileName = "/Album0/WoWScrnShot_011315_210108.jpg" },
			new Photo() { Id = 1, Title = "Photo 2", Description = "Second Photo", AlbumId = 1, FileName = "/Album0/WoWScrnShot_021715_013612.jpg" },
			new Photo() { Id = 1, Title = "It's me", Description = "Third Photo", AlbumId = 1, FileName = "http://cs421029.vk.me/v421029555/64e8/CxsOwcNcA8s.jpg" },
			new Photo() { Id = 1, Title = "It's me too", Description = "Fourth Photo", AlbumId = 2, FileName = "/Album1/WoWScrnShot_030115_185856.jpg" }
		};
	}
}
