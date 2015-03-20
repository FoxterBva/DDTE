using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DDTE.BL;
using DDTE.BL.Facade;
using DDTE.BL.Providers;
using DDTE.Common;

namespace DDTE.Web.Controls
{
	public partial class DocumentsList : System.Web.UI.UserControl
	{
		NLog.Logger logger = LogHelper.GetLogger("DocumentList");
		public static readonly string DocumentFolder = "Documents";
		string physicalFolder = AppDomain.CurrentDomain.BaseDirectory + DocumentFolder;

		IDocumentProvider documentProvider = new DocumentProvider();
		bool displayAddFileDialog = false;

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected override void OnPreRender(EventArgs e)
		{
			pnlAddDocument.Visible = PermissionHelper.CanAddDocuments(Request.IsAuthenticated);

			if (!String.IsNullOrWhiteSpace(Category))
			{
				tbCategory.Text = Category;
				tbCategory.Enabled = false;
			}

			if (displayAddFileDialog)
				pnlFormContainer.Style[HtmlTextWriterStyle.Display] ="block";
			else
				pnlFormContainer.Style[HtmlTextWriterStyle.Display] = "none";
		}

		protected void btnUpload_Click(object sender, EventArgs e)
		{
			int failCounter = 0;
			List<string> failReasons = new List<string>();

			if (fuDocuments.HasFile)
			{
				HttpFileCollection hfc = Request.Files;

				for (int i = 0; i <= hfc.Count - 1; i++)
				{
					HttpPostedFile hpf = hfc[i];
					try
					{
						var fileName = hpf.FileName;

						var directoryPath = Path.Combine(physicalFolder, tbCategory.Text.Trim());

						if (!Directory.Exists(directoryPath))
						{
							try
							{
								Directory.CreateDirectory(directoryPath);
							}
							catch (Exception ex)
							{
								displayAddFileDialog = true;
								logger.Error("DocumentList.Upload: Failed to create directory " + directoryPath, ex);
								ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage("Не могу создать директорию");
								return;
							}
						}

						if (!File.Exists(directoryPath + "\\" + fileName))
						{
							hpf.SaveAs(directoryPath + "\\" + fileName);
						}
						else
						{
							displayAddFileDialog = true;
							ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage("Файл '" + fileName + "' уже существует");
							return;
						}
					}
					catch (Exception ex)
					{
						displayAddFileDialog = true;
						logger.Error("DocumentList.Upload: Unexpected error", ex);
						ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage("Не получилось загрузить файл");
						return;
					}
				}

				if (failCounter != 0)
				{
					// TODO: some information
				}

				RefreshList();
			}
			else
			{
				displayAddFileDialog = true;
				ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage("Файл не выбран");
			}
		}

		public void RefreshList()
		{ 
			var fileProvider = new FileProvider();
			string path = Server.MapPath("~/" + DocumentFolder);
			var files = fileProvider.ListFiles(path, String.Empty);

			var documents = documentProvider.ListDocuments(this.Category, files);

			rptrFiles.DataSource = documents;
			rptrFiles.DataBind();
		}

		protected void rptrFiles_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if (e.Item != null)
			{
				var dto = e.Item.DataItem as DDTE.Model.DTO.DocumentDTO;
				if (dto != null)
				{
					var link = e.Item.FindControl("hpDocumentLink") as HyperLink;
					if (link != null)
					{
						link.NavigateUrl = dto.IsLocal ? Page.ResolveUrl("~/" + DocumentFolder + dto.Link) : dto.Link;
						link.Target = "_blank";
					}

					var lbDelete = e.Item.FindControl("lbDelete") as LinkButton;
					if (lbDelete != null)
					{
						lbDelete.Visible = PermissionHelper.CanDeleteDocuments(Request.IsAuthenticated);
					}
				}
			}
		}

		protected void rptrFiles_ItemCommand(object source, RepeaterCommandEventArgs e)
		{
			if (e.CommandName == "Delete")
			{
				try
				{
					if (!PermissionHelper.CanDeleteDocuments(Request.IsAuthenticated))
					{
						ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage("Недостаточно прав для удаления");
					}

					var path = Path.Combine(physicalFolder, ((string)e.CommandArgument).Remove(0, 1).Replace("/", "\\"));
					File.Delete(path);
					RefreshList();
				}
				catch (Exception ex)
				{
					logger.Error("DocumentList.Delete: Unexpected error", ex);
					ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage("Не получилось удалить файл");
				}
			}
		}
		// Page.ResolveUrl("~/Documents/" + Eval("FileName"))
		public string Category { get; set; }
	}
}