﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class DdteDBEntities : DbContext
    {
        public DdteDBEntities()
            : base("name=DdteDBEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<Album> Albums { get; set; }
        public DbSet<Photo> Photos { get; set; }
        public DbSet<News> News { get; set; }
        public DbSet<Staff> Staffs { get; set; }
        public DbSet<Union> Unions { get; set; }
        public DbSet<UnionAchievement> UnionAchievements { get; set; }
        public DbSet<UnionProgram> UnionPrograms { get; set; }
        public DbSet<UnionSchedule> UnionSchedules { get; set; }
        public DbSet<UnionAchievementParticipant> UnionAchievementParticipants { get; set; }
    }
}
