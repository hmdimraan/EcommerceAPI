using EcommerceAPI.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(new WebApplicationOptions
{
    ContentRootPath = Directory.GetCurrentDirectory(),
    WebRootPath = "wwwroot"
});

// ADD SERVICES TO CONTAINER

builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen();

// DATABASE CONNECTION

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseMySql(
        builder.Configuration.GetConnectionString("MariaDBConnection"),
        ServerVersion.AutoDetect(
            builder.Configuration.GetConnectionString("MariaDBConnection")
        )
    )
);
// CORS POLICY FOR ANGULAR

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAngular",
        policy =>
        {
            policy
             .AllowAnyOrigin()
                .AllowAnyHeader()
                .AllowAnyMethod();
        });
});

// BUILD APPLICATION

var app = builder.Build();

// SWAGGER
app.UseSwagger();
app.UseSwaggerUI();

// MIDDLEWARE

app.UseHttpsRedirection();

// ENABLE CORS

app.UseCors("AllowAngular");
app.UseStaticFiles();
app.UseAuthorization();

// MAP CONTROLLERS

app.MapControllers();

// RUN APPLICATION

app.Run();