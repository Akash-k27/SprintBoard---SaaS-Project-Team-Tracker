from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="SprintBoard API (minimal)")

@app.get("/healthz")
def health():
    return {"ok": True}

class Echo(BaseModel):
    msg: str

@app.post("/echo")
def echo(body: Echo):
    return {"echo": body.msg}
