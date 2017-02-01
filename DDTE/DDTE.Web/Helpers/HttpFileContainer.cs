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

		public string Save(string path)
		{
            var filePath = path + "/" + _file.FileName;
			_file.SaveAs(filePath);

            return filePath;
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

		public string Save(string path)
		{
			var filePath = Path.Combine(path, _fileName);

			using (var imageFile = new FileStream(filePath, FileMode.Create))
			{
				imageFile.Write(_file, 0, _file.Length);
				imageFile.Flush();
			}

            return filePath;

            // tumbnail
            // vb: moved to provider
            //using (var ms = new MemoryStream(_file))
            //{
            //    using (var img = System.Drawing.Image.FromStream(ms))
            //    {
            //        var imgSize = 176;
            //        var ratio = img.Height / imgSize;
            //        using (var tmbImg = img.GetThumbnailImage(img.Width * ratio, img.Height * ratio, null, IntPtr.Zero))
            //        {

            //            var extPos = filePath.LastIndexOf('.');
            //            if (extPos >= 0)
            //            {
            //                var tmbPath = DDTE.Common.GeneralHelper.GetTumbPath(filePath);
            //                tmbImg.Save(tmbPath);
            //            }
            //        }
            //    }
            //}
		}

		public string FileName { get { return _fileName; } }
	}
}