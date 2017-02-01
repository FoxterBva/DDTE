using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DDTE.Web.Pages
{
	public partial class Schedule : System.Web.UI.Page
	{
		NLog.Logger logger = DDTE.Common.LogHelper.GetLogger("Schedule");

		protected void Page_Load(object sender, EventArgs e)
		{
			pnlSchedule.Visible = CanEditSchedule();

			hfDownload.NavigateUrl = GetScheduleDocUrl();
		}

		protected void btnUpload_Click(object sender, EventArgs e)
		{
			if (fuSchedule.HasFile)
			{
				try
				{
					var word = new Microsoft.Office.Interop.Word.Application();
					object missing = System.Reflection.Missing.Value;

					var extension = fuSchedule.FileName.Substring(fuSchedule.FileName.LastIndexOf('.'));

					object scheduleDocPath = AppDomain.CurrentDomain.BaseDirectory + "\\Schedule\\Schedule" + extension;
					object scheduleHtmlPath = AppDomain.CurrentDomain.BaseDirectory + "\\Schedule\\Schedule.html";

					fuSchedule.SaveAs((string)scheduleDocPath);

					word.Documents.Open(ref scheduleDocPath);
					word.Visible = false;
					var doc = word.ActiveDocument;

					object fltDocFormat = 8;
					doc.SaveAs(ref scheduleHtmlPath, ref fltDocFormat);

					word.Quit(ref missing, ref missing, ref missing);

				} catch (Exception ex)
				{
					ltlMessage.Text = ex.ToString();
				}
			}
		}

		string GetScheduleDocUrl()
		{
			try
			{
				var fileProvider = new DDTE.BL.Providers.FileProvider();
				string path = Server.MapPath("~/Schedule");
				var files = fileProvider.ListFiles(path, "Schedule.*");

				var scheduleFile = files.Where(f => !f.FileName.EndsWith("html")).FirstOrDefault();

				return scheduleFile == null ? "javascript: alert('Файл расписания не найден')" : "/FileDownload.ashx?file=" + Page.ResolveUrl("~/Schedule/" + scheduleFile.FileName);
			}
			catch (Exception ex)
			{
				logger.ErrorException("Error", ex);
				return "javascript: alert('Не удалось получить файл расписания')";
			}
		}

		bool CanEditSchedule()
		{
			return Request.IsAuthenticated;
		}
	}
}