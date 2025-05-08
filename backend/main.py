from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI, Request
import psycopg2
import os

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # for dev, allows all origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/healthz")
def health_check():
    return {"status": "ok"}

def get_connection():
    return psycopg2.connect(
        dbname="postgres",
        user="postgres",
        password=os.environ["POSTGRES_PASSWORD"],
        host="db",  # name of the service in docker-compose
        port="5432"
    )

@app.post("/submit")
async def submit(data: dict):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("INSERT INTO submissions (name) VALUES (%s)", (data["name"],))
    conn.commit()
    cur.close()
    conn.close()
    return {"status": "ok"}

@app.get("/results")
def results():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM submissions")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return {"results": rows}
