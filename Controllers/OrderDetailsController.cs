using EcommerceAPI.Data;
using EcommerceAPI.DTOs;
using EcommerceAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EcommerceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderDetailsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public OrderDetailsController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetOrderDetails()
        {
            return Ok(
                _context.OrderDetails
                .Include(od => od.Order)
                .Include(od => od.Product)
                .ToList()
            );
        }
        [HttpGet("{id}")]
        public IActionResult GetOrderDetail(int id)
        {
            var orderDetail = _context.OrderDetails.Find(id);

            if (orderDetail == null)
            {
                return NotFound();
            }

            return Ok(orderDetail);
        }
        [HttpPost]
        public IActionResult CreateOrderDetail(OrderDetailCreateDto dto)
        {
            var orderDetail = new OrderDetail
            {
                OrderID = dto.OrderID,
                ProductID = dto.ProductID,
                Quantity = dto.Quantity,
                Price = dto.Price
            };

            _context.OrderDetails.Add(orderDetail);
            _context.SaveChanges();

            return Ok(orderDetail);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateOrderDetail(int id, OrderDetail updatedOrderDetail)
        {
            var orderDetail = _context.OrderDetails.Find(id);

            if (orderDetail == null)
            {
                return NotFound();
            }

            orderDetail.Quantity = updatedOrderDetail.Quantity;
            orderDetail.Price = updatedOrderDetail.Price;

            _context.SaveChanges();

            return Ok(orderDetail);
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteOrderDetail(int id)
        {
            var orderDetail = _context.OrderDetails.Find(id);

            if (orderDetail == null)
            {
                return NotFound();
            }

            _context.OrderDetails.Remove(orderDetail);

            _context.SaveChanges();

            return Ok();
        }
    }
}