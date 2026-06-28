using EcommerceAPI.Data;
using EcommerceAPI.DTOs;
using EcommerceAPI.Models;
using EcommerceAPI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using EcommerceAPI.Services;

namespace EcommerceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class OrdersController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly PdfService _pdfService;

        public OrdersController(
            AppDbContext context,
            PdfService pdfService)
        {
            _context = context;
            _pdfService = pdfService;
        }
        // GET: api/orders
        [HttpGet]
        public IActionResult GetOrders()
        {
            int userId = int.Parse(
                User.FindFirst(ClaimTypes.NameIdentifier)!
                .Value);

            var orders = _context.Orders
                .Where(o => o.UserID == userId)
                .OrderByDescending(o => o.OrderDate)
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

        [HttpGet("{id}/invoice")]
        public async Task<IActionResult> DownloadInvoice(int id)
        {
            var order = await _context.Orders
                .Include(o => o.User)
                .FirstOrDefaultAsync(
                    o => o.OrderID == id);

            if (order == null)
                return NotFound();

            var pdf = _pdfService.GenerateInvoice(
                order.OrderID,
                order.User!.Name,
                order.TotalAmount );

            return File(
                pdf,
                "application/pdf",
                $"Invoice-{id}.pdf");
        }

        // GET: api/orders/all
        [Authorize(Roles = "Admin")]
        [HttpGet("all")]
        public IActionResult GetAllOrders()
        {
            var orders = _context.Orders
     .Include(o => o.User)
     .Include(o => o.OrderDetails)
     .ThenInclude(od => od.Product)
     .Select(o => new
     {
         o.OrderID,
         o.OrderDate,
         o.TotalAmount,
         o.Status,

         CustomerName = o.User!.Name,
         CustomerEmail = o.User.Email,

         OrderDetails = o.OrderDetails.Select(od => new
         {
             ProductName = od.Product!.ProductName,
             od.Quantity,
             od.Price
         })
     })
     .ToList();

            return Ok(orders);
        }

        // GET: api/orders/5
        [HttpGet("{id}")]
        public IActionResult GetOrder(int id)
        {
            int userId = int.Parse(
                User.FindFirst(ClaimTypes.NameIdentifier)!
                .Value);

            var order = _context.Orders
                .Include(o => o.OrderDetails)
                .ThenInclude(od => od.Product)
                .FirstOrDefault(o =>
                    o.OrderID == id &&
                    o.UserID == userId);

            if (order == null)
            {
                return NotFound("Order not found.");
            }

            var response = new
            {
                order.OrderID,
                order.OrderDate,
                order.TotalAmount,
                order.Status,
                Items = order.OrderDetails
                    .Select(od => new
                    {
                        ProductName = od.Product!.ProductName,
                        od.Quantity,
                        od.Price
                    })
            };

            return Ok(response);
        }

        // GET: api/orders/my-orders
        [HttpGet("my-orders")]
        public IActionResult GetMyOrders()
        {
            int userId = int.Parse(
                User.FindFirst(ClaimTypes.NameIdentifier)!
                .Value);

            var orders = _context.Orders
                .Include(o => o.OrderDetails)
                .ThenInclude(od => od.Product)
                .Where(o => o.UserID == userId)
                .OrderByDescending(o => o.OrderDate)
                .Select(o => new
                {
                    o.OrderID,
                    o.OrderDate,
                    o.TotalAmount,
                    o.Status,
                    OrderDetails = o.OrderDetails.Select(od => new
                    {
                        od.ProductID,
                        ProductName = od.Product!.ProductName,
                        od.Quantity,
                        od.Price
                    })
                })
                .ToList();

            return Ok(orders);
        }

        // POST: api/orders
        [HttpPost]
        public IActionResult PlaceOrder(
            [FromBody] PlaceOrderDto dto)
        {
            int userId = int.Parse(
                User.FindFirst(ClaimTypes.NameIdentifier)!
                .Value);

            var order = new Order
            {
                UserID = userId,
                OrderDate = DateTime.Now,
                TotalAmount = dto.TotalAmount,
                Status = "Pending"
            };

            _context.Orders.Add(order);
            _context.SaveChanges();

            foreach (var item in dto.Items)
            {
                var detail = new OrderDetail
                {
                    OrderID = order.OrderID,
                    ProductID = item.ProductID,
                    Quantity = item.Quantity,
                    Price = item.Price
                };

                _context.OrderDetails.Add(detail);

                var product =
                    _context.Products
                    .FirstOrDefault(p =>
                        p.ProductID == item.ProductID);

                if (product != null)
                {
                    product.Stock =
                        (product.Stock ?? 0)
                        - item.Quantity;
                }
            }

            // Clear user's cart
            var cart = _context.Carts
                .Include(c => c.CartItems)
                .FirstOrDefault(c => c.UserID == userId);

            if (cart != null)
            {
                _context.CartItems.RemoveRange(
                    cart.CartItems
                );
            }

            _context.SaveChanges();

            return Ok(order);
        }

        // PUT: api/orders/5/status
        [Authorize(Roles = "Admin")]
        [HttpPut("{id}/status")]
        public async Task<IActionResult> UpdateStatus(
            int id,
            string status)
        {
            var order =
                await _context.Orders
                .FindAsync(id);

            if (order == null)
            {
                return NotFound();
            }

            order.Status = status;

            await _context.SaveChangesAsync();

            return Ok(order);
        }

        // PUT: api/orders/cancel/5
        [HttpPut("cancel/{id}")]
        public IActionResult CancelOrder(int id)
        {
            int userId = int.Parse(
                User.FindFirst(ClaimTypes.NameIdentifier)!
                .Value);

            var order = _context.Orders
                .Include(o => o.OrderDetails)
                .ThenInclude(od => od.Product)
                .FirstOrDefault(o =>
                    o.OrderID == id &&
                    o.UserID == userId);

            if (order == null)
            {
                return NotFound("Order not found.");
            }

            if (order.Status == "Cancelled")
            {
                return BadRequest(
                    "Order already cancelled.");
            }

            if (order.Status == "Delivered")
            {
                return BadRequest(
                    "Delivered orders cannot be cancelled.");
            }

            foreach (var item in order.OrderDetails)
            {
                if (item.Product != null)
                {
                    item.Product.Stock =
                        (item.Product.Stock ?? 0)
                        + item.Quantity;
                }
            }

            order.Status = "Cancelled";

            var payment =
                _context.Payments
                .FirstOrDefault(p =>
                    p.OrderID == order.OrderID);

            if (payment != null)
            {
                payment.PaymentStatus =
                    "Refunded";
            }

            _context.SaveChanges();

            return Ok(new
            {
                Message =
                    "Order cancelled successfully."
            });
        }
    }
}