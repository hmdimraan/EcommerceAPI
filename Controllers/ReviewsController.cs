using EcommerceAPI.Data;
using EcommerceAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace EcommerceAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ReviewsController
        : ControllerBase
    {
        private readonly AppDbContext _context;

        public ReviewsController(
            AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("{productId}")]
        public IActionResult GetReviews(
            int productId)
        {
            return Ok(
                _context.Reviews
                .Where(r =>
                    r.ProductID == productId)
                .ToList()
            );
        }

        [HttpPost]
        public IActionResult AddReview(
            Review review)
        {
            _context.Reviews.Add(
                review);

            _context.SaveChanges();

            return Ok(review);
        }
    }
}