using System.Text.Json.Serialization;

namespace EcommerceAPI.Models
{
    public class Category
    {
   
        
        public int CategoryID { get; set; }

        public required string CategoryName { get; set; }

        [JsonIgnore]
        public List<Product>? Products { get; set; }
    }
}