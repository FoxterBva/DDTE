using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.Model.DTO;

namespace DDTE.BL.Facade
{
	public interface IPhotoProvider
	{
		void AddAlbum(AlbumDTO album);
		void UpdateAlbum(AlbumDTO album);
		List<AlbumDTO> ListAlbums();

		void AddPhoto(PhotoDTO photo);
		void UpdatePhoto(PhotoDTO photo);
		List<PhotoResultDTO> ListPhotos(int? albumId);
	}
}
