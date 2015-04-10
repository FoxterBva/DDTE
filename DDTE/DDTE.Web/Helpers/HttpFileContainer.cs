using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DDTE.BL.Facade;

namespace DDTE.Web.Helpers
{
	public class HttpFileContainer : IFileContainer
	{
		HttpPostedFile _file;

		public HttpFileContainer(HttpPostedFile file)
		{
			_file = file;
		}

		public void Save(string path)
		{
			_file.SaveAs(path + "/" + _file.FileName);
		}
	}
}