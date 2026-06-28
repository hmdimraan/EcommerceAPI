namespace EcommerceAPI.Models
{
    public class User
    {
        public int UserID { get; set; }

        public string Name { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;

        public string PasswordHash { get; set; }
            = string.Empty;

        public string Phone { get; set; }
            = string.Empty;

        public string Address { get; set; }
            = string.Empty;

        public DateTime CreatedDate { get; set; }
            = DateTime.Now;

        public int RoleID { get; set; }

        public Role? Role { get; set; }
        public Cart? Cart { get; set; }
    }
}