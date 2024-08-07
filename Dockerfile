FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0
RUN apt-get update
RUN apt-get install dos2unix
WORKDIR /app
COPY --from=build-env /app/out /app/
EXPOSE 8080
# CMD ["dotnet", "FirstWebApp.dll"]
CMD ["dotnet", "/app/FirstWebApp.dll", "--urls", "http://+:8080"]
