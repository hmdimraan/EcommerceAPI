namespace EcommerceAPI.Models
{
    public class Review
    {
        public int ReviewID { get; set; }

        public int ProductID { get; set; }

        public int UserID { get; set; }

        public int Rating { get; set; }

        public string Comment { get; set; }
            = string.Empty;

        public DateTime ReviewDate
            = DateTime.Now;

        public Product? Product { get; set; }

        public User? User { get; set; }
    }
}