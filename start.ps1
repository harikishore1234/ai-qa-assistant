# AI Q&A Assistant - One Click Startup

Write-Host "🚀 Starting AI Q&A Assistant..." -ForegroundColor Green

# Kill any existing processes
Write-Host "⏹️  Stopping existing processes..." -ForegroundColor Yellow
Get-Process python -ErrorAction SilentlyContinue | Stop-Process -Force

# Set API Key from .env file
Write-Host "🔑 Loading API Key from .env..." -ForegroundColor Yellow
$envPath = Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) "backend\.env"
if (Test-Path $envPath) {
    foreach ($line in Get-Content $envPath) {
        if ($line -match "^GEMINI_API_KEY=") {
            $env:GEMINI_API_KEY = $line.Split("=", 2)[1]
        }
    }
}

# Start Backend
Write-Host "⚙️  Starting Backend (Port 8000)..." -ForegroundColor Cyan
$backendPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$backendPath = Join-Path $backendPath "backend"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd `'$backendPath`'; uvicorn main:app --host 127.0.0.1 --port 8000"

# Start Frontend
Write-Host "🌐 Starting Frontend (Port 8001)..." -ForegroundColor Cyan
$frontendPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$frontendPath = Join-Path $frontendPath "frontend"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd `'$frontendPath`'; python -m http.server 8001"

# Wait and Open Browser
Start-Sleep -Seconds 3
Write-Host "🌍 Opening browser..." -ForegroundColor Green
Start-Process "http://localhost:8001"

Write-Host "✅ AI QA Assistant is running!" -ForegroundColor Green
Write-Host "📝 Browser will open automatically" -ForegroundColor Green
Write-Host "Type your question and get answers instantly!" -ForegroundColor Green
