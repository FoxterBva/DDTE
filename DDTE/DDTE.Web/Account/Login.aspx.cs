using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DDTE.Web.Account
{
	public partial class Login : Page
	{
		protected override void OnInit(EventArgs e)
		{
			base.OnInit(e);

			ctrLogin.Authenticate += ctrLogin_Authenticate;
		}

		void ctrLogin_Authenticate(object sender, AuthenticateEventArgs e)
		{
			var login = sender as WebControl;
			var name = (login.FindControl("UserName") as TextBox).Text;
			var password = (login.FindControl("Password") as TextBox).Text;

			if (name == "admin" && password == "12345678")
			{
				e.Authenticated = true;
			}
			else
			{
				e.Authenticated = false;
			}
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			RegisterHyperLink.NavigateUrl = "Register";
			OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];

			var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
			if (!String.IsNullOrEmpty(returnUrl))
			{
				RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
			}
		}
	}
}