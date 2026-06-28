using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;

namespace EcommerceAPI.DTOs
{
    public class ProductCreateDto
    {
        [Required]
        public string ProductName { get; set; }
            = string.Empty;

        [Range(1, 1000000)]
        public decimal Price { get; set; }

        [Range(0, 100000)]
        public int Stock { get; set; }

        [Required]
        public int CategoryID { get; set; }

        public IFormFile? ProductImage { get; set; }

        public IFormFile? InvoicePdf { get; set; }
    }
}