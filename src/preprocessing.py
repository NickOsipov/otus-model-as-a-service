from typing import Optional, Tuple

import pandas as pd
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split


def load_data() -> pd.DataFrame:
    """
    Function to load the iris dataset from sklearn and return it as a pandas DataFrame.

    Returns
    -------
    pd.DataFrame
        The iris dataset as a pandas DataFrame.

    Notes
    -----
    The iris dataset is a classic dataset in machine learning and is used to demonstrate.
    """
    iris = load_iris()
    # pylint: disable=no-member
    df = pd.DataFrame(iris.data, columns=iris.feature_names)
    df = df.rename(
        columns={
            "sepal length (cm)": "sepal_length",
            "sepal width (cm)": "sepal_width",
            "petal length (cm)": "petal_length",
            "petal width (cm)": "petal_width",
        }
    )
    df["target"] = iris.target
    return df


def split_data(
    df: pd.DataFrame,
    test_size: float = 0.2,
    random_state: int = 42,
    stratify: Optional = None,
) -> Tuple[pd.DataFrame, pd.DataFrame]:
    """
    Function to split the data into training and test sets.

    Parameters
    ----------
    df : pd.DataFrame
        The DataFrame containing the data to split.
    test_size : float, optional
        The proportion of the dataset to include in the test split, by default 0.2.
    random_state : int, optional
        The random state to use, by default 42.
    stratify : Optional, optional
        The variable to stratify the data on, by default None.

    Returns
    -------
    Tuple[pd.DataFrame, pd.DataFrame]
        A tuple containing the training and test DataFrames.
    """
    train, test = train_test_split(
        df, test_size=test_size, random_state=random_state, stratify=stratify
    )
    return train, test
