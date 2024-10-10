"""
Application
"""

import os

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import pandas as pd
from loguru import logger

from src.inference import load_model, predict


logger.info("Loading model")
MODEL_PATH = os.path.join("models", "model.joblib")
MODEL = load_model(MODEL_PATH)
logger.info("Model loaded")


app = FastAPI()

class IrisFeatures(BaseModel):
    """Iris features"""
    sepal_length: float
    sepal_width: float
    petal_length: float
    petal_width: float

@app.get("/")
def health_check() -> dict:
    """Health check"""
    return {"status": "ok"}


@app.post("/predict")
def make_prediction(features: IrisFeatures) -> dict:
    """Make a prediction by model"""
    try:
        data = pd.DataFrame([features.model_dump()])
        prediction = predict(MODEL, data)
        classes = ["setosa", "versicolor", "virginica"]
        pred_class = classes[prediction[0]]
    except Exception as e:
        logger.error(f"Prediction error: {e}")
        raise HTTPException(
            status_code=500, 
            detail="An error occurred during prediction"
        )
    
    return {"prediction": pred_class}

# {
#     "sepal_length": 5.1,
#     "sepal_width": 3.3,
#     "petal_length": 1.7,
#     "petal_width": 0.5
# }