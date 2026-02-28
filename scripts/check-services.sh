#!/bin/bash

# Check status of all background services

echo "========================================="
echo "Background Services Status"
echo "========================================="
echo ""

# Check Tracking Service (port 3003)
if ss -tlnp 2>/dev/null | grep -q :3003; then
  PID=$(ss -tlnp 2>/dev/null | grep :3003 | grep -oP 'pid=\K[0-9]+' | head -1)
  if [ -z "$PID" ]; then
    PID=$(lsof -ti :3003 2>/dev/null | head -1)
  fi
  echo "✓ Tracking Service (WebSocket): RUNNING"
  echo "  Port: 3003"
  echo "  PID: ${PID:-N/A}"
  if [ -n "$PID" ] && ps -p $PID > /dev/null 2>&1; then
    echo "  Command: $(ps -p $PID -o cmd=)"
  fi
else
  echo "✗ Tracking Service (WebSocket): STOPPED"
fi
echo ""

# Check Next.js (port 3000)
if ss -tlnp 2>/dev/null | grep -q :3000; then
  PID=$(ss -tlnp 2>/dev/null | grep :3000 | grep -oP 'pid=\K[0-9]+' | head -1)
  if [ -z "$PID" ]; then
    PID=$(lsof -ti :3000 2>/dev/null | head -1)
  fi
  echo "✓ Next.js Dev Server: RUNNING"
  echo "  Port: 3000"
  echo "  PID: ${PID:-N/A}"
  if [ -n "$PID" ] && ps -p $PID > /dev/null 2>&1; then
    echo "  Command: $(ps -p $PID -o cmd=)"
  fi
else
  echo "✗ Next.js Dev Server: STOPPED"
fi
echo ""

# Check for log files
echo "========================================="
echo "Log Files"
echo "========================================="
if [ -f /home/z/my-project/dev.log ]; then
  echo "✓ Next.js Log: /home/z/my-project/dev.log"
else
  echo "✗ Next.js Log not found"
fi

if [ -f /home/z/my-project/mini-services/tracking-service/tracking-service.log ]; then
  echo "✓ Tracking Service Log: /home/z/my-project/mini-services/tracking-service/tracking-service.log"
else
  echo "✗ Tracking Service Log not found"
fi
echo ""
