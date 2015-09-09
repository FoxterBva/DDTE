using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using DDTE.BL.Facade;
using DDTE.Common;
using DDTE.Common.Exceptions;
using DDTE.Model.DTO;
using DDTE.Web.Helpers;
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
		IUnionProvider unionProvider = new DDTE.BL.Providers.UnionProvider();
        IStaffProvider staffProvider = new DDTE.BL.Providers.StaffProvider();

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
		public ServiceResultBase CreateAlbum(CreateAlbumData albumData)
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
					Description = albumData.Description,
					IsPublic = albumData.IsPublic,
					Title = albumData.Title
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
		public ServiceResultBase UpdateAlbum(UpdateAlbumData albumData)
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
					Id = albumData.AlbumId,
					Description = albumData.Description,
					IsPublic = albumData.IsPublic,
					Title = albumData.Title
				};

				photoProvider.UpdateAlbum(album);
			}
			catch (Exception ex)
			{
				res.ErrorMessage = "Не удалось обновить альбом";
				LogError("UpdateAlbum", "Unexpected error", ex);
			}

			return res;
		}

		[WebMethod]
		public ServiceResultBase DeleteAlbum(int albumId)
		{
			var res = new ServiceResultBase();

			try
			{
				if (!CanEditAlbums())
				{
					res.ErrorMessage = "Недостаточно прав";
					return res;
				}

				photoProvider.DeleteAlbum(albumId, HttpRuntime.AppDomainAppPath + "\\Photos");
			}
			catch (Exception ex)
			{
				res.ErrorMessage = "Не удалось удалить альбом";
				LogError("DeleteAlbum", "Unexpected error", ex);
			}

			return res;
		}

		[WebMethod]
		public ServiceResultBase AddPhoto(CreatePhotoData photoData)
		{
			var res = new ServiceResultBase();

			try
			{
				if (!CanEditPhotos())
				{
					res.ErrorMessage = "Недостаточно прав";
					return res;
				}

				PhotoDTO photo = new PhotoDTO()
				{
					Name = photoData.Title,
					Description = photoData.Description,
					IsPublic = photoData.IsPublic,
					Path = photoData.Url,
					AlbumId = photoData.AlbumId
				};

				IFileContainer container = null;

				if (String.IsNullOrWhiteSpace(photoData.Url))
				{
					var dataStr = (string)photoData.File;
					byte[] bytes = Convert.FromBase64String(dataStr);

					container = new ByteFileContainer(bytes, photoData.FileName);
				}

				photoProvider.AddPhoto(photo, container, HttpRuntime.AppDomainAppPath + "Photos");
			}
			catch (Exception ex)
			{
				res.ErrorMessage = "Не удалось добавить фотографию";
				LogError("AddPhoto", "Unexpected error", ex);
			}

			return res;
		}

		[WebMethod]
		public ServiceResultBase UpdatePhoto(UpdatePhotoData photoData)
		{
			var res = new ServiceResultBase();

			try
			{
				if (!CanEditPhotos())
				{
					res.ErrorMessage = "Недостаточно прав";
					return res;
				}

				PhotoDTO photo = new PhotoDTO()
				{
					Id = photoData.PhotoId,
					Name = photoData.Title,
					Description = photoData.Description,
					IsPublic = photoData.IsPublic
				};

				photoProvider.UpdatePhoto(photo);
			}
			catch (Exception ex)
			{
				res.ErrorMessage = "Не удалось обновить фотографию";
				LogError("UpdatePhoto", "Unexpected error", ex);
			}

			return res;
		}

		[WebMethod]
		public ServiceResultBase DeletePhoto(int photoId)
		{
			var res = new ServiceResultBase();

			try
			{
				if (!CanEditPhotos())
				{
					res.ErrorMessage = "Недостаточно прав";
					return res;
				}

				photoProvider.DeletePhoto(photoId, HttpRuntime.AppDomainAppPath + "\\Photos");
			}
			catch (Exception ex)
			{
				res.ErrorMessage = "Не удалось удалить фотографию";
				LogError("DeletePhoto", "Unexpected error", ex);
			}

			return res;
		}

        #region Unions

        [WebMethod]
		public GetUnionResult GetUnion(int unionId)
		{
			var res = new GetUnionResult();
			
			try
			{
				if (!CanEditUnion())
				{
					res.ErrorMessage = "Недостаточно прав";
					return res;
				}

				res.Union = unionProvider.GetFullById(unionId);
			}
			catch (EntityNotFoundException ex)
			{
				res.ErrorMessage = "Выбранное объединение не найдено.";
				LogError("GetUnion", "Union '" + unionId.ToString() + "' not found", ex);
			}
			catch (Exception ex)
			{
				res.ErrorMessage = "Не удалось получить объединение.";
				LogError("GetUnion", "Unexpected error", ex);
			}

			return res;
		}

		[WebMethod]
		public ServiceResultBase SaveUnion(UnionDTO union)
		{
			var res = new ServiceResultBase();

            try
            {
                unionProvider.SaveUnion(union);
            }
            catch (Exception ex)
            {
                res.ErrorMessage = "Не удалось сохранить объединение.";
                LogError("SaveUnion", "Unexpected error", ex);
            }

			return res;
		}

		[WebMethod]
		public ServiceResultBase DeleteUnion(int unionId)
		{
			var res = new ServiceResultBase();

			try
			{
				unionProvider.Delete(unionId);
			}
			catch (Exception ex)
			{
				res.ErrorMessage = "Не удалось удалить объединение.";
				LogError("DeleteUnion", "Unexpected error", ex);
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

        #endregion

        #region staff (employees)

        [WebMethod]
        public GetEmployeesResult GetEmployees()
        {
            var res = new GetEmployeesResult();

            try
            {
                var empls = staffProvider.List();
                res.Employees = empls;
            }
            catch (Exception ex)
            {
                res.ErrorMessage = "Непредвиденная ошибка.";
                LogError("GetEmployees", "Unexpected error", ex);
            }

            return res;
        }

        [WebMethod]
        public GetEmployeesResult GetEmployee(int emplId)
        {
            var res = new GetEmployeesResult();

            try
            {
                var empl = staffProvider.GetById(emplId);
                if (empl == null)
                {
                    res.ErrorMessage = "Сотрудник не найден";
                    return res;
                }

                res.Employees = new List<StaffDTO>() { empl };
            }
            catch (Exception ex)
            {
                res.ErrorMessage = "Непредвиденная ошибка.";
                LogError("GetEmployee", "Unexpected error", ex);
            }

            return res;
        }

        [WebMethod]
        public ServiceResultBase DeleteEmployee(int emplId)
        {
            var res = new ServiceResultBase();

            try
            {
                staffProvider.DeleteStuff(emplId);
            }
            catch (Exception ex)
            {
                res.ErrorMessage = "Непредвиденная ошибка.";
                LogError("DeleteEmployee", "Unexpected error", ex);
            }

            return res;
        }

        [WebMethod]
        public ServiceResultBase UpdateEmployee(StaffDTO employee)
        {
            var res = new ServiceResultBase();

            try
            {
                staffProvider.UpdateStuff(employee);
            }
            catch (Exception ex)
            {
                res.ErrorMessage = "Непредвиденная ошибка.";
                LogError("UpdateEmployee", "Unexpected error", ex);
            }

            return res;
        }

        [WebMethod]
        public ServiceResultBase AddEmployee(StaffDTO employee)
        {
            var res = new ServiceResultBase();

            try
            {
                staffProvider.AddStuff(employee);
            }
            catch (Exception ex)
            {
                res.ErrorMessage = "Непредвиденная ошибка.";
                LogError("AddEmployee", "Unexpected error", ex);
            }

            return res;
        }

        #endregion

        bool CanEditStaff()
        {
            return HttpContext.Current.Request.IsAuthenticated;
        }

        bool CanEditAlbums()
		{
			return HttpContext.Current.Request.IsAuthenticated;
		}

		bool CanEditUnion()
		{
			return HttpContext.Current.Request.IsAuthenticated;
		}

		bool CanEditPhotos()
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

    public class GetEmployeesResult : ServiceResultBase
    {
        public GetEmployeesResult()
            : base()
        {
            Employees = new List<StaffDTO>();
        }

        public List<StaffDTO> Employees { get; set; }
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

	public class CreateAlbumData
	{
		public string Title { get; set; }
		public string Description { get; set; }
		public bool IsPublic { get; set; }
	}

	public class UpdateAlbumData
	{
		public int AlbumId { get; set; }
		public string Title { get; set; }
		public string Description { get; set; }
		public bool IsPublic { get; set; }
	}

	public class CreatePhotoData
	{
		public string Title { get; set; }
		public string Description { get; set; }
		public bool IsPublic { get; set; }
		public string Url { get; set; }
		public string FileName { get; set; }
		public int AlbumId { get; set; }
		public object File { get; set; }
	}

	public class UpdatePhotoData
	{
		public int PhotoId { get; set; }
		public string Title { get; set; }
		public string Description { get; set; }
		public bool IsPublic { get; set; }
	}

	public class GetUnionResult : ServiceResultBase
	{
		public UnionDTO Union { get; set; }
	}
}
