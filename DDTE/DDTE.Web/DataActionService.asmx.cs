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
}
