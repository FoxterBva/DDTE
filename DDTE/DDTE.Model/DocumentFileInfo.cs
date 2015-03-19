using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.Model
{
	public class DocumentFileInfo
	{
		public DocumentFileInfo()
		{
			Category = String.Empty;
		}

		public string FileName { get; set; }
		public string RelativePath { get; set; }
		public string Category { get; set; }
	}
}
