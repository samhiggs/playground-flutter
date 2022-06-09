# See: https://github.com/tiangolo/fastapi/issues/381 for this versioning soln
from typing import List
from fastapi import FastAPI, Depends
from app.settings import Settings
from . import crud, models, schemas
from .database import SessionLocal, engine
from sqlalchemy.orm import Session

# create models if they don't already exist
models.Base.metadata.create_all(bind=engine)

app = FastAPI()

api_v1 = FastAPI()
# api_v2 = FastAPI()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@api_v1.get("/items/", response_model=List[schemas.Item], tags=["item"])
async def list_items(db: Session = Depends(get_db)):
    return crud.get_items(db=db)


@api_v1.post("/items/", response_model=schemas.Item, tags=["item"])
async def create_item(item: schemas.ItemCreate, db: Session = Depends(get_db)):
    return crud.create_item(db=db, item=item)


@api_v1.delete("/items/{item_id}")
async def delete_item(item_id: int, db: Session = Depends(get_db)):
    crud.delete_item(db=db, id=item_id)


@api_v1.put("/items/{item_id}", response_model=schemas.Item, tags=["item"])
async def update_item(
    item: schemas.ItemUpdate, item_id: int, db: Session = Depends(get_db)
):
    return crud.update_item(db=db, item=item, id=item_id)


@api_v1.post("/items/{item_id}/purchase/", response_model=schemas.Item, tags=["item"])
async def purchase_item(item_id: int, db: Session = Depends(get_db)):
    return crud.update_purchased(db=db, id=item_id, purchased=True)


@api_v1.post("/items/{item_id}/unpurchase/", response_model=schemas.Item, tags=["item"])
async def unpurchase_item(item_id: int, db: Session = Depends(get_db)):
    return crud.update_purchased(db=db, id=item_id, purchased=False)


app.mount("/v1", api_v1)
# app.mount("/v2", api_v2)
