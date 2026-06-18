namespace EcommerceAPI.DTOs
{
    public class CustomerCreateDto
    {
        public required string CustomerName { get; set; }

        public string? Email { get; set; }

        public string? Phone { get; set; }
    }
}
