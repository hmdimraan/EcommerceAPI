using EcommerceAPI.Data;
using EcommerceAPI.DTOs;
using EcommerceAPI.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EcommerceAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ProductsController(AppDbContext context)
        {
            _context = context;
        }

        // =========================
        // GET ALL PRODUCTS
        // =========================
        [HttpGet]
        public IActionResult GetProducts()
        {
            var products = _context.Products
                .Select(p => new ProductResponseDto
                {
                    ProductID = p.ProductID,
                    ProductName = p.ProductName,
                    Price = p.Price,
                    Stock = p.Stock,
                    CategoryID = p.CategoryID ?? 0,
                    ProductImagePath = p.ProductImagePath,

                    AverageRating = p.Reviews.Any()
                        ? p.Reviews.Average(r => r.Rating)
                        : 0,

                    ReviewCount = p.Reviews.Count()
                })
                .ToList();

            return Ok(products);
        }

        // =========================
        // FILTER PRODUCTS
        // =========================
        [HttpGet("filter")]
        public IActionResult FilterProducts(
            decimal? minPrice,
            decimal? maxPrice,
            int? categoryId)
        {
            var products = _context.Products.AsQueryable();

            if (minPrice.HasValue)
            {
                products = products.Where(
                    p => p.Price >= minPrice.Value);
            }

            if (maxPrice.HasValue)
            {
                products = products.Where(
                    p => p.Price <= maxPrice.Value);
            }

            if (categoryId.HasValue)
            {
                products = products.Where(
                    p => p.CategoryID == categoryId.Value);
            }

            var response = products
                .Select(p => new ProductResponseDto
                {
                    ProductID = p.ProductID,
                    ProductName = p.ProductName,
                    Price = p.Price,
                    Stock = p.Stock,
                    CategoryID = p.CategoryID ?? 0,
                    ProductImagePath = p.ProductImagePath
                })
                .ToList();

            return Ok(response);
        }

        // =========================
        // PRODUCT STATS
        // =========================
        [Authorize(Roles = "Admin")]
        [HttpGet("stats")]
        public IActionResult GetStats()
        {
            var totalProducts =
                _context.Products.Count();

            var totalStock =
                _context.Products.Sum(
                    p => p.Stock ?? 0);

            var totalValue =
                _context.Products.Sum(
                    p => p.Price * (p.Stock ?? 0));

            return Ok(new
            {
                TotalProducts = totalProducts,
                TotalStock = totalStock,
                InventoryValue = totalValue
            });
        }

        // =========================
        // GET PRODUCTS BY CATEGORY
        // =========================
        [HttpGet("category/{categoryId}")]
        public IActionResult GetProductsByCategory(
            int categoryId)
        {
            var products = _context.Products
                .Where(
                    p => p.CategoryID == categoryId)
                .Select(p => new ProductResponseDto
                {
                    ProductID = p.ProductID,
                    ProductName = p.ProductName,
                    Price = p.Price,
                    Stock = p.Stock,
                    CategoryID = p.CategoryID ?? 0,
                    ProductImagePath = p.ProductImagePath
                })
                .ToList();

            return Ok(products);
        }

        // =========================
        // SEARCH PRODUCTS
        // =========================
        [HttpGet("search")]
        public IActionResult SearchProducts(
            string keyword)
        {
            var products = _context.Products
                .Where(
                    p => p.ProductName.Contains(keyword))
                .Select(p => new ProductResponseDto
                {
                    ProductID = p.ProductID,
                    ProductName = p.ProductName,
                    Price = p.Price,
                    Stock = p.Stock,
                    CategoryID = p.CategoryID ?? 0,
                    ProductImagePath = p.ProductImagePath
                })
                .ToList();

            return Ok(products);
        }

        // =========================
        // PAGINATION
        // =========================
        [HttpGet("paged")]
        public IActionResult GetProductsPaged(
            int page = 1,
            int pageSize = 2)
        {
            var products = _context.Products
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .Select(p => new ProductResponseDto
                {
                    ProductID = p.ProductID,
                    ProductName = p.ProductName,
                    Price = p.Price,
                    Stock = p.Stock,
                    CategoryID = p.CategoryID ?? 0,
                    ProductImagePath = p.ProductImagePath
                })
                .ToList();

            return Ok(products);
        }

        // =========================
        // ADD PRODUCT
        // =========================
        [Authorize(Roles = "Admin")]
        [HttpPost]
        public async Task<IActionResult> AddProduct(
            [FromForm] ProductCreateDto dto)
        {
            string? imagePath = null;
            string? invoicePath = null;

            // IMAGE SAVE
            if (dto.ProductImage != null)
            {
                var imageFileName =
                    Guid.NewGuid() +
                    Path.GetExtension(
                        dto.ProductImage.FileName);

                var imageFolder =
                    Path.Combine(
                        Directory.GetCurrentDirectory(),
                        "wwwroot/ProductImages");

                Directory.CreateDirectory(
                    imageFolder);

                var imageFullPath =
                    Path.Combine(
                        imageFolder,
                        imageFileName);

                using var stream =
                    new FileStream(
                        imageFullPath,
                        FileMode.Create);

                await dto.ProductImage
                    .CopyToAsync(stream);

                imagePath =
                    $"ProductImages/{imageFileName}";
            }

            // PDF SAVE
            if (dto.InvoicePdf != null)
            {
                var pdfFileName =
                    Guid.NewGuid() +
                    Path.GetExtension(
                        dto.InvoicePdf.FileName);

                var pdfFolder =
                    Path.Combine(
                        Directory.GetCurrentDirectory(),
                        "wwwroot/Invoices");

                Directory.CreateDirectory(
                    pdfFolder);

                var pdfFullPath =
                    Path.Combine(
                        pdfFolder,
                        pdfFileName);

                using var stream =
                    new FileStream(
                        pdfFullPath,
                        FileMode.Create);

                await dto.InvoicePdf
                    .CopyToAsync(stream);

                invoicePath =
                    $"Invoices/{pdfFileName}";
            }

            var product = new Product
            {
                ProductName = dto.ProductName,
                Price = dto.Price,
                Stock = dto.Stock,
                CategoryID = dto.CategoryID,
                ProductImagePath = imagePath
            };

            _context.Products.Add(product);

            await _context.SaveChangesAsync();

            return Ok(product);
        }

        // =========================
        // UPDATE PRODUCT
        // =========================
        [Authorize(Roles = "Admin")]
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateProduct(
            int id,
            [FromForm] ProductCreateDto dto)
        {
            var product =
                await _context.Products
                    .FindAsync(id);

            if (product == null)
                return NotFound();

            product.ProductName =
                dto.ProductName;

            product.Price =
                dto.Price;

            product.Stock =
                dto.Stock;

            product.CategoryID =
                dto.CategoryID;

            if (dto.ProductImage != null)
            {
                var fileName =
                    Guid.NewGuid() +
                    Path.GetExtension(
                        dto.ProductImage.FileName);

                var folder =
                    Path.Combine(
                        Directory.GetCurrentDirectory(),
                        "wwwroot/ProductImages");

                Directory.CreateDirectory(
                    folder);

                var path =
                    Path.Combine(
                        folder,
                        fileName);

                using var stream =
                    new FileStream(
                        path,
                        FileMode.Create);

                await dto.ProductImage
                    .CopyToAsync(stream);

                product.ProductImagePath =
                    $"ProductImages/{fileName}";
            }

            await _context.SaveChangesAsync();

            return Ok(product);
        }

        // =========================
        // DELETE PRODUCT
        // =========================
        [Authorize(Roles = "Admin")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduct(
            int id)
        {
            var product =
                await _context.Products
                    .FindAsync(id);

            if (product == null)
                return NotFound();

            _context.Products.Remove(
                product);

            await _context.SaveChangesAsync();

            return Ok(new
            {
                Message =
                    "Product deleted successfully."
            });
        }

        // =========================
        // SORT PRODUCTS
        // =========================
        [HttpGet("sort")]
        public IActionResult SortProducts(
            string order = "asc")
        {
            var products =
                order.ToLower() == "desc"
                ? _context.Products
                    .OrderByDescending(
                        p => p.Price)
                : _context.Products
                    .OrderBy(
                        p => p.Price);

            var response = products
                .Select(p => new ProductResponseDto
                {
                    ProductID = p.ProductID,
                    ProductName = p.ProductName,
                    Price = p.Price,
                    Stock = p.Stock,
                    CategoryID = p.CategoryID ?? 0,
                    ProductImagePath = p.ProductImagePath
                })
                .ToList();

            return Ok(response);
        }
    }
}

