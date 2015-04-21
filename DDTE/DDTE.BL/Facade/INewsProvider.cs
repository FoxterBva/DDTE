using DDTE.Model;
using DDTE.Model.Classes.Search;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.Model.DTO;

namespace DDTE.BL.Facade
{
	public interface INewsProvider
	{
		int Add(NewsDTO news);
		NewsDTO Delete(int id);
		void Update(NewsDTO news);

		List<NewsDTO> ListBySearch(Model.Classes.Search.NewsSearchParameters searchParameters);
	}
}
