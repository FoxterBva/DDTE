using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace DDTE.Web
{
	public class DdteMasterPage : MasterPage
	{
		protected override void OnInit(EventArgs e)
		{
			base.OnInit(e);

			//AddBlindPanel(Page.Form);

            //if (!IsPostBack)
            //    DisplayBlindSection = true && Request.IsAuthenticated;

            var blndPanel = (DDTE.Web.Controls.BlindPanel)Page.LoadControl("~/Controls/BlindPanel.ascx");
            blndPanel.SmallSizeAction += btnSmallText_Click;
            blndPanel.MediumSizeAction += btnMediumText_Click;
            blndPanel.LargeSizeAction += btnLargeText_Click;
            blndPanel.BlackOnWhiteAction += btnBlackWhite_Click;
            blndPanel.WhiteOnBlackAction += btnWhiteBlack_Click;
            blndPanel.StandardBgAction += btnStandardBg_Click;
            Page.Form.Controls.Add(blndPanel);
		}

		protected override void OnPreRender(EventArgs e)
		{
			base.OnPreRender(e);

            //if (DisplayBlindSection)
            //{
				RegisterStyles(ColorScheme, FontSize);
            //}

            //(Page.Form.FindControl("pnlBlind") as Panel).Visible = DisplayBlindSection;
		}

		#region Partial-blind view

		protected Panel AddBlindPanel(Control container)
		{
			var panel = new Panel();
			panel.ID = "pnlBlind";
			panel.CssClass = "blind-panel";

			var controlContainer = new Panel();
			controlContainer.CssClass = "controls";
			panel.Controls.Add(controlContainer);

			var togglePanel = new Panel();
			togglePanel.CssClass = "pnl-toggle";
			togglePanel.Attributes["onclick"] = "$(this).parent().toggleClass('collapsed'); $(this).prop('title', $(this).prop('title') == 'развернуть' ? 'свернуть' : 'развернуть')";
			togglePanel.Attributes["title"] = "свернуть";
			panel.Controls.Add(togglePanel);

			var btnSmallText = new LinkButton();
			btnSmallText.ID = "btnSmallText";
			//btnSmallText.ImageUrl = "/images/blnd-small.png";
			btnSmallText.CssClass = "blind-btn blnd-small";
			btnSmallText.ToolTip = "Малый размер шрифта";
			btnSmallText.Click += btnSmallText_Click;

			var btnMediumText = new LinkButton();
			btnMediumText.ID = "btnMediumText";
			//btnMediumText.ImageUrl = "/images/blnd-med.png";
			btnMediumText.CssClass = "blind-btn blnd-med";
			btnSmallText.ToolTip = "Средний размер шрифта";
			btnMediumText.Click += btnMediumText_Click;

			var btnLargeText = new LinkButton();
			btnLargeText.ID = "btnLargeText";
			//btnLargeText.ImageUrl = "/images/blnd-large.png";
			btnLargeText.CssClass = "blind-btn blnd-large";
			btnLargeText.Click += btnLargeText_Click;

			var btnBlackWhite = new LinkButton();
			btnBlackWhite.ID = "btnBlackWhite";
			//btnBlackWhite.ImageUrl = "/images/blnd-blackonwhite.png";
			btnBlackWhite.CssClass = "blind-btn blnd-blackonwhite";
			btnSmallText.ToolTip = "Большой размер шрифта";
			btnBlackWhite.Click += btnBlackWhite_Click;

			var btnWhiteBlack = new LinkButton();
			btnWhiteBlack.ID = "btnWhiteBlack";
			//btnWhiteBlack.ImageUrl = "/images/blnd-whiteonblack.png";
			btnWhiteBlack.CssClass = "blind-btn blnd-whiteonblack";
			btnWhiteBlack.Click += btnWhiteBlack_Click;

			var btnStandardBg = new LinkButton();
			btnStandardBg.ID = "btnStandardBg";
			//btnStandardBg.ImageUrl = "/images/blnd-default.png";
			btnStandardBg.CssClass = "blind-btn blnd-default";
			btnStandardBg.Click += btnStandardBg_Click;

			controlContainer.Controls.Add(btnSmallText);
			controlContainer.Controls.Add(btnMediumText);
			controlContainer.Controls.Add(btnLargeText);
			controlContainer.Controls.Add(btnBlackWhite);
			controlContainer.Controls.Add(btnWhiteBlack);
			controlContainer.Controls.Add(btnStandardBg);

			// vb: used to prevent multiple controll add
			if (container.FindControl("pnlBlind") == null)
				container.Controls.Add(panel);

			return panel;
		}

		void RegisterStyles(int colorScheme, int fontSize)
		{
			var style = String.Format("body {{ {0} }}",
				fontSize == 0 ? "" : fontSize == 1 ? "font-size: 16px !important;" : fontSize == 2 ? "font-size: 18px !important;" : "");

			var ctrl = new HtmlGenericControl("style");
			ctrl.Attributes.Add("type", "text/css");
			ctrl.InnerHtml = style;
			Page.Header.Controls.Add(ctrl);

			if (colorScheme == -1 || colorScheme == 1)
			{
				var ctrl2 = new HtmlGenericControl("link");
				
				if (colorScheme == -1)
					ctrl2.Attributes.Add("href", "/content/adjustments/black-white.css");
				else if (colorScheme == 1)
					ctrl2.Attributes.Add("href", "/content/adjustments/white-black.css");

				ctrl2.Attributes.Add("rel", "stylesheet");
				ctrl2.InnerHtml = "";
				Page.Header.Controls.Add(ctrl2);
			}
		}

		void btnStandardBg_Click(object sender, EventArgs e)
		{
			ColorScheme = 0;
		}

		void btnWhiteBlack_Click(object sender, EventArgs e)
		{
			ColorScheme = 1;
		}

		void btnBlackWhite_Click(object sender, EventArgs e)
		{
			ColorScheme = -1;
		}

		void btnLargeText_Click(object sender, EventArgs e)
		{
			FontSize = 2;
		}

		void btnMediumText_Click(object sender, EventArgs e)
		{
			FontSize = 1;
		}

		void btnSmallText_Click(object sender, EventArgs e)
		{
			FontSize = 0;
		}

		protected bool DisplayBlindSection 
		{
			get { return (bool)(Session["DisplayBlindSection"] ?? false); }
			set { Session["DisplayBlindSection"] = value; }
		}
		
		protected int FontSize 
		{
			get { return (int)(Session["FontSize"] ?? 0); }
			set { Session["FontSize"] = value; }
		}

		protected int ColorScheme 
		{
			get { return (int)(Session["ColorScheme"] ?? 0); }
			set { Session["ColorScheme"] = value; }
		}

		#endregion
	}
}