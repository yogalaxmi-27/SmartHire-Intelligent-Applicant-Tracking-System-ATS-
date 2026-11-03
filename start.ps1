@echo off
REM SmartHire Deployment Script for Windows

echo.
echo ============================================
echo    SmartHire Application Deployment
echo ============================================
echo.

REM Check Docker
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not installed
    echo Please install Docker Desktop from https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

echo [OK] Docker is installed
echo.

REM Check Docker Compose
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker Compose is not installed
    pause
    exit /b 1
)

echo [OK] Docker Compose is installed
echo.

REM Create .env if not exists
if not exist ".env" (
    echo [INFO] Creating .env file from template...
    copy .env.example .env
    echo [OK] .env created. Please update with your settings.
)

echo.
echo [INFO] Starting SmartHire services with Docker Compose...
docker-compose up -d

echo.
echo [INFO] Waiting for services to start...
timeout /t 5 /nobreak

echo.
echo [INFO] Checking service health...
echo.

REM Check Backend
echo Checking Backend...
powershell -NoProfile -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:5000' -UseBasicParsing -ErrorAction SilentlyContinue; if($response.StatusCode -eq 200) { Write-Host '[OK] Backend is running on http://localhost:5000' -ForegroundColor Green } } catch { Write-Host '[ERROR] Backend failed to respond' -ForegroundColor Red }"

REM Check Frontend
echo Checking Frontend...
powershell -NoProfile -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:3000' -UseBasicParsing -ErrorAction SilentlyContinue; if($response.StatusCode -eq 200) { Write-Host '[OK] Frontend is running on http://localhost:3000' -ForegroundColor Green } } catch { Write-Host '[ERROR] Frontend failed to respond' -ForegroundColor Red }"

echo.
echo ============================================
echo    SmartHire is Ready!
echo ============================================
echo.
echo Frontend:   http://localhost:3000
echo Backend:    http://localhost:5000
echo API Docs:   http://localhost:5000/api
echo.
echo Commands:
echo   View logs:  docker-compose logs -f
echo   Stop:       docker-compose down
echo   Restart:    docker-compose restart
echo.
docker-compose logs -f
