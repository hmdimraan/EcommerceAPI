namespace EcommerceAPI.Models
{
    public class Cart
    {
        public int CartID { get; set; }

        public int UserID { get; set; }

        public DateTime CreatedDate { get; set; }
            = DateTime.Now;

        public User? User { get; set; }

        public List<CartItem> CartItems
        {
            get; set;
        } = new();
    }
}