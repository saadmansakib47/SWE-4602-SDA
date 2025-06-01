CREATE OR REPLACE PROCEDURE add_race_rating(car_id INT, race_id INT, rating_value SMALLINT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE race_participation
    SET rating = rating_value,
        rating_timestamp = CURRENT_TIMESTAMP
    WHERE car_id = car_id AND race_id = race_id;

    CALL recalculate_race_ratings();
END;
$$;
