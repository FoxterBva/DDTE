using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.Model;

namespace DDTE.BL.Providers
{
	public class FileProvider
	{
		public List<DocumentFileInfo> ListFiles(string path, string pattern)
		{
			List<DocumentFileInfo> res = new List<DocumentFileInfo>();

			if (String.IsNullOrWhiteSpace(pattern))
				pattern = "*";

			DirectoryInfo di = new DirectoryInfo(path);
			foreach (var f in di.GetFiles(pattern, SearchOption.AllDirectories))
			{
				var directoryName = f.DirectoryName.Replace(path, String.Empty);
				var category = directoryName;
				if (category.StartsWith("\\"))
					category = category.Remove(0, 1);

				res.Add(new DocumentFileInfo() 
				{ 
					FileName = f.Name,
					RelativePath = directoryName,
					Category = category
				});
			}

			return res;
		}
	}
}
