namespace EcommerceAPI.DTOs
{
    public class ProductResponseDto
    {
        public int ProductID { get; set; }

        public string ProductName { get; set; }
            = string.Empty;

        public decimal Price { get; set; }

        public int? Stock { get; set; }

        public int CategoryID { get; set; }

        public string? ProductImagePath { get; set; }
        public double AverageRating { get; set; }

        public int ReviewCount { get; set; }
    }
}