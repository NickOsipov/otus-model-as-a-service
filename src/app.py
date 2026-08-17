"""
Application entry point for the model-as-a-service.
"""

import pandas as pd
import psycopg2
from fastapi import FastAPI, HTTPException
from loguru import logger
from pydantic import BaseModel

from config.variables import IRIS_CLASSES, MODEL_PATH, DB_CONFIG
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
        pred_class = IRIS_CLASSES[prediction[0]]
    except (ValueError, KeyError, RuntimeError, IndexError) as e:
        logger.error(f"Prediction error: {e}")
        raise HTTPException(
            status_code=510, detail="An error occurred during prediction"
        )

    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cur = conn.cursor()
        cur.execute(
            """
            INSERT INTO predictions
                (sepal_length, sepal_width, petal_length, petal_width, prediction)
            VALUES (%s, %s, %s, %s, %s)
            """,
            (
                features.sepal_length,
                features.sepal_width,
                features.petal_length,
                features.petal_width,
                pred_class,
            ),
        )
        conn.commit()
        cur.close()
        conn.close()
    except psycopg2.Error as e:
        logger.error(f"DB error: {e}")

    return {"prediction": pred_class}
