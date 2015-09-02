using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DDTE.BL.Facade;
using DDTE.Common.Exceptions;
using DDTE.Model;
using DDTE.Model.DTO;

namespace DDTE.BL.Providers
{
	public class StaffProvider : DbProviderBase, IStaffProvider
	{
		public StaffDTO GetById(int id)
		{
			using (var db = GetObjectContext())
			{
				var q = (from s in db.Staffs
						 where s.StaffId == id
						 select s).FirstOrDefault();

				if (q == null)
					return null;

				return new StaffDTO()
				{
					Degree = q.Degree,
					Education = q.Education,
					EducationExperience = q.EducationExperience,
					Email = q.Email,
					GeneralExperience = q.GeneralExperience,
					Name = q.Name,
					Phone = q.Phone,
					PhotoUrl = q.PhotoUrl,
					Position = q.Position,
					Qualification = q.Qualification,
					QualificationCourses = q.QualificationCourses,
					Speciality = q.Speciality,
					StaffId = q.StaffId,
                    LeaderOf = q.LeaderOf
				};
			}
		}

		public int AddStuff(StaffDTO staff)
		{
			using (var db = GetObjectContext())
			{
				var st = new Staff()
				{
					CreatedDate = DateTime.UtcNow,
					Degree = staff.Degree,
					Education = staff.Education,
					EducationExperience = staff.EducationExperience,
					Email = staff.Email,
					GeneralExperience = staff.GeneralExperience,
					IsActive = true,
					ModifiedDate = DateTime.UtcNow,
					Name = staff.Name,
					Phone = staff.Phone,
					PhotoUrl = staff.PhotoUrl,
					Position = staff.Position,
					Qualification = staff.Qualification,
					QualificationCourses = staff.QualificationCourses,
					Speciality = staff.Speciality,
                    LeaderOf = staff.LeaderOf
				};

				db.Staffs.Add(st);

				db.SaveChanges();

				return st.StaffId;
			}
		}

		public int UpdateStuff(StaffDTO staff)
		{
			using (var db = GetObjectContext())
			{
				var st = (from s in db.Staffs
						  where s.StaffId == staff.StaffId
						  select s).FirstOrDefault();

				if (st == null)
					throw new EntityNotFoundException("Сотрудние для редактирования не найден");

				st.ModifiedDate = DateTime.UtcNow;
				st.Degree = staff.Degree;
				st.Education = staff.Education;
				st.EducationExperience = staff.EducationExperience;
				st.Email = staff.Email;
				st.GeneralExperience = staff.GeneralExperience;
				//st.IsActive = 
				st.Name = staff.Name;
				st.Phone = staff.Phone;
				st.PhotoUrl = staff.PhotoUrl;
				st.Position = staff.Position;
				st.Qualification = staff.Qualification;
				st.QualificationCourses = staff.QualificationCourses;
				st.Speciality = staff.Speciality;
                st.LeaderOf = staff.LeaderOf;

				db.SaveChanges();

				return st.StaffId;
			}
		}

		public void DeleteStuff(int staffId)
		{
			using (var db = GetObjectContext())
			{
				var st = (from s in db.Staffs
						  where s.StaffId == staffId
						  select s).FirstOrDefault();

				if (st == null)
					throw new EntityNotFoundException("Сотрудние для удаления не найден");

				db.Staffs.Remove(st);

				db.SaveChanges();
			}
		}

		public List<StaffDTO> List()
		{
			List<StaffDTO> res = new List<StaffDTO>();

			using (var db = GetObjectContext())
			{
				var q =  from s in db.Staffs
						 select new StaffDTO() 
						 {
							 Degree = s.Degree,
							 Education = s.Education,
							 EducationExperience = s.EducationExperience,
							 Email = s.Email,
							 GeneralExperience = s.GeneralExperience,
							 Name = s.Name,
							 Phone = s.Phone,
							 PhotoUrl = s.PhotoUrl,
							 Position = s.Position,
							 Qualification = s.Qualification,
							 QualificationCourses = s.QualificationCourses,
							 Speciality = s.Speciality,
							 StaffId = s.StaffId,
                             LeaderOf = s.LeaderOf
						 };

				res.AddRange(q.ToList());
			}

			return res;

			//return new List<StaffDTO>() { 
			//	new StaffDTO() {
			//		StaffId = 1,
			//		Name = "Божко Марина Васильевна",
			//		Position = "Директор",
			//		Qualification = "Высшая",
			//		Degree = "Почётная грамота Министерства Образования и Науки Российской Федерации" + Environment.NewLine + "Почётная грамота Правительства республики Бурятия",
			//		Education = "1990 год, Восточно-Сибирский государственный институт культуры;" + Environment.NewLine + "2013 год, Бурятский государственный университет",
			//		Speciality = "- Культурно-просветительная работа" + Environment.NewLine + "- Менеджмент в образовании",
			//		QualificationCourses = "-",
			//		GeneralExperience = "21 год",
			//		EducationExperience = "21 год",
			//		Phone = "8 (30130) 2-00-03",
			//		Email = "evrikasb@mail.ru"
			//	},
			//	new StaffDTO() {
			//		StaffId = 1,
			//		Name = "Божко Марина Васильевна",
			//		Position = "Директор",
			//		Qualification = "Высшая",
			//		Degree = "Почётная грамота Министерства Образования и Науки Российской Федерации" + Environment.NewLine + "Почётная грамота Правительства республики Бурятия",
			//		Education = "1990 год, Восточно-Сибирский государственный институт культуры;" + Environment.NewLine + "2013 год, Бурятский государственный университет",
			//		Speciality = "- Культурно-просветительная работа" + Environment.NewLine + "- Менеджмент в образовании",
			//		QualificationCourses = "-",
			//		GeneralExperience = "21 год",
			//		EducationExperience = "21 год",
			//		Phone = "8 (30130) 2-00-03",
			//		Email = "evrikasb@mail.ru"
			//	}
			//};
		}
	}
}
