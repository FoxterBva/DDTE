using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DDTE.BL.Facade
{
	public interface IFileContainer
	{
        /// <summary>
        /// Returns saved file path
        /// </summary>
		string Save(string path);

		string FileName { get; }
	}
}
