#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
export PATH="$HOME/.local/node/bin:$PATH"

# Start the backend API in the background
cd server
python3 app.py &
backend_pid=$!

cleanup() {
  kill "$backend_pid" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

sleep 5

# Start the frontend
cd ../frontend
npm start

wait "$backend_pid"
