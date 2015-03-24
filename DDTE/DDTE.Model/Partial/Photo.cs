using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.Model
{
	public partial class Photo
	{
		public int Id { get; set; }
		public int AlbumId { get; set; }
		public string FileName { get; set; }
		public string Title { get; set; }
		public string Description { get; set; }
	}
}
