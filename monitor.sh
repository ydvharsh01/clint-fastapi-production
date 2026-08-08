#!/bin/bash

echo "===== FastAPI Production Monitor ====="

echo ""
echo "Server Time:"
date

echo ""
echo "Uptime:"
uptime

echo ""
echo "Disk Usage:"
df -h /

echo ""
echo "Memory Usage:"
free -h

echo ""
echo "FastAPI Status:"
curl -ks https://127.0.0.1/health

echo ""

echo ""
echo "Nginx Status:"
systemctl is-active nginx

echo ""

echo "Systemd FastAPI Status:"
systemctl is-active clint-fastapi

echo ""
echo "====================================="
