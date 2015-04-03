using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.Model;

namespace DDTE.BL.Providers
{
	public class DbProviderBase
	{
		protected DdteDBEntitiesConn GetObjectContext()
		{
			return new DdteDBEntitiesConn();
		}
	}
}
