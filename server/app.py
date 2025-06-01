import ssl
from fastapi import FastAPI

try:
    from server.routes import tempo
except ImportError:
    from routes import tempo

app = FastAPI()

ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
ssl_context.load_cert_chain("./.certs/cert.pem", "./.certs/key.pem")
app.include_router(tempo.router)


@app.get("/ping")
async def ping():
    return {"message": "pong"}
