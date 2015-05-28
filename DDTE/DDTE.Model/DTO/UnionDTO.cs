using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DDTE.Model.DTO
{
	public class UnionDTO
	{
		public UnionDTO()
		{
			UnionPrograms = new List<UnionProgramDTO>();
		}

		public int UnionId { get; set; }
		public string Name { get; set; }
		public string Description { get; set; }
		public bool IsActive { get; set; }
		public List<UnionProgramDTO> UnionPrograms { get; set; }
	}
}
