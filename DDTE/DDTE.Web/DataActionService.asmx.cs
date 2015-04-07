using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using DDTE.BL.Facade;
using DDTE.Common;
using DDTE.Model.DTO;
using NLog;

namespace DDTE.Web
{
	/// <summary>
	/// Summary description for DataActionService
	/// </summary>
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.ComponentModel.ToolboxItem(false)]
	[System.Web.Script.Services.ScriptService]
	public class DataActionService : System.Web.Services.WebService
	{
		Logger logger = LogHelper.GetLogger("DataService");
		IPhotoProvider photoProvider = new DDTE.BL.Providers.PhotoProvider();

		public ListPhotosResult ListPhotos(int albumId)
		{
			var res = new ListPhotosResult();

			try
			{
				var items = photoProvider.ListPhotoItems(albumId);

				return res;
			}
			catch (Exception ex)
			{
				res.ErrorMessage = "Unexpected error";
				LogError("ListPhotos", "Unexpected error", ex);
				return res;
			}
		}

		[WebMethod]
		public ListPhotoItemResult ListPhotoItems(int albumId)
		{

			ListPhotoItemResult res = new ListPhotoItemResult();

			try
			{
				var items = photoProvider.ListPhotoItems(albumId >= 0 ? albumId : (int?)null);
				foreach (var i in items)
					i.ImagePath = i.ImagePath.StartsWith("http") ? i.ImagePath : "/Photos" + i.ImagePath;

				res.PhotoItems = items;
			} 
			catch (Exception ex)
			{
				res.ErrorMessage = "Не удалось получить список объектов.";
				LogError("ListPhotoItems", "Unexpected error", ex);
			}

			return res;
		}

		[WebMethod]
		public ServiceResultBase CreateAlbum(string title, string description, bool isPublic)
		{
			var res = new ServiceResultBase();

			try
			{
				if (!CanEditAlbums())
				{
					res.ErrorMessage = "Недостаточно прав";
					return res;
				}

				AlbumDTO album = new AlbumDTO()
				{
					Description = description,
					IsPublic = isPublic,
					Title = title
				};

				photoProvider.CreateAlbum(album, HttpRuntime.AppDomainAppPath + "\\Photos");
			}
			catch (Exception ex)
			{
				res.ErrorMessage = "Не удалось создать альбом";
				LogError("CreateAlbum", "Unexpected error", ex);
			}

			return res;
		}

		[WebMethod]
		public ServiceResultBase UpdateAlbum(int albumId, string title, string description, bool isPublic)
		{
			var res = new ServiceResultBase();

			try
			{
				if (!CanEditAlbums())
				{
					res.ErrorMessage = "Недостаточно прав";
					return res;
				}

				AlbumDTO album = new AlbumDTO()
				{
					Id = albumId,
					Description = description,
					IsPublic = isPublic,
					Title = title
				};

				photoProvider.UpdateAlbum(album);
			}
			catch (Exception ex)
			{
				res.ErrorMessage = "Не удалось создать альбом";
				LogError("UpdateAlbum", "Unexpected error", ex);
			}

			return res;
		}

		[WebMethod]
		public ServiceResultBase DeleteAlbum(string albumId)
		{
			var res = new ServiceResultBase();

			try
			{
				if (!CanEditAlbums())
				{
					res.ErrorMessage = "Недостаточно прав";
					return res;
				}

				photoProvider.DeleteAlbum(Int32.Parse(albumId), HttpRuntime.AppDomainAppPath + "\\Photos");
			}
			catch (Exception ex)
			{
				res.ErrorMessage = "Не удалось создать альбом";
				LogError("CreateAlbum", "Unexpected error", ex);
			}

			return res;
		}

		//public CreateUpdateAlbumResult CreateUpdateAlbum(int? albumId, string albumName, string albumDescription, bool isPublic)
		//{
		//	var res = new CreateUpdateAlbumResult();

		//	try
		//	{ 
		//		if (!HttpContext.Current.Request.IsAuthenticated)
		//		{
		//			res.ErrorMessage = "You have no permissions to do it.";
		//			return res;
		//		}

		//		photoProvider.ProcessAlbum(new AlbumDTO() 
		//		{
		//			Id
		//		});

		//		return res;
		//	}
		//	catch (Exception ex)
		//	{
		//		res.ErrorMessage = "Unexpected error";
		//		LogError("CreateUpdateAlbum", "Unexpected error", ex);

		//		return res;
		//	}
		//}

		bool CanEditAlbums()
		{
			return HttpContext.Current.Request.IsAuthenticated;
		}

		void LogError(string method, string msg, Exception ex)
		{
			logger.ErrorException("DataActionService." + method + ": " + msg, ex);
		}
	}

	public class ServiceResultBase
	{
		public string ErrorMessage { get; set; }
	}

	public class CreateUpdateAlbumResult : ServiceResultBase
	{ 

	}

	public class ListPhotosResult : ServiceResultBase
	{

	}

	public class ListPhotoItemResult : ServiceResultBase
	{
		public ListPhotoItemResult()
			: base()
		{
			PhotoItems = new List<PhotoViewerItem>();
		}

		public List<PhotoViewerItem> PhotoItems { get; set; }
	}
}
