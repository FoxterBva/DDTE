using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DDTE.Web.Pages.SpecialSection
{
	public partial class Education : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				documentList.RefreshList();
				dlChoreography.RefreshList();
				dlDecorativeCrafts.RefreshList();
				dlFineArts.RefreshList();
				dlTheater.RefreshList();
				dlVocals.RefreshList();
			}
		}
	}
}