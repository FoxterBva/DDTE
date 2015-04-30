using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DDTE.BL.Facade;
using DDTE.Common;
using DDTE.Common.Exceptions;
using DDTE.Model.DTO;
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
				BindNews();
			}
		}

		void BindNews()
		{
			var nsp = new Model.Classes.Search.NewsSearchParameters() { };
			if (!SecurityHelper.CanEditNews())
				nsp.IsPublic = true;

			var news = newsProvider.ListBySearch(nsp);

			news.Insert(0, new Model.DTO.NewsDTO() { NewsId = 0 });

			rptrNews.DataSource = news;
			rptrNews.DataBind();
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
					BindNews();
				}
				catch (EntityNotFoundException ex)
				{
					DisplayError("Не удалось удалить новость: " + ex.Message);
				}
				catch (Exception ex)
				{
					logger.ErrorException("Не удалось удалить новость.", ex);
					DisplayError("Не удалось удалить новость.");
				}
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
			var news = new NewsDTO()
			{
				Author = tbAuthor.Text, 
				Content = tbContent.Text,
				Title = tbTitle.Text,
				IsPublic = true					// TODO:
			};

			bool isUpdate = false;

			try
			{
				if (!isUpdate)
				{
					var res = newsProvider.Add(news);
					DisplaySuccess("Новость добавлена.");
				}
				else
				{
					newsProvider.Update(news);
					DisplaySuccess("Новость обновлена.");
				}
				BindNews();
			}
			catch (Exception ex)
			{
				var action = isUpdate ? "обновить" : "добавить";

				logger.ErrorException("Не удалось " + action + " новость.", ex);
				DisplayError("Не удалось " + action + " новость.");
			}
		}

		protected void lbUpdate_Click(object sender, EventArgs e)
		{
			var news = new NewsDTO()
			{
				Author = tbAuthor.Text,
				Content = tbContent.Text,
				Title = tbTitle.Text,
				IsPublic = true					// TODO:
			};

			try
			{
				newsProvider.Update(news);
				DisplaySuccess("Новость обновлена.");
				BindNews();
			}
			catch (Exception ex)
			{
				logger.ErrorException("Не удалось обновить новость.", ex);
				DisplayError("Не удалось обновить новость.");
			}
		}
	}
}