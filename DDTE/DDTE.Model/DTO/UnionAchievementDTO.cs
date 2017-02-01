using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DDTE.Model.DTO
{
	public class UnionAchievementDTO
	{
		public UnionAchievementDTO()
		{ }

		public UnionAchievementDTO(UnionAchievement ach) : this()
		{
			UnionAchievementId = ach.UnionAchievementId;
			UnionProgramId = ach.UnionProgramId;
			Name = ach.Name;
			Date = ach.Date;
			Participant = ach.Participant;
			Result = ach.Result;

            Participants = ach.UnionAchievementParticipants.Select(p => new UnionAchievementParticipantDTO() { 
                ParticipantId = p.UnionAchievementParticipantId, 
                ParticipantName = p.ParticipantName, 
                Result = p.Result 
            }).ToList();
		}

		public int UnionAchievementId { get; set; }
		public int UnionProgramId { get; set; }
		public string Name { get; set; }
		public string Date { get; set; }
		public string Participant { get; set; }
		public string Result { get; set; }
		public bool IsActive { get; set; }

        public List<UnionAchievementParticipantDTO> Participants { get; set; }
	}
}
