@echo off
title SmartHire Launcher
echo ========================================================
echo               SmartHire Platform Launcher
echo ========================================================
echo.
echo [1/2] Starting SmartHire Server (Port 5000)...
start "SmartHire Server (Port 5000)" cmd /k "cd /d "%~dp0backend" && python app.py"

echo [2/2] Opening browser at http://localhost:5000 ...
timeout /t 3 >nul
start http://localhost:5000

echo.
echo ========================================================
echo   SmartHire is up and running!
echo   - App URL:    http://localhost:5000
echo   - Demo Login: Use "recruiter@smarthire.ai" or click "Demo Login"
echo ========================================================
echo.
echo Keep this window open or press any key to close.
pause
