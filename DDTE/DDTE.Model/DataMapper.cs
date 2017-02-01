using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.Model.DTO;

namespace DDTE.Model
{
	public class DataMapper
	{
		public AlbumDTO GetAlbumDTO(Album album)
		{
			var res = new AlbumDTO() 
			{ 
				Id = album.AlbumId,
				Title = album.Title,
				IsPublic = album.IsPublic,
				Description = album.Description
			};

            if (album.Photos != null)
                res.PhotoCount = album.Photos.Count;

			return res;
		}

		public Album GetAlbum(AlbumDTO album)
		{
			var res = new Album() 
			{
				AlbumId = album.Id,
				Title = album.Title,
				IsPublic = album.IsPublic,
				Description = album.Description
			};

			return res;
		}
	}
}
