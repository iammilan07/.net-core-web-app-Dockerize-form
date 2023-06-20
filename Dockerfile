# Base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Set the working directory
WORKDIR /app

# Copy the .csproj file
COPY *.csproj ./

# Restore dependencies
RUN dotnet restore

# Copy the remaining files
COPY . ./

# Build the project
RUN dotnet publish -c Release -o out

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0

# Set the working directory
WORKDIR /app

# Copy the published output from build image
COPY --from=build-env /app/out .

# Expose the port your app is listening on (e.g., 80 for HTTP)
EXPOSE 80

# Set the entry point
ENTRYPOINT ["dotnet", "FirstWebApp.dll"]
