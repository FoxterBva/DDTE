using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DDTE.BL.Facade;
using DDTE.Model;
using DDTE.Model.DTO;

namespace DDTE.BL.Providers
{
	public class DocumentProvider : IDocumentProvider
	{
		public List<DocumentDTO> ListDocuments(string Category)
		{
			return new List<DocumentDTO>();
		}

		public List<DocumentDTO> ListDocuments(string category, List<DocumentFileInfo> files)
		{
			var res = new List<DocumentDTO>();

			foreach (var f in files)
			{
				if (String.IsNullOrEmpty(category) || category.Equals(f.Category))
				{
					res.Add(new DocumentDTO()
						{
							Category = f.Category,
							LinkName = f.FileName,
							Link = f.RelativePath + "/" + f.FileName,
							IsLocal = true
						});
				}
			}

			return res;
		}

		public void Add(DocumentDTO document)
		{ 
			// TODO: add to the DB
		}

		public void Save(DocumentDTO document)
		{

		}
	}
}
