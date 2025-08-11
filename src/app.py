"""
Module: app.py
Description:
    This module serves as the entry point for the application, 
    handling requests and returning predictions.
"""

import os

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import pandas as pd
from loguru import logger

from src.inference import load_model, predict

app = FastAPI()

class IrisFeatures(BaseModel):
    sepal_length: float
    sepal_width: float
    petal_length: float
    petal_width: float

class IrisPrediction(BaseModel):
    predicted_class: str

logger.info("Loading model")
MODEL_PATH = os.path.join("models", "model.joblib")
MODEL = load_model(MODEL_PATH)
logger.info("Model loaded successfully")


@app.get("/")
def health_check():
    return {"status": "ok"}

@app.post("/predict", response_model=IrisPrediction)
def get_prediction(features: IrisFeatures):
    """Predict the species of an iris flower.

    Parameters
    ----------
    features : IrisFeatures
        The features of the iris flower to classify.

    Returns
    -------
    IrisPrediction
        The predicted species of the iris flower.
    """
    try:
        data = pd.DataFrame([features.model_dump()])
        prediction = predict(MODEL, data)
        logger.info(f"Prediction made: {prediction[0]}")

        classes = {
            0: "setosa",
            1: "versicolor",
            2: "virginica"
        }

        predicted_class = classes[prediction[0]]
        logger.info(f"Predicted class: {predicted_class}")
    except Exception as e:
        logger.error(f"Error during prediction: {e}")
        raise HTTPException(status_code=500, detail="Prediction failed")
    
    return IrisPrediction(predicted_class=predicted_class)