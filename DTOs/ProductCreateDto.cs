using Microsoft.AspNetCore.Http;

public class ProductCreateDto
{
    public string ProductName { get; set; }

    public decimal Price { get; set; }

    public int Stock { get; set; }

    public int CategoryID { get; set; }

    public IFormFile? ProductImage { get; set; }

    public IFormFile InvoicePdf { get; set; }
}