using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DDTE.Model.DTO
{
	public class UnionScheduleDTO
	{
		public UnionScheduleDTO()
		{ }

		public UnionScheduleDTO(UnionSchedule sch)
			: this()
		{
			UnionScheduleId = sch.UnionScheduleId;
			UnionProgramId = sch.UnionProgramId;
			Year = sch.Year;
			LessonDuration = sch.LessonDuration;
			HoursDay = sch.HoursDay;
			HoursWeek = sch.HoursWeek;
			HoursYear = sch.HoursYear;
			LessonPerWeek = sch.LessonsPerWeek;
			IsActive = sch.IsActive;
		}

		public int UnionScheduleId { get; set; }
		public int UnionProgramId { get; set; }
		public string Year { get; set; }
		public string LessonDuration { get; set; }
		public string HoursDay { get; set;}
		public string HoursWeek { get; set; }
		public string HoursYear { get; set; }
		public string LessonPerWeek { get; set; }
		public bool IsActive { get; set; }
	}
}
