using EcommerceAPI.Data;
using EcommerceAPI.DTOs;
using EcommerceAPI.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace EcommerceAPI.Controllers
{
    [Authorize]
    [Route("api/checkout-test")]
    [ApiController]
    public class CheckoutController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CheckoutController(AppDbContext context)
        {
            _context = context;
        }

        private int GetUserId()
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            if (string.IsNullOrEmpty(userId))
                throw new UnauthorizedAccessException("User ID not found in token.");

            return int.Parse(userId);
        }

        [HttpPost]
        public async Task<IActionResult> Checkout(
            CheckoutDto dto)
        {
           
            int userId = GetUserId();

            var cart = await _context.Carts
                .Include(c => c.CartItems)
                .ThenInclude(ci => ci.Product)
                .FirstOrDefaultAsync(
                    c => c.UserID == userId);

            if (cart == null ||
                cart.CartItems == null ||
                !cart.CartItems.Any())
            {
                return BadRequest(
                    "Cart is empty.");
            }

            // Stock validation
            foreach (var item in cart.CartItems)
            {
                if (item.Product == null)
                    continue;

                if (item.Quantity >
                    item.Product.Stock)
                {
                    return BadRequest(
                        $"{item.Product.ProductName} has only {item.Product.Stock} items left.");
                }
            }

            // Calculate total
            decimal totalAmount = 0;

            foreach (var item in cart.CartItems)
            {
                totalAmount +=
                    item.Quantity *
                    item.Product!.Price;
            }

            // Create Order
            var order = new Order
            {
                UserID = userId,
                OrderDate = DateTime.Now,
                TotalAmount = totalAmount,
                Status = "Placed"
            };

            _context.Orders.Add(order);

            await _context.SaveChangesAsync();

            // Create OrderDetails
            foreach (var item in cart.CartItems)
            {
                var orderDetail =
                    new OrderDetail
                    {
                        OrderID = order.OrderID,
                        ProductID = item.ProductID,
                        Quantity = item.Quantity,
                        Price = item.Product!.Price
                    };

                _context.OrderDetails
                    .Add(orderDetail);

                // Reduce Stock
                item.Product.Stock -=
                    item.Quantity;
            }

            // Create Payment
            var payment = new Payment
            {
                OrderID = order.OrderID,
                PaymentDate = DateTime.Now,
                PaymentMethod = dto.PaymentMethod,
                Amount = totalAmount,
                PaymentStatus = "Paid"
            };

            _context.Payments.Add(payment);

            // Clear Cart
            // Clear Cart

            throw new Exception(
    $"CartID={cart.CartID}, Items={cart.CartItems.Count}"
);
            _context.CartItems.RemoveRange(
                cart.CartItems
            );

            var deleted =
                await _context.SaveChangesAsync();


            var remaining =
                await _context.CartItems.CountAsync(
                    x => x.CartID == cart.CartID
                );

            
            return Ok(new
            {
                Message = "IMRAN_TEST_123",
                OrderID = order.OrderID,
                TotalAmount = totalAmount
            });
        }
    }
}