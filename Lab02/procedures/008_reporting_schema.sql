-- Time dimension
CREATE TABLE dim_time (
    time_id SERIAL PRIMARY KEY,
    date DATE,
    day INT,
    month INT,
    quarter INT,
    year INT,
    weekday TEXT
);

-- Ratings dimension
CREATE TABLE dim_ratings (
    rating_id SERIAL PRIMARY KEY,
    player_id INT,
    race_id INT,
    rating SMALLINT
);
