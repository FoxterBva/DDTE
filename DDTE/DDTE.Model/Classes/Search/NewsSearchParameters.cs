using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.Model.Classes.Search
{
	public class NewsSearchParameters : SearchParametersBase
	{
		public int NewsId { get; set; }
		public bool? IsPublic { get; set; }
		public string[] TextParts { get; set; }
	}
}
