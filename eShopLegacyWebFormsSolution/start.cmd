@echo off
echo ============================================================
echo eShop Legacy WebForms - Docker Quick Start
echo ============================================================
echo.

echo [1/4] Checking Docker Desktop status...
docker info >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Docker Desktop is not running!
    echo.
    echo Please start Docker Desktop and wait for it to be ready.
    echo Then run this script again.
    echo.
    pause
    exit /b 1
)
echo [OK] Docker Desktop is running
echo.

echo [2/4] Checking if images need to be built...
docker images | findstr "eshop/legacywebforms" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [INFO] Images not found. Building for the first time...
    echo [INFO] This will take 15-20 minutes (downloading Windows base images)
    echo.
    docker-compose build
    if %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Build failed!
        pause
        exit /b 1
    )
    echo.
    echo [OK] Build completed successfully!
) else (
    echo [OK] Images already exist. Skipping build.
    echo [TIP] To rebuild, run: docker-compose build --no-cache
)
echo.

echo [3/4] Starting containers...
echo [INFO] Starting SQL Server and WebForms application...
echo.
start /B docker-compose up
timeout /t 10 /nobreak >nul

echo.
echo [4/4] Checking container status...
docker-compose ps
echo.

echo ============================================================
echo SUCCESS! Application is starting...
echo ============================================================
echo.
echo WebForms App:  http://localhost:5112
echo SQL Server:    localhost:5433
echo.
echo [TIP] Wait 30-60 seconds for containers to fully start
echo [TIP] To view logs: docker-compose logs -f
echo [TIP] To stop: docker-compose down
echo.
echo Opening browser in 5 seconds...
timeout /t 5 /nobreak
start http://localhost:5112
echo.
echo Press any key to exit (containers will keep running)...
pause >nul
