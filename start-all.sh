#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
export PATH="$HOME/.local/node/bin:$PATH"

if ! command -v npm >/dev/null 2>&1; then
  echo "npm not found in PATH. Make sure Node is installed or local node is available at ~/.local/node/bin"
  exit 1
fi

cd server
python3 app.py &
backend_pid=$!

cleanup() {
  kill "$backend_pid" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

sleep 5

cd ../frontend
npm start

wait "$backend_pid"
