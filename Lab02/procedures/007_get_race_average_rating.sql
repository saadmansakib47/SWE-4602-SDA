CREATE OR REPLACE FUNCTION get_race_average_rating(race_id INT)
RETURNS DECIMAL(3,2)
LANGUAGE SQL
AS $$
    SELECT average_rating FROM race WHERE id = race_id;
$$;
