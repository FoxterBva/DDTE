using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.Model.DTO;
using DDTE.Model;
using System.IO;

namespace DDTE.BL.Facade
{
	public interface IPhotoProvider
	{
		void CreateAlbum(AlbumDTO album);
		void UpdateAlbum(AlbumDTO album);
		List<AlbumDTO> ListAlbums();
		void DeleteAlbum(int id);
		void DeleteAlbum(string folder);

		void AddPhoto(PhotoDTO photo, Stream photoStream, string photoPath);
		void UpdatePhoto(PhotoDTO photo);
		List<Photo> ListPhotos(int albumId);
		void DeletePhoto(int id);

		/// <summary>
		/// Returns list of photo items (albums/photos)
		/// </summary>
		/// <param name="albumId"></param>
		/// <returns></returns>
		List<PhotoViewerItem> ListPhotoItems(int? albumId);
	}
}
