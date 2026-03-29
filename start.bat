@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo Starting AI QA Assistant...

REM Kill existing Python processes
taskkill /F /IM python.exe >nul 2>&1

REM Read API Key from .env file
for /f "tokens=2 delims==" %%A in ('findstr /R "GEMINI_API_KEY" backend\.env') do set GEMINI_API_KEY=%%A

REM Start Backend with environment variable
echo Starting Backend on port 8000...
start "Backend - AI QA" cmd /k "set GEMINI_API_KEY=%GEMINI_API_KEY% && cd backend && uvicorn main:app --host 127.0.0.1 --port 8000"

REM Wait for backend to start
timeout /t 3 /nobreak

REM Start Frontend
echo Starting Frontend on port 8001...
start "Frontend - AI QA" cmd /k "cd frontend && python -m http.server 8001"

REM Wait for frontend to start
timeout /t 2 /nobreak

REM Open browser
echo Opening browser...
start http://localhost:8001

echo.
echo ========================================
echo AI QA Assistant is now running!
echo Backend: http://127.0.0.1:8000
echo Frontend: http://localhost:8001
echo ========================================
echo You can now ask your questions!
echo.
