#!/bin/bash

# Start all background services with auto-restart

echo "Starting background services..."

# Start Next.js dev server on port 3000
if ! lsof -i :3003 > /dev/null 2>&1; then
  echo "Starting Tracking Service (WebSocket) on port 3003..."
  cd /home/z/my-project/mini-services/tracking-service
  nohup bun --hot index.ts > tracking-service.log 2>&1 &
  echo $! > /home/z/my-project/mini-services/tracking-service/tracking-service.pid
  echo "Tracking Service started with PID $(cat /home/z/my-project/mini-services/tracking-service/tracking-service.pid)"
else
  echo "Tracking Service is already running on port 3003"
fi

# Check if Next.js is running
if ! lsof -i :3000 > /dev/null 2>&1; then
  echo "Next.js is not running. Start it with: bun run dev"
else
  echo "Next.js is already running on port 3000"
fi

echo ""
echo "Services status:"
bun run services:status
