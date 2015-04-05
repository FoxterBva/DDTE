using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using NLog;
using DDTE.Common;
using DDTE.Web;
using System.Security.Principal;

namespace DDTE.Web
{
	public class Global : HttpApplication
	{
		Logger logger = LogManager.GetCurrentClassLogger();

		void Application_Start(object sender, EventArgs e)
		{
			// Code that runs on application startup
			BundleConfig.RegisterBundles(BundleTable.Bundles);
			AuthConfig.RegisterOpenAuth();
			RouteConfig.RegisterRoutes(RouteTable.Routes);

			logger.Debug("Application started.");
		}

		void Application_End(object sender, EventArgs e)
		{
			//  Code that runs on application shutdown
			logger.Debug("Application ended.");
		}

		string RequestSessionId = "SessionCacheId";
		protected void Session_Start(object sender, EventArgs e)
		{
			var sessionId = Guid.NewGuid();
			Session[RequestSessionId] = sessionId.ToString().ToLower();
			logger.Debug(String.Format("Session started: {0}, ip: {1} (u-a:{2})", Session[RequestSessionId], Request.UserHostAddress, GetBrowserInfo(Request)));
		}

		protected void Session_End(object sender, EventArgs e)
		{
			var sessionIdstr = Session[RequestSessionId].ToString();
			logger.Debug(String.Format("Session ended: {0}", sessionIdstr));
		}

		protected void FormsAuthentication_OnAuthenticate(object sender, FormsAuthenticationEventArgs args)
		{ 
			// TODO: process auth mechanism
			HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
			if (authCookie != null)
			{
				FormsAuthenticationTicket authTicket = null;

				try
				{
					authTicket = FormsAuthentication.Decrypt(authCookie.Value);
				}
				catch
				{
					// TODO: faield to decrypt cookie. Should we care about this error?
					return;
				}

				if (authTicket == null)
					return;

				IIdentity identity = new FormsIdentity(authTicket);
				IPrincipal principal = DDTE.Web.Helpers.SecurityHelper.CreatePrincipalFromTicket(authTicket.Name, authTicket.UserData);

				Context.User = principal;
			}
		}

		void Application_Error(object sender, EventArgs e)
		{
			var ex = Server.GetLastError().GetBaseException();
			var httpEx = ex as HttpException;
			var browserInfo = GetBrowserInfo(Request);

			if (httpEx != null)
			{
				var errorCode = httpEx.GetHttpCode();
				if ((errorCode == 404) || (errorCode == 403))
				{
					logger.Warn(String.Format("Error code {0} Redirect from {1}", errorCode, this.Request.Url.ToString()));
				}
				else
				{
					logger.ErrorException(String.Format("App http error at {0}  ip:{1}  session: {2}  u-a:{3}", Request.Url.ToString(), Request.UserHostAddress, Session[RequestSessionId], browserInfo), ex);
				}
			}
			else
			{
				logger.ErrorException(String.Format("App error at {0}  ip:{1}  session: {2}  u-a:{3}", Request.Url.ToString(), Request.UserHostAddress, Session[RequestSessionId], browserInfo), ex);
			}

			logger.ErrorException("Unexpected application error", ex);
		}

		string GetBrowserInfo(HttpRequest request)
		{
			if (request == null)
				return "nullrequest";

			return request.Browser == null ? "null" : String.Format("{0}-{1}({2})", request.Browser.Browser, request.Browser.Version, request.Browser.Type);
		}
	}
}
