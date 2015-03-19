using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.Model.DTO;
using DDTE.Model;

namespace DDTE.BL.Facade
{
	public interface IPhotoProvider
	{
		void AddAlbum(AlbumDTO album);
		void UpdateAlbum(AlbumDTO album);
		List<AlbumDTO> ListAlbums();

		void AddPhoto(PhotoDTO photo);
		void UpdatePhoto(PhotoDTO photo);
		List<Photo> ListPhotos(int albumId);

		/// <summary>
		/// Returns list of photo items (albums/photos)
		/// </summary>
		/// <param name="albumId"></param>
		/// <returns></returns>
		List<PhotoViewerItem> ListPhotoItems(int? albumId);
	}
}
