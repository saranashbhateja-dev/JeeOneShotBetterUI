@echo off
setlocal
cd /d "%~dp0"
where node >nul 2>nul || (echo Node.js 22 or newer is required.& pause & exit /b 1)
where npm >nul 2>nul || (echo npm is required.& pause & exit /b 1)
echo Preparing Android build. First-time Android SDK and Java setup may also be required.
call npm install --no-audit --no-fund
if errorlevel 1 goto fail
call node scripts\prepare-mobile.js
if errorlevel 1 goto fail
if not exist android\gradlew.bat call npx cap add android
if errorlevel 1 goto fail
call npx cap sync android
if errorlevel 1 goto fail
cd android
call gradlew.bat assembleDebug --no-daemon
if errorlevel 1 goto fail
 echo.
echo APK created at: %CD%\app\build\outputs\apk\debug\app-debug.apk
pause
exit /b 0
:fail
echo Android build failed. Review the error above and check Java 21, Android SDK, and network access.
pause
exit /b 1
