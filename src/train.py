import pandas as pd

from sklearn.ensemble import RandomForestClassifier
from sklearn.base import BaseEstimator
from sklearn.metrics import accuracy_score


def train_model(
    train: pd.DataFrame,
    model: BaseEstimator=RandomForestClassifier,
    model_params: dict = {"n_estimators": 100},
) -> RandomForestClassifier:
    """
    Function to train a model on the training data.

    Parameters
    ----------
    model : BaseEstimator, optional
        The model to train, by default RandomForestClassifier.
    train : pd.DataFrame
        The training data to train the model on.

    Returns
    -------
    RandomForestClassifier
        The trained model.
    """
    X = train.drop("target", axis=1)
    y = train["target"]
    clf = model(**model_params)
    clf.fit(X, y)
    return clf


def evaluate_model(
    model: RandomForestClassifier, test: pd.DataFrame
) -> float:
    """
    Function to evaluate the model on the test data.

    Parameters
    ----------
    model : RandomForestClassifier
        The trained model to evaluate.
    test : pd.DataFrame
        The test data to evaluate the model on.

    Returns
    -------
    float
        The accuracy of the model on the test data.
    """
    X = test.drop("target", axis=1)
    y = test["target"]
    y_pred = model.predict(X)
    return accuracy_score(y, y_pred)