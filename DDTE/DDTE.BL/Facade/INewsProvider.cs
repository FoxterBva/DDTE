using DDTE.Model;
using DDTE.Model.Classes.Search;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.BL.Facade
{
	public interface INewsProvider
	{
		int Add(News news);
		void Delete(News news);
		void Delete(int id);
		void Update(News news);

		List<News> ListBySearch(NewsSearchParameters seachParameters);
	}
}
