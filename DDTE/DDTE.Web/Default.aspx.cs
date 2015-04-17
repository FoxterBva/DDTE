using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DDTE.BL.Facade;
using DDTE.Web.Helpers;

namespace DDTE.Web
{
	public partial class Default : System.Web.UI.Page
	{
		INewsProvider provider = new DDTE.BL.Providers.NewsProvider();

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				var news = provider.ListBySearch(new Model.Classes.Search.NewsSearchParameters() { });
				
				rptrNews.DataSource = news;
				rptrNews.DataBind();
			}
		}

		protected override void OnPreRender(EventArgs e)
		{
			base.OnPreRender(e);

			pnlAddNews.Visible = SecurityHelper.CanEditNews();
		}
	}
}