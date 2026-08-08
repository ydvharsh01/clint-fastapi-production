#!/bin/bash
set -e

PROJECT_DIR="/home/harsh/clint-fastapi"

cd "$PROJECT_DIR"

echo "Pulling latest code..."
git pull origin main

echo "Activating virtual environment..."
source "$PROJECT_DIR/.venv/bin/activate"

echo "Installing dependencies..."
pip install -r requirements.txt

echo "Checking Python syntax..."
python -m py_compile main.py

echo "Restarting FastAPI..."
sudo systemctl restart clint-fastapi

echo "Checking FastAPI service..."
sudo systemctl is-active --quiet clint-fastapi

echo "Restarting FastAPI..."
sudo systemctl restart clint-fastapi

echo "Waiting for FastAPI to become ready..."

for i in {1..15}; do
    if curl -sf http://127.0.0.1:8000/health > /dev/null; then
        echo "FastAPI is ready!"
        break
    fi

    if [ "$i" -eq 15 ]; then
        echo "ERROR: FastAPI failed to become ready."
        sudo systemctl status clint-fastapi --no-pager
        exit 1
    fi

    sleep 1
done

echo "Checking HTTPS health endpoint..."

curl -ksSf https://127.0.0.1/health

echo ""
echo "Deployment successful!"

