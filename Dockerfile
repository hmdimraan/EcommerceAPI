FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src

# Copy ONLY project file first (important for restore cache)
COPY EcommerceAPI.csproj ./

# Restore explicitly
RUN dotnet restore EcommerceAPI.csproj

# Copy everything else
COPY . .

# Publish explicitly
RUN dotnet publish EcommerceAPI.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview
WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:10000

EXPOSE 10000

ENTRYPOINT ["dotnet", "EcommerceAPI.dll"]