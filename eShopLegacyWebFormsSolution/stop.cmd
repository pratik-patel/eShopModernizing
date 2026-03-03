@echo off
echo ============================================================
echo Stopping eShop Legacy WebForms Containers
echo ============================================================
echo.

docker-compose down

echo.
echo [OK] Containers stopped and removed
echo.
echo [TIP] To start again: run start.cmd
echo [TIP] To remove all data: docker-compose down -v
echo.
pause
