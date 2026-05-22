#!/bin/bash
echo "============================================================"
echo "INITIALIZING RUNTIME DEPLOYMENT ENGINE (UBUNTU i3 HARDWARE)"
echo "============================================================"

# Step 1: Run Python 3 Base Construction Model
echo "[Step 1] Constructing isolated directory structures..."
python3 build_ecosystem.py
if [ $? -ne 0 ]; then
    echo "[ERROR] Repository creation failed. Ensure python3 is installed."
    exit 1
fi

# Step 2: Process System Dependency Links
echo "[Step 2] Pulling Node backend modules..."
cd backend && npm install && cd ..

echo "[Step 3] Pulling Frontend asset modules..."
cd frontend && npm install && cd ..

echo "[Step 4] Spinning up Python worker environments..."
cd ai-agent && pip3 install -r requirements.txt --break-system-packages 2>/dev/null || pip3 install -r requirements.txt && cd ..

# Step 3: Multi-Process Execution Background Orchestration
echo "[Step 5] Spawning clean background engine loops..."

# Boot backend engine and write console logs silently to storage
cd backend && npm start > ../backend_runtime.log 2>&1 &
echo "[✓] Backend Service Process running in background (PID: $!)"
cd ..

# Boot user layout display interfaces cleanly
cd frontend && npm run dev > ../frontend_runtime.log 2>&1 &
echo "[✓] Frontend UI Framework running in background (PID: $!)"
cd ..

echo "============================================================"
echo "DEPLOYMENT COMPLETE - LOGS CAPTURED IN ROOT DIRECTORY"
echo "To terminate process hooks cleanly, call: killall node"
echo "============================================================"
