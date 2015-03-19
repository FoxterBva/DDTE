using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DDTE.BL;
using DDTE.BL.Providers;
using DDTE.Common;

namespace DDTE.Web.Pages.SpecialSection
{
	public partial class DocumentsDownload : System.Web.UI.Page
	{
		string documentFolder = AppDomain.CurrentDomain.BaseDirectory + "Documents";

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				documentList.RefreshList();
			}
		}
	}
}