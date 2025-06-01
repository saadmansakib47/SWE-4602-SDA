CREATE OR REPLACE PROCEDURE recalculate_race_ratings()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE race r
    SET average_rating = sub.avg_rating
    FROM (
        SELECT race_id, ROUND(AVG(rating), 2) AS avg_rating
        FROM race_participation
        WHERE rating IS NOT NULL
        GROUP BY race_id
    ) sub
    WHERE r.id = sub.race_id;
END;
$$;
