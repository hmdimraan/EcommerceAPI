using System.Text.Json.Serialization;

namespace EcommerceAPI.Models
{
    public class Order
    {
        public int OrderID { get; set; }

        // 🔥 FIX: required for checkout + cart mapping
        public int UserID { get; set; }

        public DateTime OrderDate { get; set; }
            = DateTime.Now;

        public decimal TotalAmount { get; set; }

        
        public string Status { get; set; }
            = "Placed";

        // Navigation properties
        [JsonIgnore]
        public User? User { get; set; }

        [JsonIgnore]
        public List<OrderDetail> OrderDetails { get; set; }
            = new();

        [JsonIgnore]
        public List<Payment> Payments { get; set; }
            = new();
    }
}