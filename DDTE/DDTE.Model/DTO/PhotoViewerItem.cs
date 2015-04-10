using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DDTE.Model.DTO
{
    public enum PhotoViewerItemType
    { 
        Album = 0,
        Photo = 1
    }

    public class PhotoViewerItem
    {
        public int Id { get; set; }
        public PhotoViewerItemType ItemType { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string ImagePath { get; set; }
		public bool IsPublic { get; set; }
		public DateTime CreatedDate { get; set; }
    }
}
