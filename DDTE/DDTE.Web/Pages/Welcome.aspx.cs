using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DDTE.BL.Facade;
using DDTE.Common;
using DDTE.Model.DTO;
using DDTE.Web.Helpers;

namespace DDTE.Web.Pages
{
	public partial class Welcome : System.Web.UI.Page
	{
		IUnionProvider unionProvider = new DDTE.BL.Providers.UnionProvider();
		NLog.Logger logger = LogHelper.GetLogger("Unions");

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				RebindData();
			}
		}

		protected override void OnPreRender(EventArgs e)
		{
			base.OnPreRender(e);

			btnAddUnion.Visible = SecurityHelper.CanEditUnions();
		}

		void RebindData()
		{
			var unions = unionProvider.List();
			rptrUnions.DataSource= unions;
			rptrUnions.DataBind();
		}

		protected void rptrUnions_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if (e.Item.DataItem != null)
			{
				var union = e.Item.DataItem as UnionDTO;
				if (union != null)
				{
					var rptr = e.Item.FindControl("rptrUnionPrograms") as Repeater;
					if (rptr != null)
					{
						rptr.ItemDataBound += rptrUP_ItemDataBound;

						rptr.DataSource = union.UnionPrograms;
						rptr.DataBind();

						rptr.Visible = rptr.Items.Count > 0;
					}

					var pnlUnionActions = e.Item.FindControl("pnlUnionActions") as Panel;
					if (pnlUnionActions != null)
					{
						pnlUnionActions.Visible = SecurityHelper.CanEditUnions();
					}
				}
			}
		}

		void rptrUP_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if (e.Item.DataItem != null)
			{
				var up = e.Item.DataItem as UnionProgramDTO;
				
				if (up != null)
				{
					var rptrS = e.Item.FindControl("rptrUnionSchedule") as Repeater;
					if (rptrS != null)
					{
						rptrS.DataSource = up.Schedule;
						rptrS.DataBind();

						rptrS.Visible = rptrS.Items.Count > 0;
					}

					var rptrA = e.Item.FindControl("rptrUnionAchievements") as Repeater;
					if (rptrA != null)
					{
						rptrA.DataSource = unionProvider.GroupAchievements(up.Achievements);
						rptrA.DataBind();

						rptrA.Visible = rptrA.Items.Count > 0;
					}
				}
			}
		}
	}
}