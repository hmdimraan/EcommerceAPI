using EcommerceAPI.Data;
using EcommerceAPI.DTOs;
using EcommerceAPI.Models;
using EcommerceAPI.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace EcommerceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly ITokenService _tokenService;

        public AuthController(
            AppDbContext context,
            ITokenService tokenService)
        {
            _context = context;
            _tokenService = tokenService;
        }

        // ==========================
        // REGISTER
        // ==========================
        [HttpPost("register")]
        public async Task<IActionResult> Register(
            RegisterDto dto)
        {
            if (await _context.Users
                .AnyAsync(x =>
                    x.Email == dto.Email))
            {
                return BadRequest(
                    "Email already exists.");
            }

            var userRole =
                await _context.Roles
                    .FirstOrDefaultAsync(
                        x => x.RoleName == "User");

            if (userRole == null)
            {
                return BadRequest(
                    "User role not found.");
            }

            var user = new User
            {
                Name = dto.Name,
                Email = dto.Email,
                Phone = dto.Phone,
                Address = dto.Address,
                PasswordHash =
                    HashPassword(dto.Password),
                RoleID =
                    userRole.RoleID,
                CreatedDate =
                    DateTime.Now
            };

            _context.Users.Add(user);

            await _context.SaveChangesAsync();

            return Ok(
                "Registration Successful");
        }

        // ==========================
        // LOGIN
        // ==========================
        [HttpPost("login")]
        public async Task<ActionResult<AuthResponseDto>> Login(LoginDto dto)
        {
            var hashedPassword = HashPassword(dto.Password);
            var user = await _context.Users
                .Include(u => u.Role)
                .FirstOrDefaultAsync(u =>
                    u.Email == dto.Email);

            if (user == null ||
                user.PasswordHash != hashedPassword)
            {
                return Unauthorized(
                    "Invalid Email or Password");
            }

            var token = _tokenService.CreateToken(user);

            return Ok(new AuthResponseDto
            {
                Token = token,
                Name = user.Name,
                Role = user.Role?.RoleName ?? ""
            });
        }
        // ==========================
        // GET CURRENT USER
        // ==========================
        [HttpGet("{id}")]
        public async Task<IActionResult>
            GetUser(int id)
        {
            var user =
                await _context.Users
                    .Include(x => x.Role)
                    .FirstOrDefaultAsync(
                        x => x.UserID == id);

            if (user == null)
            {
                return NotFound(
                    "User not found.");
            }

            return Ok(new
            {
                user.UserID,
                user.Name,
                user.Email,
                user.Phone,
                user.Address,
                Role =
                    user.Role?.RoleName
            });
        }

        // ==========================
        // HASH PASSWORD
        // ==========================
        private string HashPassword(
            string password)
        {
            using var sha256 =
                SHA256.Create();

            var bytes =
                Encoding.UTF8.GetBytes(
                    password);

            var hash =
                sha256.ComputeHash(bytes);

            return Convert
                .ToBase64String(hash);
        }
    }
}