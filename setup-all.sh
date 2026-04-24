#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
export PATH="$HOME/.local/node/bin:$PATH"

if ! command -v npm >/dev/null 2>&1; then
  echo "npm not found in PATH. Make sure Node is installed or local node is available at ~/.local/node/bin"
  exit 1
fi

for dir in . frontend server/frontend; do
  if [ -f "$dir/package.json" ]; then
    echo "Installing npm packages in $dir"
    (cd "$dir" && npm install)
  fi
done

echo "Installing Python dependencies for server"
python3 -m pip install --user -r server/requirements.txt

echo "Setup complete. Use './start-all.sh' to run the app."
