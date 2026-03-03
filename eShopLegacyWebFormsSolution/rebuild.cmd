@echo off
echo ============================================================
echo Rebuilding eShop Legacy WebForms
echo ============================================================
echo.

echo [1/3] Stopping any running containers...
docker-compose down
echo.

echo [2/3] Rebuilding the application...
call build.cmd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Build failed!
    pause
    exit /b 1
)
echo.

echo [3/3] Rebuilding Docker images...
docker-compose build --no-cache
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Docker build failed!
    pause
    exit /b 1
)

echo.
echo ============================================================
echo [SUCCESS] Rebuild complete!
echo ============================================================
echo.
echo To start the application, run: start.cmd
echo.
pause
