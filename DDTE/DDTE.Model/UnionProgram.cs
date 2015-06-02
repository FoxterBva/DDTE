//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DDTE.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class UnionProgram
    {
        public UnionProgram()
        {
            this.UnionAchievements = new HashSet<UnionAchievement>();
            this.UnionSchedules = new HashSet<UnionSchedule>();
        }
    
        public int UnionProgramId { get; set; }
        public int UnionId { get; set; }
        public string Title { get; set; }
        public string Name { get; set; }
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
        public System.DateTime CreatedDate { get; set; }
        public System.DateTime ModifiedDate { get; set; }
    
        public virtual Union Union { get; set; }
        public virtual ICollection<UnionAchievement> UnionAchievements { get; set; }
        public virtual ICollection<UnionSchedule> UnionSchedules { get; set; }
    }
}