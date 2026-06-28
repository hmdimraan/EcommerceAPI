using EcommerceAPI.Data;
using EcommerceAPI.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EcommerceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Roles = "Admin")]
    public class DashboardController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DashboardController(AppDbContext context)
        {
            _context = context;
        }

        // =========================
        // DASHBOARD SUMMARY
        // =========================
        [HttpGet]
        public IActionResult GetDashboard()
        {
            var totalUsers =
                _context.Users.Count();

            var totalProducts =
                _context.Products.Count();

            var totalOrders =
                _context.Orders.Count();

            var totalRevenue =
                _context.Payments
                    .Where(p => p.PaymentStatus == "Paid")
                    .Sum(p => (decimal?)p.Amount) ?? 0;

            return Ok(new
            {
                TotalUsers = totalUsers,
                TotalProducts = totalProducts,
                TotalOrders = totalOrders,
                TotalRevenue = totalRevenue
            });
        }

        // =========================
        // TOTAL REVENUE
        // =========================
        [HttpGet("revenue")]
        public IActionResult GetRevenue()
        {
            var revenue =
                _context.Payments
                    .Where(p => p.PaymentStatus == "Paid")
                    .Sum(p => (decimal?)p.Amount) ?? 0;

            return Ok(new
            {
                Revenue = revenue
            });
        }

        // =========================
        // RECENT ORDERS
        // =========================
        [HttpGet("recent-orders")]
        public IActionResult RecentOrders()
        {
            var orders =
                _context.Orders
                    .OrderByDescending(
                        o => o.OrderDate)
                    .Take(5)
                    .Select(o => new
                    {
                        o.OrderID,
                        o.OrderDate,
                        o.TotalAmount,
                        o.Status
                    })
                    .ToList();

            return Ok(orders);
        }

        // =========================
        // TOP SELLING PRODUCTS
        // =========================
        [HttpGet("top-products")]
        public IActionResult TopProducts()
        {
            var products =
                _context.OrderDetails
                    .Include(od => od.Product)
                    .GroupBy(
                        od => new
                        {
                            od.ProductID,
                            od.Product!.ProductName
                        })
                    .Select(g => new
                    {
                        ProductID = g.Key.ProductID,
                        ProductName = g.Key.ProductName,
                        TotalSold =
                            g.Sum(
                                x => x.Quantity)
                    })
                    .OrderByDescending(
                        x => x.TotalSold)
                    .Take(5)
                    .ToList();

            return Ok(products);
        }

        // =========================
        // LOW STOCK PRODUCTS
        // =========================
        [HttpGet("low-stock")]
        public IActionResult LowStock()
        {
            var products =
                _context.Products
                    .Where(p =>
                        (p.Stock ?? 0) <= 5)
                    .Select(p =>
                        new ProductResponseDto
                        {
                            ProductID = p.ProductID,
                            ProductName = p.ProductName,
                            Price = p.Price,
                            Stock = p.Stock,
                            CategoryID =
                                p.CategoryID ?? 0,
                            ProductImagePath =
                                p.ProductImagePath
                        })
                    .ToList();

            return Ok(products);
        }
    }
}