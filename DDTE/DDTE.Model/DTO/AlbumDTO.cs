using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.Model.DTO
{
	public class AlbumDTO
	{
		public int Id { get; set; }
		public string Title { get; set; }
		public string Folder { get; set; }
		public bool IsPublic { get; set; }
		public string Description { get; set; }
		public DateTime CreatedDate { get; set; }
        public int PhotoCount { get; set; }
	}
}
