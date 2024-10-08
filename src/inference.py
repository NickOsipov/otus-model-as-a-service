"""
Module: inference.py
Description: 
    This module is used to load the model and make predictions on the test data.
"""

import joblib
from typing import List

import pandas as pd
from sklearn.base import BaseEstimator


def load_model(model_path: str) -> BaseEstimator:
    """
    Function to load a model from disk.

    Parameters
    ----------
    model_path : str
        The path to the model to load.

    Returns
    -------
    BaseEstimator
        The loaded model.
    """
    try:
        model = joblib.load(model_path)
        return model
    except FileNotFoundError as e:
        raise FileNotFoundError(f"Model not found at {model_path}") from e
    

def predict(model: BaseEstimator, df: pd.DataFrame) -> List[int]:
    """
    Function to make predictions on new data using a trained model.

    Parameters
    ----------
    model : BaseEstimator
        The trained model to use for prediction.
    df : pd.DataFrame
        The new data to make predictions on.

    Returns
    -------
    List[int]
        The model predictions.
    """
    return model.predict(df)
