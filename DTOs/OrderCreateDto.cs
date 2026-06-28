namespace EcommerceAPI.DTOs
{
    public class OrderCreateDto
    {
        public int UserID { get; set; }

        public DateTime OrderDate { get; set; }

        public decimal TotalAmount { get; set; }

        public string Status { get; set; }
            = "Pending";
    }
}