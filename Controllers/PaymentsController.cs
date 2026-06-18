using EcommerceAPI.Data;
using EcommerceAPI.DTOs;
using EcommerceAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace EcommerceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public PaymentsController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetPayments()
        {
            return Ok(_context.Payments.ToList());
        }
        [HttpGet("{id}")]
        public IActionResult GetPayment(int id)
        {
            var payment = _context.Payments.Find(id);

            if (payment == null)
            {
                return NotFound();
            }

            return Ok(payment);
        }
        [HttpPost]
        public IActionResult CreatePayment(PaymentCreateDto dto)
        {
            var payment = new Payment
            {
                OrderID = dto.OrderID,
                PaymentMethod = dto.PaymentMethod,
                PaymentDate = dto.PaymentDate
            };

            _context.Payments.Add(payment);
            _context.SaveChanges();

            return Ok(payment);
        }

        [HttpPut("{id}")]
        public IActionResult UpdatePayment(int id, Payment updatedPayment)
        {
            var payment = _context.Payments.Find(id);

            if (payment == null)
            {
                return NotFound();
            }

            
            payment.PaymentMethod = updatedPayment.PaymentMethod;

            _context.SaveChanges();

            return Ok(payment);
        }

        [HttpDelete("{id}")]
        public IActionResult DeletePayment(int id)
        {
            var payment = _context.Payments.Find(id);

            if (payment == null)
            {
                return NotFound();
            }

            _context.Payments.Remove(payment);

            _context.SaveChanges();

            return Ok();
        }
    }
}