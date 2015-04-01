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

		[WebMethod]
		public string HelloWorld()
		{
			return "Hello World";
		}

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

			} catch (Exception ex)
			{
				res.ErrorMessage = "Не удается получить список объектов.";
				LogError("ListPhotoItems", "Unexpected error", ex);
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

		void LogError(string method, string msg, Exception ex)
		{
			logger.Error("DataActionService." + method + ": " + msg);
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
