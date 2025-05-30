from typing import Union

from fastapi import FastAPI

import uvicorn

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}
    
    
def main():
    uvicorn.run("main:app", host='0.0.0.0', port=8000, workers=2, reload=False)


if __name__ == "__main__":
    main()