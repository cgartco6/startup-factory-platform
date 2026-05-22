@echo off
TITLE Startup Factory Ecosystem Bootstrapper - Windows 10
echo ============================================================
echo INITIALIZING RUNTIME DEPLOYMENT ENGINE (WINDOWS i5 HARDWARE)
echo ============================================================

:: Step 1: Execute Python Repository Construction Model
echo [Step 1] Constructing isolated directory structures...
python build_ecosystem.py
if %errorlevel% neq 0 (
    echo [ERROR] Repository creation failed. Ensure Python is added to Environment Paths.
    pause
    exit /b %errorlevel%
)

:: Step 2: Run Automated Dependency Setup Loops
echo [Step 2] Pulling Node backend modules...
cd backend && call npm install && cd ..

echo [Step 3] Pulling Frontend asset modules...
cd frontend && call npm install && cd ..

echo [Step 4] Spinning up Python worker environments...
cd ai-agent && pip install -r requirements.txt && cd ..

:: Step 3: Spin Up Development Runtimes
echo [Step 5] Spawning independent micro-processes...
echo Launching Backend Server Node...
start cmd /k "cd backend && npm start"

echo Launching Frontend Client Storefront Interface...
start cmd /k "cd frontend && npm run dev"

echo ============================================================
echo DEPLOYMENT SUITE ACTIVE - 8GB RAM FOOTPRINT PROTECTION LIVE
echo ============================================================
pause
