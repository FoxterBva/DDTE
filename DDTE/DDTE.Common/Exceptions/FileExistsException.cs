using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.Common.Exceptions
{
	public class FileExistsException : Exception
	{
		public FileExistsException() 
			: base()
		{
		}

		public FileExistsException(string msg)
			: base(msg)
		{
		}

		public FileExistsException(string msg, Exception ex)
			: base(msg, ex)
		{
		}
	}
}
