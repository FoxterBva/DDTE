using DDTE.BL.Facade;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.BL.Providers
{
	public class NewsProvider : INewsProvider
	{
		public int Add(Model.News news)
		{
			throw new NotImplementedException();
		}

		public void Delete(Model.News news)
		{
			throw new NotImplementedException();
		}

		public void Delete(int id)
		{
			throw new NotImplementedException();
		}

		public void Update(Model.News news)
		{
			throw new NotImplementedException();
		}

		public List<Model.News> ListBySearch(Model.Classes.Search.NewsSearchParameters seachParameters)
		{
			List<Model.News> res = new List<Model.News>();

			res.Add(new Model.News()
			{
				Id = 1,
				Title = "Первая новость!",
				Author = "Foxter",
				Content = "Контент новости. Он, конечно, меньше чем хотелось бы, но придумывать очень лениво :)",
				CreatedDate = new DateTime(2015, 03, 24, 19, 19, 20),
			});

			res.Add(new Model.News()
			{
				Id = 1,
				Title = "Вторая новость!",
				Author = "Аноним",
				Content = "Вторая новость почему-то тоже размером не блещет...",
				CreatedDate = new DateTime(2015, 03, 24, 19, 21, 20),
			});

			return res;
		}
	}
}
