using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DDTE.Web
{
	public partial class MainRight : DdteMasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			var photoName = (new DDTE.BL.Providers.PhotoProvider()).GetRandomPublicPhotoUrl() ?? String.Empty;
			imgRandom.ImageUrl = photoName.StartsWith("http") ? photoName : DDTE.Common.GeneralHelper.GetTumbPath("/Photos" + photoName);
		}
	}
}