namespace EcommerceAPI.DTOs
{
    public class PlaceOrderDto
    {
        public decimal TotalAmount { get; set; }

        public List<PlaceOrderItemDto> Items { get; set; }
            = new();
    }

    public class PlaceOrderItemDto
    {
        public int ProductID { get; set; }

        public int Quantity { get; set; }

        public decimal Price { get; set; }
    }
}