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
	public class UnionProvider : DbProviderBase, IUnionProvider
	{
		public UnionDTO GetFullById(int unionId)
		{
			using (var db = GetObjectContext())
			{
				var q = GetFullUnionById(unionId, db);

				if (q == null)
					return null;

				var res = new UnionDTO()
				{
					UnionId = q.UnionId,
					Name = q.Name,
					Description = q.Description,
					IsActive = q.IsActive,
					UnionPrograms = q.UnionPrograms.Select(up => new UnionProgramDTO(up)).ToList()
				};

				return res;
			}
		}

		Union GetFullUnionById(int unionId, DdteDBEntities db)
		{
			var q = (from u in db.Unions.Include("UnionPrograms.UnionAchievements").Include("UnionPrograms.UnionSchedules")
						where u.UnionId == unionId
						select u);

			return q.FirstOrDefault();
		}

		public List<UnionDTO> List()
		{
			var res = new List<UnionDTO>();

			using (var db = GetObjectContext())
			{
				var q = (from u in db.Unions.Include("UnionPrograms.UnionAchievements").Include("UnionPrograms.UnionSchedules")
						select u).ToList();

				res.AddRange(q.Select(u => new UnionDTO()
					{
						UnionId = u.UnionId,
						Name = u.Name,
						Description = u.Description,
						IsActive = u.IsActive,
						UnionPrograms = u.UnionPrograms.Select(up => new UnionProgramDTO(up)).ToList()
					})
				);
			}

			return res;
		}

		public List<UnionAchievementDTO> GroupAchievements(List<UnionAchievementDTO> achievements)
		{
			List<UnionAchievementDTO> res = new List<UnionAchievementDTO>();

			var grouped = achievements
				.GroupBy(a => new { a.Name, a.Date })
				.Select(group => new UnionAchievementDTO() { 
					Name = group.Key.Name, 
					Date = group.Key.Date, 
					Participant = String.Join(Environment.NewLine, group.Select(g => g.Participant)),
					Result = String.Join(Environment.NewLine, group.Select(g => g.Result))
				}).ToList();

			res.AddRange(grouped);

			return res;
		}

		public int SaveUnion(UnionDTO union)
		{
			using (var db = GetObjectContext())
			{
				Union baseUnion = null;
				if (union.UnionId > 0)
					baseUnion = GetFullUnionById(union.UnionId, db);
				else
				{
					baseUnion = new Union() { CreatedDate = DateTime.UtcNow };
					db.Unions.Add(baseUnion);
				}

				// Union
				baseUnion.Name = union.Name;
				baseUnion.Description = union.Description;
				baseUnion.ModifiedDate = DateTime.UtcNow;
				baseUnion.IsActive = union.IsActive;

				// UnionProgram
				foreach (var unp in union.UnionPrograms)
				{
					var baseUp = baseUnion.UnionPrograms.FirstOrDefault(up => up.UnionProgramId == unp.UnionProgramId);
					if (baseUp == null)		// vb: new up
					{
						baseUp = new UnionProgram() { CreatedDate = DateTime.UtcNow };
						baseUnion.UnionPrograms.Add(baseUp);
					}
					baseUp.AcceptConditions = unp.AcceptConditions;
					baseUp.Age = unp.Age;
					baseUp.ModifiedDate = DateTime.UtcNow;
					baseUp.DevelopingTasks = unp.DevelopingTasks;
					baseUp.Direction = unp.Direction;
					baseUp.Duration = unp.Duration;
					baseUp.Education = unp.Education;
					baseUp.EducationDirection = unp.EducationDirection;
					baseUp.EducationTasks = unp.EducationTasks;
					baseUp.EducativeTasks = unp.EducativeTasks;
					baseUp.Goal = unp.Goal;
					baseUp.IsActive = unp.IsActive;
					baseUp.Name = unp.Name;
					baseUp.Title = unp.Title;

					// UnionSchedule
                    var newSchedules = new List<UnionSchedule>();
					foreach (var unps in unp.Schedule)
					{
						var baseUnps = baseUp.UnionSchedules.FirstOrDefault(ups => ups.UnionScheduleId == unps.UnionScheduleId);
						if (baseUnps == null)
						{
							baseUnps = new UnionSchedule() { CreatedDate = DateTime.UtcNow };
							newSchedules.Add(baseUnps);
						}

						baseUnps.HoursDay = unps.HoursDay;
						baseUnps.HoursWeek = unps.HoursWeek;
						baseUnps.HoursYear = unps.HoursYear;
						baseUnps.IsActive = unps.IsActive;
						baseUnps.LessonDuration = unps.LessonDuration;
						baseUnps.LessonsPerWeek = unps.LessonPerWeek;
						baseUnps.ModifiedDate = DateTime.UtcNow;
						baseUnps.Year = unps.Year;
					}
                    newSchedules.ForEach(s => baseUp.UnionSchedules.Add(s));
					// Delete excess Schedules
					baseUp.UnionSchedules.Where(ups => !unp.Schedule.Any(unps => unps.UnionScheduleId == ups.UnionScheduleId))
						.ToList()
						.ForEach(ups => db.UnionSchedules.Remove(ups));
                    

					// UnionAchievements
                    var newAchievements = new List<UnionAchievement>();
					foreach (var unpa in unp.Achievements)
					{
						var baseUnpa = baseUp.UnionAchievements.FirstOrDefault(ups => ups.UnionAchievementId == unpa.UnionAchievementId);
						if (baseUnpa == null)
						{
							baseUnpa = new UnionAchievement() { CreatedDate = DateTime.UtcNow };
							newAchievements.Add(baseUnpa);
						}

						baseUnpa.Date = unpa.Date;
						baseUnpa.IsActive = unpa.IsActive;
						baseUnpa.Name = unpa.Name;
						baseUnpa.Participant = unpa.Participant;
						baseUnpa.Result = unpa.Result;
						baseUnpa.ModifiedDate = DateTime.UtcNow;
					}
                    newAchievements.ForEach(a => baseUp.UnionAchievements.Add(a));

					// Delete excess Achievements
					baseUp.UnionAchievements.Where(ups => !unp.Achievements.Any(unpa => unpa.UnionAchievementId == ups.UnionAchievementId))
						.ToList()
						.ForEach(ups => db.UnionAchievements.Remove(ups));
				}

				// Delete excess union programs
				baseUnion.UnionPrograms.Where(up => !union.UnionPrograms.Any(unp => unp.UnionProgramId == up.UnionProgramId))
					.ToList()
					.ForEach(up => db.UnionPrograms.Remove(up));

				db.SaveChanges();

				return baseUnion.UnionId;
			}
		}

		public int Add(SimpleUnionDTO union)
		{
			using (var db = GetObjectContext())
			{
				var u = new Union()
				{
					Name = union.Name,
					Description = union.Description,
					IsActive = true,
					CreatedDate = DateTime.UtcNow,
					ModifiedDate = DateTime.UtcNow
				};

				db.Unions.Add(u);

				db.SaveChanges();

			return union.UnionId;
			}
		}

		public void Delete(int unionId)
		{
			using (var db = GetObjectContext())
			{
				var un = (from u in db.Unions.Include("UnionPrograms")
						  where u.UnionId == unionId
						  select u).FirstOrDefault();

				if (un == null)
					throw new EntityNotFoundException("Объединение не найдено");

				un.UnionPrograms.ToList().ForEach(up => db.UnionPrograms.Remove(up));
				db.Unions.Remove(un);

				db.SaveChanges();
			}
		}

		public int Add(UnionProgramDTO up)
		{
			throw new NotImplementedException();
		}
	}
}
