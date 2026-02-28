#!/bin/bash

# Stop all background services

echo "Stopping background services..."

# Stop Tracking Service
if [ -f /home/z/my-project/mini-services/tracking-service/tracking-service.pid ]; then
  PID=$(cat /home/z/my-project/mini-services/tracking-service/tracking-service.pid)
  if ps -p $PID > /dev/null 2>&1; then
    echo "Stopping Tracking Service (PID: $PID)..."
    kill $PID
    rm /home/z/my-project/mini-services/tracking-service/tracking-service.pid
    echo "Tracking Service stopped"
  else
    echo "Tracking Service process not found"
    rm /home/z/my-project/mini-services/tracking-service/tracking-service.pid
  fi
else
  echo "Tracking Service PID file not found"
fi

# Kill any remaining processes on port 3003
if lsof -i :3003 > /dev/null 2>&1; then
  echo "Killing any remaining process on port 3003..."
  lsof -ti :3003 | xargs kill -9
fi

echo ""
echo "Services status:"
bun run services:status
