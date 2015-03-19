using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.Model.DTO
{
	public class DocumentDTO
	{
		/// <summary>
		/// Category
		/// </summary>
		public string Category { get; set; }

		/// <summary>
		/// Name to display on the link
		/// </summary>
		public string LinkName { get; set; }

		/// <summary>
		/// Link to the file
		/// </summary>
		public string Link { get; set; }

		public bool IsLocal { get; set; }
	}
}
