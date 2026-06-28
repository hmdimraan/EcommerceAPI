namespace EcommerceAPI.DTOs
{
    public class CartResponseDto
    {
        public int ProductID { get; set; }

        public string ProductName { get; set; }
            = string.Empty;

        public decimal Price { get; set; }

        public int Quantity { get; set; }

        public string? ProductImagePath { get; set; }
    }
}