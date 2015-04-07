using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using DDTE.Common;

namespace DDTE.Web
{
	/// <summary>
	/// Summary description for FileDownload
	/// </summary>
	public class FileDownload : IHttpHandler
	{
		NLog.Logger logger = LogHelper.GetLogger("FileDownload");

		public void ProcessRequest(HttpContext context)
		{
			// Documents/...
			var path = context.Request.QueryString["File"];

			try
			{
				if (!String.IsNullOrEmpty(path) && path.StartsWith("/" + DDTE.Web.Controls.DocumentsList.DocumentFolder))
				{

					path = path.Remove(0, 1).Replace("/", "\\");

					FileInfo file = new FileInfo(AppDomain.CurrentDomain.BaseDirectory + path);
					context.Response.Clear();
					context.Response.ClearHeaders();
					context.Response.ClearContent();
					context.Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
					context.Response.AddHeader("Content-Length", file.Length.ToString());
					context.Response.ContentType = "text/plain";
					
					context.Response.TransmitFile(file.FullName);

					context.Response.Flush();
					context.Response.End();
				}
				else
				{
					ReturnError(context, "Неверное имя файла");
				}
			}
			catch (Exception ex)
			{
				logger.ErrorException("FileDownload: unexpected error", ex);
				ReturnError(context, "Не удалось загрузить документ.");
			}
		}

		void ReturnError(HttpContext context, string errorMsg)
		{
			context.Response.Clear();
			context.Response.ClearContent();

			context.Response.Write(errorMsg);

			context.Response.Flush();
			context.Response.End();
		}

		public bool IsReusable
		{
			get
			{
				return false;
			}
		}
	}
}