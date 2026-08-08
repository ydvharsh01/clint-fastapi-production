import logging
from fastapi import FastAPI

# Application logger
app_logger = logging.getLogger("clint-fastapi")
app_logger.setLevel(logging.INFO)

# Normal application logs
app_handler = logging.FileHandler("/var/log/clint-fastapi/app.log")
app_handler.setLevel(logging.INFO)

# Error logs
error_handler = logging.FileHandler("/var/log/clint-fastapi/error.log")
error_handler.setLevel(logging.ERROR)

# Log format
formatter = logging.Formatter(
    "%(asctime)s - %(levelname)s - %(name)s - %(message)s"
)

app_handler.setFormatter(formatter)
error_handler.setFormatter(formatter)

app_logger.addHandler(app_handler)
app_logger.addHandler(error_handler)


app = FastAPI()


@app.on_event("startup")
def startup_event():
    app_logger.info("FastAPI application started")


@app.get("/")
def home():
    app_logger.info("GET / request received")

    return {
        "message": "Hello from production server!",
        "status": "running"
    }


@app.get("/health")
def health():
    app_logger.info("GET /health request received")

    return {
        "status": "healthy"
    }
