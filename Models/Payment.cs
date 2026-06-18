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
    }
}
