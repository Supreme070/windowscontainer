# Use the .NET SDK for the build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY HelloWorld.csproj .
RUN dotnet restore

# Copy the rest of the files and build the app
COPY . .
RUN dotnet publish -c Release -o out

# Use the .NET runtime for the final stage
FROM mcr.microsoft.com/dotnet/runtime:6.0
WORKDIR /app

# Copy the published app from the build stage
COPY --from=build /app/out .

# Run the app
ENTRYPOINT ["dotnet", "HelloWorld.dll"]