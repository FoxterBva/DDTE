using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DDTE.Web.Controls
{
	public partial class PhotoViewer : System.Web.UI.UserControl
	{
		DDTE.BL.Facade.IPhotoProvider provider = new DDTE.BL.Providers.PhotoProvider();

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				SelectedAlbum = null;
				RebindList();
			}
		}

		protected void rptrAlbums_ItemCommand(object source, RepeaterCommandEventArgs e)
		{
			if (e.CommandName == "SelectAlbum")
			{
				int id;
				var parsed = Int32.TryParse((string)e.CommandArgument, out id);

				SelectedAlbum = parsed ? id : (int?)null;

				RebindList();
			}
		}

		public void RebindList()
		{
			if (SelectedAlbum == null)
			{
				var albums = provider.ListAlbums();

				rptrPhotos.Visible = false;
				rptrAlbums.Visible = true;
				rptrAlbums.DataSource = albums;
				rptrAlbums.DataBind();
			}
			else
			{
				var photos = provider.ListPhotos(SelectedAlbum);

				rptrAlbums.Visible = false;
				rptrPhotos.Visible = true;
				rptrPhotos.DataSource = photos;
				rptrPhotos.DataBind();
			}
		}

		int? SelectedAlbum
		{
			get 
			{
				return (int?)ViewState["SelectedAlbum"];
			}
			set 
			{
				ViewState["SelectedAlbum"] = value;
			}
		}
	}
}