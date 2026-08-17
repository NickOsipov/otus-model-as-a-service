"""
Module: variables.py
Description: This module contains configuration variables for the application.
"""

import os


MODEL_PATH = os.path.join("models", "model.joblib")
IRIS_CLASSES = ["setosa", "versicolor", "virginica"]

DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_USER")

DB_CONFIG = {
    "host": "prediction-store",
    "port": 5432,
    "user": DB_USER,
    "password": DB_PASS,
    "dbname": "prediction_store",
}
