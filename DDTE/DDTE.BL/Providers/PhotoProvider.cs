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
				Name = "First Album"
			});

			albums.Add(new AlbumDTO()
			{
				Id = 2,
				Folder = "",
				Description = "This is a Second Album",
				IsPublic = true,
				Name = "Second Album"
			});

			return albums;
		}

		public void AddPhoto(PhotoDTO photo)
		{
			throw new NotImplementedException();
		}

		public void UpdatePhoto(PhotoDTO photo)
		{
			throw new NotImplementedException();
		}

		public List<PhotoResultDTO> ListPhotos(int? albumId)
		{
			var listFiles = new List<System.IO.FileInfo>();
			var listDbPhotos = new List<Photo>();

			var res = new List<PhotoResultDTO>();

			foreach (var file in listFiles)
			{
				var dbPhoto = listDbPhotos.FirstOrDefault(p => file.Name.Equals(p.FileName, StringComparison.InvariantCultureIgnoreCase));

				if (dbPhoto == null)
					dbPhoto = new Photo();

				res.Add(new PhotoResultDTO() { 
					Description = dbPhoto.Description,
					Title = dbPhoto.Title,
					
				});
			}

			return res;
		}
	}
}
