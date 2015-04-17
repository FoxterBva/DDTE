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
				NewsId = 1,
				Title = "Первая новость!",
				Author = "Foxter",
				Content = "Контент новости. Он, конечно, меньше чем хотелось бы, но придумывать очень лениво :)",
				CreatedDate = new DateTime(2015, 03, 24, 19, 19, 20),
			});

			res.Add(new Model.News()
			{
				NewsId = 2,
				Title = "Вторая новость!",
				Author = "Аноним",
				Content = "Вторая новость почему-то тоже размером не блещет...",
				CreatedDate = new DateTime(2015, 03, 24, 19, 21, 20),
			});

			res.Add(new Model.News()
			{
				NewsId = 3,
				Title = "Новость про квадратик",
				Author = "Квадратик",
				Content = "<p>Жил был квадратик</p><div style='border: 1px solid Black;height: 100px;width: 100px; background-color: yellow'></div><p>Жил и <strong>не тужил</strong></p><p>На этой радостной ноте мы заканчиваем нашу новость!</p>",
				CreatedDate = DateTime.Now,
			});

			res.Add(new Model.News()
			{
				NewsId = 3,
				Title = "Длинная новость из будущего",
				Author = "Кто-то",
				Content = "Очень странная и длинная новость пришедшая к нам, видимо, из будущего! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ",
				CreatedDate = new DateTime(2016, 03, 24, 19, 21, 20),
			});

			res = res.OrderByDescending(n => n.CreatedDate).ToList();

			return res;
		}
	}
}
