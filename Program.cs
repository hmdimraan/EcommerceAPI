using EcommerceAPI.Data;
using EcommerceAPI.Middleware;
using EcommerceAPI.Models;
using EcommerceAPI.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Serilog;
using QuestPDF.Infrastructure;
using Microsoft.Extensions.FileProviders;
using System.Text;

Log.Logger = new LoggerConfiguration()
    .WriteTo.Console()
    .WriteTo.File("Logs/log-.txt", rollingInterval: RollingInterval.Day)
    .CreateLogger();

var builder = WebApplication.CreateBuilder(args);

// =========================
// SERILOG
// =========================
builder.Host.UseSerilog();

// =========================
// CONTROLLERS
// =========================
builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Ecommerce API",
        Version = "v1"
    });

    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Enter: Bearer {your token}"
    });

    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});

// =========================
// SERVICES
// =========================
builder.Services.AddScoped<PdfService>();
builder.Services.AddScoped<ITokenService, TokenService>();

// =========================
// DATABASE (SQL / MYSQL SUPPORT)
// =========================
var connectionString =
    Environment.GetEnvironmentVariable("MariaDBConnection")
    ?? builder.Configuration.GetConnectionString("MariaDBConnection");

if (string.IsNullOrEmpty(connectionString))
    throw new Exception("❌ Connection string is missing");

builder.Services.AddDbContext<AppDbContext>(options =>
{
    if (connectionString.Contains("SQLEXPRESS"))
    {
        options.UseSqlServer(connectionString);
    }
    else
    {
        options.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString));
    }
});

// =========================
// JWT AUTH
// =========================
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,

        ValidIssuer = builder.Configuration["Jwt:Issuer"],
        ValidAudience = builder.Configuration["Jwt:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(
            Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]!)
        )
    };
});

// =========================
// AUTHORIZATION
// =========================
builder.Services.AddAuthorization();

// =========================
// CORS
// =========================
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAngular", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

// =========================
// QUESTPDF
// =========================
QuestPDF.Settings.License = LicenseType.Community;

var app = builder.Build();

// =========================
// ROLE SEEDER
// =========================
using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider.GetRequiredService<AppDbContext>();

    if (!context.Roles.Any())
    {
        context.Roles.AddRange(
            new Role { RoleName = "Admin" },
            new Role { RoleName = "User" }
        );

        context.SaveChanges();
    }
}

// =========================
// MIDDLEWARE PIPELINE
// =========================
app.UseMiddleware<ExceptionMiddleware>();

app.UseSwagger();
app.UseSwaggerUI();

app.UseHttpsRedirection();

app.UseCors("AllowAngular");

// =========================
// STATIC FILES (IMPORTANT FOR IMAGES)
// =========================
app.UseStaticFiles(); // wwwroot root

app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(
        Path.Combine(builder.Environment.WebRootPath, "ProductImages")
    ),
    RequestPath = "/ProductImages"
});

// =========================
// AUTH
// =========================
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();