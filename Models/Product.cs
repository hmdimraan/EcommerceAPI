using System.Text.Json.Serialization;

namespace EcommerceAPI.Models
{
    public class Product
    {
       
       
        public  int ProductID { get; set; }

      
        public required string ProductName { get; set; } = string.Empty;

        public  required decimal Price { get; set; }

        public int? Stock { get; set; }
        public string? ProductImagePath { get; set; }


        public int? CategoryID { get; set; }
        [JsonIgnore]
        public Category? Category { get; set; }
        [JsonIgnore]
        public List<OrderDetail>? OrderDetails { get; set; }
        [JsonIgnore]
        public List<CartItem> CartItems { get; set; } = new();

        public ICollection<Review> Reviews{ get; set; } = new List<Review>();
    }
}
