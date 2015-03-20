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
		readonly string PHOTOS_FOLDER = "Photos";
		DDTE.BL.Facade.IPhotoProvider photoProvider = new DDTE.BL.Providers.PhotoProvider();

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
			else if (e.CommandName == "Delete")
			{
				int id;
				var parsed = Int32.TryParse((string)e.CommandArgument, out id);

				if (SelectedAlbum == null)
				{ 
					// Delete folder
					photoProvider.DeleteAlbum(id);
				}
				else
				{ 
					// Delete photo
					photoProvider.DeletePhoto(id);
				}
			}
		}

		protected void rptrPhotoItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if (e.Item != null)
			{
				var d = e.Item.DataItem as DDTE.Model.DTO.PhotoViewerItem;

				if (d != null)
				{
					var pnlAlbum = e.Item.FindControl("pnlAlbum") as Panel;
					pnlAlbum.Visible = d.ItemType == Model.DTO.PhotoViewerItemType.Album;

					var pnlPhoto = e.Item.FindControl("pnlPhoto") as Panel;
					pnlPhoto.Visible = d.ItemType == Model.DTO.PhotoViewerItemType.Photo;

					if (d.ItemType == Model.DTO.PhotoViewerItemType.Photo)
					{
						var img = e.Item.FindControl("imgPhoto") as System.Web.UI.HtmlControls.HtmlImage;
						if (img != null)
						{
							img.Src = d.ImagePath.StartsWith("http") ? d.ImagePath : Page.ResolveUrl("~/" + PHOTOS_FOLDER + d.ImagePath);
						}
					}
				}
			}
		}

		public void RebindList()
		{
			var items = photoProvider.ListPhotoItems(SelectedAlbum);

			rptrPhotoItems.DataSource = items;
			rptrPhotoItems.DataBind();
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