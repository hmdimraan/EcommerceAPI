namespace EcommerceAPI.DTOs
{
    public class OrderCreateDto
    {
        public DateTime OrderDate { get; set; }

        public int CustomerID { get; set; }

        public decimal TotalAmount { get; set; }
    }
}