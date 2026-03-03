# eShop Legacy WebForms - Docker Deployment

This guide explains how to run the Legacy WebForms application in Docker containers.

## Prerequisites

- Windows 10/11 or Windows Server with Docker Desktop installed
- Docker Desktop configured for Windows Containers (not Linux containers)
- Visual Studio 2017/2019/2022 with .NET Framework 4.7.2 or later
- Developer Command Prompt for Visual Studio

## Quick Start

1. Open a **Developer Command Prompt for VS** (to ensure you have the right `msbuild` on `PATH`)

2. Navigate to the eShopLegacyWebFormsSolution directory:
   ```cmd
   cd eShopLegacyWebFormsSolution
   ```

3. Run the build script to build the project and create Docker images:
   ```cmd
   build.cmd
   ```

   This script will:
   - Restore NuGet packages
   - Build the WebForms project
   - Publish the application to the `deploy/webforms` folder
   - Create the Docker image `eshop/legacywebforms`
   - Create a SQL Server container image

4. Start the containers:
   ```cmd
   docker-compose up
   ```

5. Access the application:
   - **WebForms app**: http://localhost:5112
   - **SQL Server**: localhost:5433

## Configuration

### Using Mock Data vs Real Database

By default, the application is configured to connect to the SQL Server container. You can modify the `docker-compose.override.yml` file to change the behavior:

- To use mock data (no database required):
  ```yaml
  environment:
    - UseMockData=True
  ```

- To use the real database:
  ```yaml
  environment:
    - UseMockData=False
    - CatalogDBContext=Server=sql.data;Database=Microsoft.eShopOnContainers.Services.CatalogDb;User Id=sa;Password=Pass@word
  ```

### Ports

The application uses the following ports:
- **5112**: Legacy WebForms application
- **5433**: SQL Server

You can change these in the `docker-compose.override.yml` file.

## Troubleshooting

### Localhost Loopback Limitation

Due to a NAT limitation in Windows Containers, you might not be able to access containers using `localhost` from the host computer in older Windows versions.

**Workaround:** Use the container's internal IP address:

1. Find the container ID:
   ```cmd
   docker ps
   ```

2. Get the container's IP:
   ```cmd
   docker inspect <CONTAINER-ID> -f {{.NetworkSettings.Networks.nat.IPAddress}}
   ```

3. Access the application using the IP and port 80:
   ```
   http://<CONTAINER-IP>:80
   ```

### Build Errors

If you encounter build errors:
- Ensure you're using a Developer Command Prompt for Visual Studio
- Verify NuGet packages are restored: `nuget restore eShopLegacyWebForms.sln`
- Check that .NET Framework 4.7.2 SDK is installed

### Docker Errors

- Ensure Docker Desktop is running
- Verify you're using Windows Containers (not Linux containers)
- Try restarting Docker Desktop

## Stopping the Containers

To stop the running containers:
```cmd
docker-compose down
```

To stop and remove all containers, networks, and volumes:
```cmd
docker-compose down -v
```

## Viewing Logs

To view logs from the containers:
```cmd
docker-compose logs -f
```

## Additional Commands

- View running containers: `docker ps`
- View all images: `docker images`
- Rebuild images: `docker-compose build --no-cache`
- Remove unused images: `docker image prune`
