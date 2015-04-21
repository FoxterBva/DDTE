using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DDTE.Web.Helpers
{
	public class MessageFormatter
	{
		public static string GetFormattedErrorMessage(string message, bool encode = true)
		{
			return "<div class='error'>" + (encode ? HttpUtility.HtmlEncode(message) : message) + "</div>";
		}

		public static string GetFormattedSuccessMessage(string message, bool encode = true)
		{
			return "<div class='success'>" + (encode ? HttpUtility.HtmlEncode(message) : message) + "</div>";
		}
	}
}