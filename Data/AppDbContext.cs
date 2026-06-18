using EcommerceApi.Models;
using EcommerceAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace EcommerceAPI.Data
{
    // DbContext is built in EF core class provides insert,update,delete ....
    public class AppDbContext : DbContext //AppDbContext is database context class which represents my database used by EF to communicate with database
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)//DbContextOptions<AppDbContext> contains provider settings
            : base(options)//passes to parent class so EF core can use those settings
        {
        }
       
        public DbSet<Customer> Customers { get; set; }//DbSet<Customer>represents table of Customer objects.

        public DbSet<Order> Orders { get; set; }

        public DbSet<OrderDetail> OrderDetails { get; set; }

        public DbSet<Product> Products { get; set; }

        public DbSet<Category> Categories { get; set; }

        public DbSet<Payment> Payments { get; set; }
        public DbSet<Employee> Employees { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)//method used to configure relationship between tables
        {
            modelBuilder.Entity<Order>()//foreignkey exist in order table
                .HasOne(o => o.Customer)//one order object goes to customer property of that order
                .WithMany(c => c.Orders)
                .HasForeignKey(o => o.CustomerID)
                .OnDelete(DeleteBehavior.Restrict);//Restrict delete Cannot delete customer if orders exist.

            modelBuilder.Entity<Product>()
                .HasOne(p => p.Category)
                .WithMany(c => c.Products)
                .HasForeignKey(p => p.CategoryID)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<OrderDetail>()
                .HasOne(od => od.Order)
                .WithMany(o => o.OrderDetails)
                .HasForeignKey(od => od.OrderID)
               .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<OrderDetail>()
                .HasOne(od => od.Product)
                .WithMany(p => p.OrderDetails)
                .HasForeignKey(od => od.ProductID)
               .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Payment>()
                .HasOne(p => p.Order)
                .WithMany(o => o.Payments)
                .HasForeignKey(p => p.OrderID)
                .OnDelete(DeleteBehavior.Restrict);
        }
    }
}