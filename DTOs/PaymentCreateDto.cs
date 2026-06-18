namespace EcommerceAPI.DTOs
{
    public class PaymentCreateDto
    {
        public int OrderID { get; set; }

        public decimal Amount { get; set; }

        public string? PaymentMethod { get; set; }

        public DateTime PaymentDate { get; set; }
    }
}