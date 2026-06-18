using System.Text.Json.Serialization;

namespace EcommerceAPI.Models
{
    public class Customer
    {
      
        public int CustomerID { get; set; }

        public required string CustomerName { get; set; }

        public string? Email { get; set; }

        public string? Phone { get; set; }

        [JsonIgnore]
        public List<Order>? Orders { get; set; }
    }
}