#!/bin/bash

# Restart all background services

echo "Restarting background services..."
bun run services:stop
sleep 2
bun run services:start
