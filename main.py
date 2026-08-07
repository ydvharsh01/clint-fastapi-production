from fastapi import FastAPI

app = FastAPI()

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
