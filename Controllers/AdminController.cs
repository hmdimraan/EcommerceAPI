using EcommerceAPI.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EcommerceApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AdminController : ControllerBase
{
    private readonly AppDbContext _context;

    public AdminController(
        AppDbContext context)
    {
        _context = context;
    }
    [HttpGet("top-products")]
    public async Task<IActionResult> GetTopProducts()
    {
        var products = await _context.OrderDetails
            .Include(o => o.Product)
            .GroupBy(o => o.Product!.ProductName)
            .Select(g => new
            {
                Product = g.Key,
                QuantitySold = g.Sum(x => x.Quantity)
            })
            .OrderByDescending(x => x.QuantitySold)
            .Take(5)
            .ToListAsync();

        return Ok(products);
    }

    [HttpGet("stats")]
    public async Task<IActionResult> GetStats()
    {
        var totalUsers =
            await _context.Users.CountAsync();

        var totalProducts =
            await _context.Products.CountAsync();

        var totalOrders =
            await _context.Orders.CountAsync();

        var totalRevenue =
            await _context.Orders
            .SumAsync(o => o.TotalAmount);

        return Ok(new
        {
            totalUsers,
            totalProducts,
            totalOrders,
            totalRevenue
        });
    }
}