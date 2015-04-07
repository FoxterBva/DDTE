using DDTE.Web.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DDTE.Web.Pages
{
	public partial class GalleryAng : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected override void OnPreRender(EventArgs e)
		{
			base.OnPreRender(e);

			pnlAddAlbum.Visible = SecurityHelper.CanEditAlbum();
			pnlAddPhoto.Visible = SecurityHelper.CanEditPhoto();
			ltlAlbumActions.Visible = SecurityHelper.CanEditAlbum();
		}
	}
}