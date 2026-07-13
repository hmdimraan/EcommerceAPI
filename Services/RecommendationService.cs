using System.Data;
using Microsoft.EntityFrameworkCore;
using EcommerceAPI.Data;
using EcommerceAPI.Models;

namespace EcommerceAPI.Services
{
    public class RecommendationService
    {
        private readonly AppDbContext _context;

        public RecommendationService(AppDbContext context)
        {
            _context = context;
        }

        // MAIN FUNCTION FOR PRODUCT DETAILS PAGE
        public List<Product> GetProductDetailRecommendations(int productId)
        {
            var products = _context.Products.ToList();

            // STEP 1: CONTENT SIMILARITY (80%)
            var contentScores = GetContentScores(products, productId);

            // STEP 2: PAST ORDER SCORE (20%)
            var orderScores = GetOrderScores(products, productId);

            // STEP 3: HYBRID SCORE
            var result = products
                .Select(p => new
                {
                    Product = p,
                    Score = (0.8 * contentScores[p.ProductID]) +
                            (0.2 * orderScores[p.ProductID])
                })
                .OrderByDescending(x => x.Score)
                .Where(x => x.Product.ProductID != productId)
                .Take(5)
                .Select(x => x.Product)
                .ToList();

            return result;
        }