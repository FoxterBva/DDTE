using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.Model.DTO
{
	public class PhotoDTO
	{
		public int Id { get; set; }
		public string Name { get; set; }
		public string Description { get; set; }
		public string Path { get; set; }
		public int AlbumId { get; set; }
	}
}
