-- Example for loading dim_time
INSERT INTO dim_time (date, day, month, quarter, year, weekday)
SELECT DISTINCT DATE(completed_at), EXTRACT(DAY FROM completed_at),
       EXTRACT(MONTH FROM completed_at),
       EXTRACT(QUARTER FROM completed_at),
       EXTRACT(YEAR FROM completed_at),
       TO_CHAR(completed_at, 'Day')
FROM race_participation;

-- Example for copying ratings
INSERT INTO dim_ratings (player_id, race_id, rating)
SELECT DISTINCT p.player_id, rp.race_id, rp.rating
FROM race_participation rp
JOIN cars c ON rp.car_id = c.id
JOIN players p ON c.player_id = p.id
WHERE rp.rating IS NOT NULL;