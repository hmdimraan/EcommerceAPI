using System.Text.Json.Serialization;

namespace EcommerceAPI.Models
{
    public class Payment
    {
      
        public   int PaymentID { get; set; }

        public int? OrderID { get; set; }

     
        public  string? PaymentMethod { get; set; }

        public DateTime? PaymentDate { get; set; }
        [JsonIgnore]
        public Order? Order { get; set; }
        public decimal Amount { get; set; }
        public string PaymentStatus { get; set; }
    = string.Empty;
    }
}
