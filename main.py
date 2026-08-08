import logging
import os

from fastapi import FastAPI

app_logger = logging.getLogger("clint-fastapi")
app_logger.setLevel(logging.INFO)

log_dir = "/var/log/clint-fastapi"

if os.path.isdir(log_dir) and os.access(log_dir, os.W_OK):
    app_handler = logging.FileHandler(f"{log_dir}/app.log")
    error_handler = logging.FileHandler(f"{log_dir}/error.log")

    formatter = logging.Formatter(
        "%(asctime)s - %(levelname)s - %(name)s - %(message)s"
    )

    app_handler.setFormatter(formatter)
    error_handler.setFormatter(formatter)

    app_logger.addHandler(app_handler)
    app_logger.addHandler(error_handler)
else:
    app_logger.addHandler(logging.StreamHandler())


app = FastAPI()


@app.on_event("startup")
def startup_event():
    app_logger.info("FastAPI application started")


@app.get("/")
def home():
    return {
        "message": "Hello from production server!",
        "status": "running"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }
