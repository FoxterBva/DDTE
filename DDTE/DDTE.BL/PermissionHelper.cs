using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.BL
{
	public class PermissionHelper
	{
		public static bool CanEditNews(string[] roles)
		{
			//return roles.Contains("ContentEditor") || roles.Contains("Admin"); 
			return true;
		}

		//public static bool CanEditNews(System.Security.Principal.IPrincipal principal)
		//{
		//	//return roles.Contains("ContentEditor") || roles.Contains("Admin"); 
		//	return true;
		//}

		public static bool CanAddDocuments(string[] roles)
		{
			//return roles.Contains("Admin");
			return true;
		}

		public static bool CanAddDocuments(bool canAdd)
		{
			return canAdd;
		}

		public static bool CanDeleteDocuments(bool canAdd)
		{
			return CanAddDocuments(canAdd);
		}

		//public static bool CanAddDocuments(System.Security.Principal.IPrincipal principal)
		//{
		//	if (identity is DdteIde)

		//	return true;
		//}
	}
}
