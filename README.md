# Client FastAPI Application

## Architecture

Client
↓
Nginx Reverse Proxy
↓
Uvicorn
↓
FastAPI


## Application Port

FastAPI:

127.0.0.1:8000


## Web Server

Nginx:

HTTP 80
HTTPS 443


## Service

systemd:

clint-fastapi.service


## Health Check

curl -k https://SERVER-IP/health


## Useful Commands

Restart App:

sudo systemctl restart clint-fastapi


View Logs:

sudo journalctl -u clint-fastapi -n 50


Restart Nginx:

sudo systemctl reload nginx
