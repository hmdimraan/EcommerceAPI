using System.Text.Json.Serialization;

namespace EcommerceAPI.Models
{
    public class Order
    {
       
        public  int OrderID { get; set; }

        public int? CustomerID { get; set; }

        public DateTime? OrderDate { get; set; }

        public decimal? TotalAmount { get; set; }
        [JsonIgnore]
        public Customer? Customer { get; set; }
        [JsonIgnore]
        public List<OrderDetail>? OrderDetails { get; set; }
        [JsonIgnore]
        public List<Payment>? Payments { get; set; }
    }
}