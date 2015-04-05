using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using DDTE.Common;

namespace DDTE.Web.Helpers
{
	public class DdtePrincipal : GenericPrincipal
	{
		public DdtePrincipal(IIdentity identity, string[] roles) 
			: base(identity, roles)
		{
			CustomData = new CustomPrincipalData();
		}

		public CustomPrincipalData CustomData { get; set; }
	}

	/// <summary>
	/// Additional user information to store in the principal object
	/// </summary>
	public class CustomPrincipalData
	{
		public CustomPrincipalData() { }

		public CustomPrincipalData(string dataStr) : base() 
		{
			var parts = (dataStr ?? String.Empty).Split(new string[1] { SecurityConstants.AuthCookieUserDataSeparator }, StringSplitOptions.None);
			if (parts != null)
			{
				if (parts.Length > 0)
					Name = parts[0];

				if (parts.Length > 1)
					IP = parts[1];
			}
		}

		/// <summary>
		/// Gets string that represents data
		/// </summary>
		public string GetString()
		{
			return Name + SecurityConstants.AuthCookieUserDataSeparator + IP;
		}

		public string IP { get; set; }
		public string Name { get; set; }
	}

	public class SecurityHelper
	{
		public static void SetAuthenticationCookie(HttpResponse response, string id, string data, bool isPersistent)
		{
			var ticket = new FormsAuthenticationTicket
				(
					0,
					id,
					DateTime.Now,
					DateTime.Now.Add(FormsAuthentication.Timeout),
					isPersistent,
					data,
					FormsAuthentication.FormsCookiePath
				);

			string encryptedTicket = FormsAuthentication.Encrypt(ticket);
  
			HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);

			response.Cookies.Add(authCookie);
		}

		public static IPrincipal CreatePrincipalFromTicket(string id, string data)
		{
			var parts = data.Split(new string[1]{ SecurityConstants.AuthCookieUserDataSeparator }, StringSplitOptions.None);
			var roles = parts[2].Split(new string[1]{ SecurityConstants.AuthCookieRolesSeparator }, StringSplitOptions.RemoveEmptyEntries);

			var principal = new DdtePrincipal(new GenericIdentity(id), roles)
			{
				CustomData = new CustomPrincipalData(data)
			};

			return principal;
		}

		public static void Logout()
		{
			FormsAuthentication.SignOut();
		}

		public static bool CanEditAlbum()
		{
			return HttpContext.Current.Request.IsAuthenticated;
		}
	}
}