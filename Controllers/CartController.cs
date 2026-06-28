using EcommerceAPI.Data;
using EcommerceAPI.DTOs;
using EcommerceAPI.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace EcommerceAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class CartController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CartController(AppDbContext context)
        {
            _context = context;
        }

        private int GetUserId()
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            if (string.IsNullOrEmpty(userId))
                throw new UnauthorizedAccessException("User ID not found in token.");

            return int.Parse(userId);
        }

        // =========================
        // ADD PRODUCT TO CART
        // =========================
        [HttpPost("add")]
        public async Task<IActionResult> AddToCart(AddToCartDto dto)
        {
            int userId = GetUserId();

            var product = await _context.Products
                .FirstOrDefaultAsync(
                    p => p.ProductID == dto.ProductID);

            if (product == null)
                return NotFound("Product not found.");

            if (product.Stock <= 0)
                return BadRequest("No stock left.");

            if (dto.Quantity > product.Stock)
                return BadRequest(
                    $"Only {product.Stock} items available.");

            var cart = await _context.Carts
                .Include(c => c.CartItems)
                .FirstOrDefaultAsync(
                    c => c.UserID == userId);

            if (cart == null)
            {
                cart = new Cart
                {
                    UserID = userId
                };

                _context.Carts.Add(cart);
                await _context.SaveChangesAsync();
            }

            var cartItem = await _context.CartItems
                .FirstOrDefaultAsync(
                    ci => ci.CartID == cart.CartID
                       && ci.ProductID == dto.ProductID);

            if (cartItem == null)
            {
                cartItem = new CartItem
                {
                    CartID = cart.CartID,
                    ProductID = dto.ProductID,
                    Quantity = dto.Quantity
                };

                _context.CartItems.Add(cartItem);
            }
            else
            {
                int newQuantity =
                    cartItem.Quantity + dto.Quantity;

                if (newQuantity > product.Stock)
                {
                    return BadRequest(
                        $"Only {product.Stock} items available.");
                }

                cartItem.Quantity = newQuantity;
            }

            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "Product added to cart successfully."
            }); 
        }

        // =========================
        // GET USER CART
        // =========================
        [HttpGet]
        public async Task<IActionResult> GetCart()
        {
            int userId = GetUserId();

            var cart = await _context.Carts
                .Include(c => c.CartItems)
                .ThenInclude(ci => ci.Product)
                .FirstOrDefaultAsync(
                    c => c.UserID == userId);

            if (cart == null)
            {
                return Ok(new List<CartItem>());
            }

            return Ok(new
            {
                cart.CartID,
                cart.UserID,
                Items = cart.CartItems.Select(ci =>
                   new CartResponseDto
                   {
                       ProductID = ci.ProductID,
                       ProductName = ci.Product!.ProductName,
                       Price = ci.Product.Price,
                       Quantity = ci.Quantity,
                       ProductImagePath =
        ci.Product.ProductImagePath
                   })
            });
        }

        // =========================
        // UPDATE QUANTITY
        // =========================
        [HttpPut("update")]
        public async Task<IActionResult> UpdateQuantity(
            UpdateCartQuantityDto dto)
        {
            int userId = GetUserId();

            var cart = await _context.Carts
                .Include(c => c.CartItems)
                .FirstOrDefaultAsync(
                    c => c.UserID == userId);

            if (cart == null)
                return NotFound("Cart not found.");

            var item = cart.CartItems
                .FirstOrDefault(
                    x => x.ProductID == dto.ProductID);

            if (item == null)
                return NotFound("Item not found.");

            var product = await _context.Products
                .FirstOrDefaultAsync(
                    p => p.ProductID == dto.ProductID);

            if (product == null)
                return NotFound("Product not found.");

            if (dto.Quantity <= 0)
                return BadRequest(
                    "Quantity must be greater than zero.");

            if (dto.Quantity > product.Stock)
            {
                return BadRequest(
                    $"Only {product.Stock} items available.");
            }

            item.Quantity = dto.Quantity;

            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "Quantity updated."
            });
        }

        // =========================
        // REMOVE ITEM
        // =========================
        [HttpDelete("remove/{productId}")]
        public async Task<IActionResult> RemoveItem(
            int productId)
        {
            int userId = GetUserId();

            var cart = await _context.Carts
                .Include(c => c.CartItems)
                .FirstOrDefaultAsync(
                    c => c.UserID == userId);

            if (cart == null)
                return NotFound("Cart not found.");

            var item = cart.CartItems
                .FirstOrDefault(
                    x => x.ProductID == productId);

            if (item == null)
                return NotFound("Item not found.");

            _context.CartItems.Remove(item);

            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "Item removed successfully."
            });
        }

        // =========================
        // CLEAR CART
        // =========================
        [HttpDelete("clear")]
        public async Task<IActionResult> ClearCart()
        {
            int userId = GetUserId();

            var cart = await _context.Carts
                .Include(c => c.CartItems)
                .FirstOrDefaultAsync(
                    c => c.UserID == userId);

            if (cart == null)
                return Ok("Cart already empty.");
           
            _context.CartItems.RemoveRange(
                cart.CartItems);

            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "Cart cleared successfully."
            });
        }
    }
}