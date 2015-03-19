using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NLog;

namespace DDTE.Common
{
	public class LogHelper
	{
		public static Logger GetLogger(string name)
		{
			 return LogManager.GetLogger(name);
		}
	}
}
