using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DDTE.Common;
using DDTE.Web.Helpers;

namespace DDTE.Web
{
	// for custom auth http://support.microsoft.com/kb/301240; http://tech.pro/tutorial/1216/implementing-custom-authentication-for-aspnet
	public partial class Main : System.Web.UI.MasterPage
	{
		bool isLoginVisible = false;

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void btnLogin_Click(object sender, EventArgs e)
		{
			var username = tbLogin.Text;
			var password = tbPassword.Text;

			// TODO: DB based validation and role seelction
			if (username == "admin" && password == "12345678")
			{
				//System.Web.Security.FormsAuthentication.SetAuthCookie(username, cbRememberMe.Checked);

				var roles = "administrator" + SecurityConstants.AuthCookieRolesSeparator + "editor";

				SecurityHelper.SetAuthenticationCookie(Response, "1", String.Format("{0}{1}{2}{3}{4}", username, SecurityConstants.AuthCookieUserDataSeparator, Request.UserHostAddress, SecurityConstants.AuthCookieUserDataSeparator, roles), cbRememberMe.Checked);
				//Server.Transfer(Request.Path);
				Response.Redirect(Request.Path);
			}
			else
			{ 
				// TODO: display error
				ltlMesssage.Text = "Invalid user";
				isLoginVisible = true;
			}
		}

		protected void btnLogout_Click(object sender, EventArgs e)
		{
			SecurityHelper.Logout();
			Response.Redirect(Request.Path);
		}

		protected override void OnPreRender(EventArgs e)
		{
			pnlLogIn.Visible = !Request.IsAuthenticated;
			pnlLogOut.Visible = Request.IsAuthenticated;

			if (!isLoginVisible)
				pnlLoginContainer.Style[HtmlTextWriterStyle.Display] = "none";
			else
				pnlLoginContainer.Style[HtmlTextWriterStyle.Display] = "block";

			lblGreetings.Text = Request.IsAuthenticated ? (HttpContext.Current.User as DdtePrincipal).CustomData.Name + ", выйти" : "Войти";
		}
	}
}