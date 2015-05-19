using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DDTE.Model.DTO;

namespace DDTE.BL.Facade
{
	public interface IStaffProvider
	{
		List<StaffDTO> List();
		StaffDTO GetById(int id);
		int AddStuff(StaffDTO staff);
		int UpdateStuff(StaffDTO staff);
		void DeleteStuff(int staffId);
	}
}
