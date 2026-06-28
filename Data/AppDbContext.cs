using EcommerceAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace EcommerceAPI.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(
            DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        public DbSet<Category> Categories { get; set; }

        public DbSet<Product> Products { get; set; }

        public DbSet<Order> Orders { get; set; }

        public DbSet<OrderDetail> OrderDetails { get; set; }

        public DbSet<Payment> Payments { get; set; }

        public DbSet<Employee> Employees { get; set; }

        public DbSet<User> Users { get; set; }

        public DbSet<Role> Roles { get; set; }
        public DbSet<Cart> Carts { get; set; }

        public DbSet<CartItem> CartItems { get; set; }

        public DbSet<Review> Reviews { get; set; }

        protected override void OnModelCreating(
            ModelBuilder modelBuilder)
        {
           
            // Table Names
            modelBuilder.Entity<Category>()
                .ToTable("categories");

            modelBuilder.Entity<Product>()
                .ToTable("products");

            modelBuilder.Entity<Order>()
                .ToTable("orders");

            modelBuilder.Entity<OrderDetail>()
                .ToTable("orderdetails");

            modelBuilder.Entity<Payment>()
                .ToTable("payments");

            modelBuilder.Entity<Employee>()
                .ToTable("employees");
            modelBuilder.Entity<Role>()
                .ToTable("roles");

            modelBuilder.Entity<User>()
                .ToTable("users");
            modelBuilder.Entity<Cart>()
    .ToTable("carts");

            modelBuilder.Entity<CartItem>()
                .ToTable("cartitems");
            // Decimal Precision
            modelBuilder.Entity<Product>()
                .Property(p => p.Price)
                .HasPrecision(18, 2);
            modelBuilder.Entity<Payment>()
    .Property(p => p.Amount)
    .HasPrecision(18, 2);
            modelBuilder.Entity<Order>()
                .Property(o => o.TotalAmount)
                .HasPrecision(18, 2);

            modelBuilder.Entity<OrderDetail>()
                .Property(od => od.Price)
                .HasPrecision(18, 2);

            modelBuilder.Entity<Employee>()
                .Property(e => e.Salary)
                .HasPrecision(18, 2);

            // Product -> Category
            modelBuilder.Entity<Product>()
                .HasOne(p => p.Category)
                .WithMany(c => c.Products)
                .HasForeignKey(p => p.CategoryID)
                .OnDelete(DeleteBehavior.Restrict);

            // OrderDetail -> Order
            modelBuilder.Entity<OrderDetail>()
                .HasOne(od => od.Order)
                .WithMany(o => o.OrderDetails)
                .HasForeignKey(od => od.OrderID)
                .OnDelete(DeleteBehavior.Restrict);

            // OrderDetail -> Product
            modelBuilder.Entity<OrderDetail>()
                .HasOne(od => od.Product)
                .WithMany(p => p.OrderDetails)
                .HasForeignKey(od => od.ProductID)
                .OnDelete(DeleteBehavior.Restrict);

            // Payment -> Order
            modelBuilder.Entity<Payment>()
                .HasOne(p => p.Order)
                .WithMany(o => o.Payments)
                .HasForeignKey(p => p.OrderID)
                .OnDelete(DeleteBehavior.Restrict);

            // User -> Role
            modelBuilder.Entity<User>()
                .HasOne(u => u.Role)
                .WithMany(r => r.Users)
                .HasForeignKey(u => u.RoleID)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Cart>()
    .HasOne(c => c.User)
    .WithOne(u => u.Cart)
    .HasForeignKey<Cart>(c => c.UserID)
    .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<CartItem>()
    .HasOne(ci => ci.Cart)
    .WithMany(c => c.CartItems)
    .HasForeignKey(ci => ci.CartID)
    .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<CartItem>()
    .HasOne(ci => ci.Product)
    .WithMany(p => p.CartItems)
    .HasForeignKey(ci => ci.ProductID)
    .OnDelete(DeleteBehavior.Restrict);

            base.OnModelCreating(modelBuilder);

        }
    }
}