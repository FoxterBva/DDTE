using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DDTE.Model.DTO
{
	public class NewsDTO
	{
		public int NewsId { get; set; }
		public string Title { get; set; }
		public string Content { get; set; }
		public string Author { get; set; }
		public DateTime CreatedDate { get; set; }
		public bool IsPublic { get; set; }
	}
}
