using EcommerceAPI.Models;

namespace EcommerceAPI.Services
{
    public interface ITokenService
    {
        string CreateToken(User user);
    }
}