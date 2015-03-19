using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.Model;
using DDTE.Model.DTO;

namespace DDTE.BL.Facade
{
	public interface IDocumentProvider
	{
		List<DocumentDTO> ListDocuments(string Category);
		List<DocumentDTO> ListDocuments(string category, List<DocumentFileInfo> files);
		void Add(DocumentDTO document);
		void Save(DocumentDTO document);
	}
}
