using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.Model.DTO
{
	public class PhotoResultDTO
	{
		public int Id { get; set; }
		public string Url { get; set; }
		public string PreviewUrl { get; set; }
		public string Title { get; set; }
		public string Description { get; set; }
	}
}
