"""
Main pipeline for the project
"""

import os

from loguru import logger

from config.variables import MODEL_PATH
from src.inference import save_model
from src.preprocessing import load_data, split_data
from src.train import evaluate_model, train_model


def main() -> None:
    """
    Main pipeline for the project
    """
    logger.info("-----------------")
    logger.info("Starting pipeline")
    logger.info("Loading data")
    df = load_data()

    logger.info("Splitting data")
    train, test = split_data(df)

    logger.info("Training model")
    model = train_model(train, model_params={"n_estimators": 100, "random_state": 42})

    logger.info("Saving model")
    os.makedirs(os.path.dirname(MODEL_PATH), exist_ok=True)
    save_model(model, MODEL_PATH)

    logger.info("Evaluating model")
    accuracy = evaluate_model(model, test)
    logger.info(f"Model accuracy: {accuracy}")

    logger.info("Pipeline complete")


if __name__ == "__main__":
    main()
