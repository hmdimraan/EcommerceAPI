namespace EcommerceAPI.DTOs
{
    public class OrderResponseDto
    {
        public int OrderID { get; set; }

        public DateTime OrderDate { get; set; }

        public decimal TotalAmount { get; set; }

        public string Status { get; set; }
            = string.Empty;

        public List<OrderDetailDto> Items { get; set; }
            = new();
    }
}