using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DDTE.Common.Exceptions
{
	public class EntityNotFoundException : Exception
	{
		public EntityNotFoundException() 
			: base()
		{
		}

		public EntityNotFoundException(string msg)
			: base(msg)
		{
		}

		public EntityNotFoundException(string msg, Exception ex)
			: base(msg, ex)
		{
		}
	}
}
