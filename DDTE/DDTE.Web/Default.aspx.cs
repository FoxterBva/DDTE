using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DDTE.BL.Facade;
using DDTE.Common;
using DDTE.Common.Exceptions;
using DDTE.Web.Helpers;

namespace DDTE.Web
{
	public partial class Default : System.Web.UI.Page
	{
		NLog.Logger logger = LogHelper.GetLogger("News");
		INewsProvider newsProvider = new DDTE.BL.Providers.NewsProvider();

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				var nsp = new Model.Classes.Search.NewsSearchParameters() { };
				if (!SecurityHelper.CanEditNews())
					nsp.IsPublic = true;

				var news = newsProvider.ListBySearch(nsp);

				news.Insert(0, new Model.DTO.NewsDTO() { NewsId = 0 });

				rptrNews.DataSource = news;
				rptrNews.DataBind();
			}
		}

		protected override void OnPreRender(EventArgs e)
		{
			base.OnPreRender(e);

			pnlAddNews.Visible = SecurityHelper.CanEditNews();
			pnlEditForm.Visible = SecurityHelper.CanEditNews();
		}

		protected void rptrNews_ItemCommand(object source, RepeaterCommandEventArgs e)
		{
			if ("Delete".Equals(e.CommandName, StringComparison.InvariantCultureIgnoreCase))
			{
				try
				{
					var news = newsProvider.Delete(Int32.Parse((string)e.CommandArgument));
					DisplaySuccess(String.Format("Новость '{0}' удалена.", HttpUtility.HtmlEncode(news.Title)));
				}
				catch (EntityNotFoundException ex)
				{
					DisplayError("Не удалось удалить новость: " + ex.Message);
				}
				catch (Exception ex)
				{
					logger.Error("Не удалось удалить новость.", ex);
					DisplayError("Не удалось удалить новость.");
				}
			}
			else if ("Submit".Equals(e.CommandName, StringComparison.InvariantCultureIgnoreCase))
			{ 

			}
		}

		void DisplayError(string message)
		{
			ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage(message);
		}

		void DisplaySuccess(string message)
		{
			ltlMessage.Text = MessageFormatter.GetFormattedSuccessMessage(message);
		}

		protected void lbSubmit_Click(object sender, EventArgs e)
		{
			DisplaySuccess("Новость добавлена");
		}
	}
}