using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DDTE.BL.Facade;
using DDTE.BL.Providers;
using DDTE.Model.DTO;
using DDTE.Web.Helpers;

namespace DDTE.Web.Pages.SpecialSection
{
	public partial class Leaders : System.Web.UI.Page
	{
		IStaffProvider staffProvider = new StaffProvider();

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				RefreshList();
			}
		}

		protected override void OnPreRender(EventArgs e)
		{
			pnlEditForm.Visible = pnlEditForm.Visible && SecurityHelper.CanEditStaff();
			lbAddStaff.Visible = lbAddStaff.Visible && SecurityHelper.CanEditStaff();
		}

		void RefreshList()
		{
			var staff = staffProvider.List();

			rptrStaff.DataSource = staff;
			rptrStaff.DataBind();
		}

		protected void rptrStaff_ItemCommand(object source, RepeaterCommandEventArgs e)
		{
			if (e.CommandName == "Delete")
			{
				try
				{
					staffProvider.DeleteStuff(Int32.Parse((string)e.CommandArgument));
					ltlMessage.Text = MessageFormatter.GetFormattedSuccessMessage("Запись удалена.");
					RefreshList();
				}
				catch (Exception ex)
				{
					ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage("Не удалось удалить сотрудника");
				}
			}
			else if (e.CommandName == "Edit")
			{
				try
				{
					var staff = staffProvider.GetById(Int32.Parse((string)e.CommandArgument));
					if (staff != null)
					{
						FillEditForm(staff);
						DisplayEditForm(false);
					} 
					else
						ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage("Не удалось найти сотрудника");
				}
				catch (Exception ex)
				{
					ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage("Не удалось получить данные сотрудника");
				}
			}
		}

		protected void rptrStaff_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if (e.Item.DataItem != null)
			{
				var s = e.Item.DataItem as StaffDTO;
				if (s != null)
				{
					var pnlActions = e.Item.FindControl("pnlActions") as Panel;
					if (pnlActions != null)
						pnlActions.Visible = SecurityHelper.CanEditStaff();
				}
			}
		}

		protected void lbAddStaff_Click(object sender, EventArgs e)
		{
			FillEditForm(new StaffDTO());
			DisplayEditForm(true);
		}

		void DisplayEditForm(bool isAdd)
		{
			pnlEditForm.Visible = true;
			btnAdd.Visible = isAdd;
			btnUpdate.Visible = !isAdd;
			lblEditFormTitle.Text = isAdd ? "Добавление сотрудника" : "Редактирование сотрудника";
			pnlEditForm.DefaultButton = isAdd ? btnAdd.ID : btnUpdate.ID;
			tbFullName.Focus();
			lbAddStaff.Visible = false;
		}

		void HideEditForm()
		{
			pnlEditForm.Visible = false;
			lbAddStaff.Visible = true;
		}

		void FillEditForm(StaffDTO staff)
		{
			tbDegree.Text = staff.Degree;
			tbEducation.Text = staff.Education;
			tbEducationExperience.Text = staff.EducationExperience;
			tbEmail.Text = staff.Email;
			tbGeneralExperience.Text = staff.GeneralExperience;
			tbFullName.Text = staff.Name;
			tbPhone.Text = staff.Phone;
			tbPosition.Text = staff.Position;
			tbQualification.Text = staff.Qualification;
			tbQualificationCourses.Text = staff.QualificationCourses;
			tbSpeciality.Text = staff.Speciality;
			imgPhoto.ImageUrl = staff.PhotoUrl;

			SelectedStaffId = staff.StaffId;
		}

		StaffDTO GetEditFormValues()
		{
			StaffDTO res = new StaffDTO();

			res.Degree = tbDegree.Text;
			res.Education = tbEducation.Text;
			res.EducationExperience = tbEducationExperience.Text;
			res.Email = tbEmail.Text;
			res.GeneralExperience = tbGeneralExperience.Text;
			res.Name = tbFullName.Text;
			res.Phone = tbPhone.Text;
			res.PhotoUrl = imgPhoto.ImageUrl;
			res.Position = tbPosition.Text;
			res.Qualification = tbQualification.Text;
			res.QualificationCourses = tbQualificationCourses.Text;
			res.Speciality = tbSpeciality.Text;

			res.StaffId = SelectedStaffId;

			return res;
		}

		protected void btnAdd_Click(object sender, EventArgs e)
		{
			try
			{
				var staff = GetEditFormValues();

				staffProvider.AddStuff(staff);

				ltlMessage.Text = MessageFormatter.GetFormattedSuccessMessage("Запись успешно добавлена");

				RefreshList();
				HideEditForm();
			}
			catch (Exception ex)
			{
				ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage("Не удалось добавить запись");
			}
		}

		protected void btnUpdate_Click(object sender, EventArgs e)
		{
			try
			{
				var staff = GetEditFormValues();

				staffProvider.UpdateStuff(staff);

				ltlMessage.Text = MessageFormatter.GetFormattedSuccessMessage("Запись успешно обновлена");

				RefreshList();
				HideEditForm();
			}
			catch (Exception ex)
			{
				ltlMessage.Text = MessageFormatter.GetFormattedErrorMessage("Не удалось обновить запись");
			}
		}

		protected void btnCancel_Click(object sender, EventArgs e)
		{
			HideEditForm();
		}

		string UploadPhoto()
		{
			var photoUrl = "";

			try
			{
				if (fuPhoto.HasFile)
				{
					var fileName = fuPhoto.FileName;
					var relativeFolderPath = "Documents/StaffPhoto/";
					string physicalFolderPath = AppDomain.CurrentDomain.BaseDirectory + relativeFolderPath.Replace("/", "\\");

					if (!Directory.Exists(physicalFolderPath))
						Directory.CreateDirectory(physicalFolderPath);

					fuPhoto.PostedFile.SaveAs(Path.Combine(physicalFolderPath, fileName));

					photoUrl = "/" + relativeFolderPath + fileName;
				}
			}
			catch (Exception ex)
			{ 
				// TODO: log exception
			}

			return photoUrl;
		}

		string SelectedStaffIdFieldName = "SelectedStaffId";
		int SelectedStaffId
		{
			get 
			{
				if (ViewState[SelectedStaffIdFieldName] == null)
					ViewState[SelectedStaffIdFieldName] = -1;

				return (int)ViewState[SelectedStaffIdFieldName];
			}
			set 
			{
				ViewState[SelectedStaffIdFieldName] = value;
			}
		}

		protected void btnUploadPhoto_Click(object sender, EventArgs e)
		{
			var imgUrl = UploadPhoto();
			imgPhoto.ImageUrl = imgUrl;
		}
	}
}