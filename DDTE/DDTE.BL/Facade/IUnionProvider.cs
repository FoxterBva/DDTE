using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DDTE.Model.DTO;

namespace DDTE.BL.Facade
{
	public interface IUnionProvider
	{
		UnionDTO GetFullById(int unionId);
		int Add(SimpleUnionDTO union);
		void Delete(int unionId);

		int SaveUnion(UnionDTO union);
		int Add(UnionProgramDTO up);

		List<UnionDTO> List();
		List<UnionAchievementDTO> GroupAchievements(List<UnionAchievementDTO> achievements);
	}
}
