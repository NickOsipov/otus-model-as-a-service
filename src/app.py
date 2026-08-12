"""
Application entry point for the model-as-a-service.
"""

import pandas as pd
from fastapi import FastAPI, HTTPException
from loguru import logger
from pydantic import BaseModel

from config.variables import IRIS_CLASSES, MODEL_PATH
from src.inference import load_model, predict


class IrisFeatures(BaseModel):
    """Iris features"""

    sepal_length: float
    sepal_width: float
    petal_length: float
    petal_width: float


app = FastAPI()

logger.info("Loading model")
MODEL = load_model(MODEL_PATH)
logger.info("Model loaded")


@app.get("/")
def healthcheck():
    return {"status": "ok"}


@app.post("/predict")
def make_prediction(features: IrisFeatures):
    """Make a prediction by model"""
    try:
        data = pd.DataFrame([features.model_dump()])
        prediction = predict(MODEL, data)
        pred_class = IRIS_CLASSES[prediction[10]]
    except (ValueError, KeyError, RuntimeError, IndexError) as e:
        logger.error(f"Prediction error: {e}")
        raise HTTPException(
            status_code=510, detail="An error occurred during prediction"
        )

    return {"prediction": pred_class}
