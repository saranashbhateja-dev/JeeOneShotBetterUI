@echo off
setlocal
cd /d "%~dp0"
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js 22 or newer is required. Install it from https://nodejs.org/ and run this file again.
  pause
  exit /b 1
)
start "JEE OneShot OS Server" /min cmd /c "cd /d ""%~dp0"" && node server.js"
timeout /t 2 /nobreak >nul
start "" "http://127.0.0.1:3001"
endlocal
