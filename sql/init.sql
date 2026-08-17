CREATE TABLE IF NOT EXISTS predictions (
    id SERIAL PRIMARY KEY,
    sepal_length FLOAT NOT NULL,
    sepal_width FLOAT NOT NULL,
    petal_length FLOAT NOT NULL,
    petal_width FLOAT NOT NULL,
    prediction VARCHAR(50) NOT NULL,
    prediction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);