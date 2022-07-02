﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace LibrarySolution.DataLayer
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class LibraryManagementDbEntities : DbContext
    {
        public LibraryManagementDbEntities()
            : base("name=LibraryManagementDbEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<BookCategory> BookCategories { get; set; }
        public virtual DbSet<Loan> Loans { get; set; }
        public virtual DbSet<Publisher> Publishers { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<Book> Books { get; set; }
    
        public virtual ObjectResult<SP_GetBooks_Result> SP_GetBooks()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SP_GetBooks_Result>("SP_GetBooks");
        }
    
        public virtual ObjectResult<SP_GetLoans_Result> SP_GetLoans()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SP_GetLoans_Result>("SP_GetLoans");
        }
    }
}