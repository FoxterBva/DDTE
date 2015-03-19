using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.Common
{
	public class MessageFormatter
	{
		public static string GetFormattedErrorMessage(string message)
		{
			return "<div class='error'>" + message + "</div>";
		}
	}
}
