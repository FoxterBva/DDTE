using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DDTE.BL.Facade;
using System.IO;
using System.Drawing;

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

		public string FileName { get { return _file.FileName; } }
	}

	public class ByteFileContainer : IFileContainer
	{
		byte[] _file;
		string _fileName;

		public ByteFileContainer(byte[] file, string fileName)
		{
			_file = file;
			_fileName = fileName;
		}

		public void Save(string path)
		{
			var filePath = Path.Combine(path, _fileName);
			//using (MemoryStream ms = new MemoryStream(_file))
			//{
			//	//Image image = Image.FromStream(ms);
			//	//image.Save(filePath);
			//	using (Bitmap bm2 = new Bitmap(ms))
			//	{
			//		bm2.Save(Path.Combine(path, _fileName));
			//	}
			//}
			using (var imageFile = new FileStream(filePath, FileMode.Create))
			{
				imageFile.Write(_file, 0, _file.Length);
				imageFile.Flush();
			}

			
		}

		public string FileName { get { return _fileName; } }
	}
}