using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DDTE.Model.DTO
{
	public class StaffDTO
	{
		public StaffDTO()
		{
			StaffId = -1;
		}

		public int StaffId { get; set; }
		public string Name { get; set; }
		public string PhotoUrl { get; set; }
		public string Position { get; set; }
		public string Qualification { get; set; }
		public string Education { get; set; }
		public string Speciality { get; set; }
		public string Degree { get; set; }
		public string QualificationCourses { get; set; }
		public string GeneralExperience { get; set; }
		public string EducationExperience { get; set; }
		public string Phone { get; set; }
		public string Email { get; set; }
        public string LeaderOf { get; set; }
	}
}
