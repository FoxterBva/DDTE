using DDTE.BL.Facade;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.Common.Exceptions;
using DDTE.Model.DTO;
using DDTE.Model;

namespace DDTE.BL.Providers
{
	public class NewsProvider : DbProviderBase, INewsProvider
	{
		public int Add(NewsDTO news)
		{
			using (var db = GetObjectContext())
			{
				var n = new News()
				{
					Author = news.Author,
					CreatedDate = DateTime.UtcNow,
					IsPublic = news.IsPublic,
					Title = news.Title,
					Content = news.Content,
				};

				db.News.Add(n);
				db.SaveChanges();

				return n.NewsId;
			}
		}

		public NewsDTO Delete(int id)
		{
			using (var db = GetObjectContext())
			{
				var q = (from n in db.News
						 where n.NewsId == id
						select n).FirstOrDefault();

				if (q != null)
				{
					var res = new NewsDTO() 
					{
						NewsId = q.NewsId,
						Title = q.Title,
						Content = q.Content,
						Author = q.Author,
						CreatedDate = q.CreatedDate,
						IsPublic = q.IsPublic
					};

					db.News.Remove(q);
					db.SaveChanges();

					return res;
				}
				else
				{
					throw new EntityNotFoundException("Новость не найдена.");
				}
			}
		}

		public void Update(NewsDTO news)
		{
			using (var db = GetObjectContext())
			{
				var q = (from n in db.News
						 where n.NewsId == news.NewsId
						 select n).FirstOrDefault();

				if (q == null)
				{
					throw new EntityNotFoundException("Новость не найдена.");
				}
				else
				{
					q.Title = news.Title;
					q.Content = news.Content;
					q.Author = news.Author;
					q.IsPublic = news.IsPublic;
					q.ModifiedDate = DateTime.UtcNow;
					db.SaveChanges();	
				}
			}
		}

		public List<NewsDTO> ListBySearch(Model.Classes.Search.NewsSearchParameters searchParameters)
		{
			List<NewsDTO> res = new List<NewsDTO>();

			using (var db = GetObjectContext())
			{
				var q = (from n in db.News
						 where searchParameters.IsPublic == null || n.IsPublic == searchParameters.IsPublic
						 orderby n.CreatedDate descending
						 select n).ToList();

				if (q != null)
					res.AddRange(q.Select(n => new NewsDTO() { 
						NewsId = n.NewsId,
						Title = n.Title,
						Content = n.Content,
						Author = n.Author,
						CreatedDate = n.CreatedDate,
						IsPublic = n.IsPublic
					}));
			}

			return res;
		}
	}
}
