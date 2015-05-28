using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DDTE.Model.DTO
{
	public class UnionProgramDTO
	{
		public UnionProgramDTO()
		{
			Achievements = new List<UnionAchievementDTO>();
			Schedule = new List<UnionScheduleDTO>();
		}

		public UnionProgramDTO(UnionProgram up) 
			: this()
		{
			UnionProgramId = up.UnionProgramId;
			Name = up.Name;
			Title = up.Title;
			Direction = up.Direction;
			EducationDirection = up.EducationDirection;
			Goal = up.Goal;
			EducationTasks = up.EducationTasks;
			DevelopingTasks = up.DevelopingTasks;
			EducativeTasks = up.EducativeTasks;
			Education = up.Education;
			Duration = up.Duration;
			Age = up.Age;
			AcceptConditions = up.AcceptConditions;
			IsActive = up.IsActive;

			Achievements = up.UnionAchievements.Select(a => new UnionAchievementDTO(a)).ToList();
			Schedule = up.UnionSchedules.Select(s => new UnionScheduleDTO(s)).ToList();
		}

		public int UnionProgramId { get; set; }
		public string Name { get; set; }
		public string Title { get; set; }
		public string Direction { get; set; }
		public string EducationDirection { get; set; }
		public string Goal { get; set; }
		public string EducationTasks { get; set; }
		public string DevelopingTasks { get; set; }
		public string EducativeTasks { get; set; }
		public string Education { get; set; }
		public string Duration { get; set; }
		public string Age { get; set; }
		public string AcceptConditions { get; set; }
		public bool IsActive { get; set; }

		public List<UnionAchievementDTO> Achievements { get; set; }
		public List<UnionScheduleDTO> Schedule { get; set; }
	}
}
