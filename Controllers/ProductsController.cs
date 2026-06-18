using EcommerceAPI.Data;
using EcommerceAPI.DTOs;
using EcommerceAPI.Models;
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

        [HttpGet]
        public IActionResult GetProducts()
        {
            var products = _context.Products
                .Include(p => p.Category)
                .ToList();

            return Ok(products);
        }

        [HttpGet("category/{id}")]
        public IActionResult GetProductsByCategory(int id)
        {
            var products = _context.Products
                .Include(p => p.Category)
                .Where(p => p.CategoryID == id)
                .ToList();

            return Ok(products);
        }

        [HttpPost]
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
                    Path.GetExtension(dto.ProductImage.FileName);

                var imageFolder =
                    Path.Combine(
                        Directory.GetCurrentDirectory(),
                        "wwwroot/ProductImages"
                    );

                Directory.CreateDirectory(imageFolder);

                var imageFullPath =
                    Path.Combine(imageFolder, imageFileName);

                using (var stream =
                       new FileStream(imageFullPath, FileMode.Create))
                {
                    await dto.ProductImage.CopyToAsync(stream);
                }

                imagePath =
                    $"ProductImages/{imageFileName}";
            }

            // PDF SAVE

            if (dto.InvoicePdf != null)
            {
                var pdfFileName =
                    Guid.NewGuid() +
                    Path.GetExtension(dto.InvoicePdf.FileName);

                var pdfFolder =
                    Path.Combine(
                        Directory.GetCurrentDirectory(),
                        "wwwroot/Invoices"
                    );

                Directory.CreateDirectory(pdfFolder);

                var pdfFullPath =
                    Path.Combine(pdfFolder, pdfFileName);

                using (var stream =
                       new FileStream(pdfFullPath, FileMode.Create))
                {
                    await dto.InvoicePdf.CopyToAsync(stream);
                }

                invoicePath =
                    $"Invoices/{pdfFileName}";
            }

            var product = new Product
            {
                ProductName = dto.ProductName,
                Price = dto.Price,
                Stock = dto.Stock,
                CategoryID = dto.CategoryID,

                ProductImagePath = imagePath,

                InvoicePdfPath = invoicePath
            };

            _context.Products.Add(product);

            await _context.SaveChangesAsync();

            return Ok(product);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateProduct(int id, Product updatedProduct)
        {
            var product = _context.Products.Find(id);

            if (product == null)
            {
                return NotFound();
            }

            product.ProductName = updatedProduct.ProductName;
            product.Price = updatedProduct.Price;
            product.Stock = updatedProduct.Stock;
            product.CategoryID = updatedProduct.CategoryID;
        

            _context.SaveChanges();

            return Ok(product);
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteProduct(int id)
        {
            var product = _context.Products.Find(id);

            if (product == null)
            {
                return NotFound();
            }

            _context.Products.Remove(product);

            _context.SaveChanges();

            return Ok();
        }
    }
}