using QuestPDF.Fluent;
using QuestPDF.Infrastructure;

namespace EcommerceAPI.Services;

public class PdfService
{
    public byte[] GenerateInvoice(
        int orderId,
        string customerName,
        decimal total)
    {
        return Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Content().Column(col =>
                {
                    col.Item().Text("Ecommerce Invoice");
                    col.Item().Text($"Order ID: {orderId}");
                    col.Item().Text($"Customer: {customerName}");
                    col.Item().Text($"Total Amount: ₹{total}");
                });
            });
        }).GeneratePdf();
    }
}