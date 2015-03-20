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
				Id = album.Id,
				Folder = album.FolderName,
				Title = album.Title,
				IsPublic = album.IsPublic,
				Description = album.Description
			};

			return res;
		}

		public Album GetAlbum(AlbumDTO album)
		{
			var res = new Album() 
			{ 
				Id = album.Id,
				FolderName = album.Folder,
				Title = album.Title,
				IsPublic = album.IsPublic,
				Description = album.Description
			};

			return res;
		}
	}
}
