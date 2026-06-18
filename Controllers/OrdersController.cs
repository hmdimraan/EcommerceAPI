using EcommerceAPI.Data;
using EcommerceAPI.DTOs;
using EcommerceAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace EcommerceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrdersController : ControllerBase
    {
        private readonly AppDbContext _context;

        public OrdersController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetOrders()
        {
            return Ok(_context.Orders.ToList());
        }

        [HttpPost]
        public IActionResult CreateOrder(OrderCreateDto dto)
        {
            var order = new Order
            {
                OrderDate = dto.OrderDate,
                CustomerID = dto.CustomerID,
                TotalAmount = dto.TotalAmount
            };

            _context.Orders.Add(order);
            _context.SaveChanges();

            return Ok(order);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateOrder(int id, Order updatedOrder)
        {
            var order = _context.Orders.Find(id);

            if (order == null)
            {
                return NotFound();
            }

            order.OrderDate = updatedOrder.OrderDate;
            order.CustomerID = updatedOrder.CustomerID;

            _context.SaveChanges();

            return Ok(order);
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteOrder(int id)
        {
            var order = _context.Orders.Find(id);

            if (order == null)
            {
                return NotFound();
            }

            _context.Orders.Remove(order);

            _context.SaveChanges();

            return Ok();
        }
    }
}