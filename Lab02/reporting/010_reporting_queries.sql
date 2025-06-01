-- Reporting Queries performed by 
-- Saadman Sakib 210042165
-- Fattah Mahmud Nihal 210042161
-- Abid Shahriar 210042155

-- City-wise most popular races based on average rating
CREATE OR REPLACE FUNCTION city_wise_popular_races()
RETURNS TABLE (city TEXT, race_name TEXT, avg_rating DECIMAL)
AS $$
BEGIN
    RETURN QUERY
    SELECT r.city, r.name AS race_name, AVG(rp.rating) AS avg_rating
    FROM race_participation rp
    JOIN races r ON rp.race_id = r.race_id
    GROUP BY r.city, r.name
    ORDER BY r.city, avg_rating DESC;
END;
$$ LANGUAGE plpgsql;

-- Top 5 most rewarded players by city
CREATE OR REPLACE FUNCTION top_rewarded_players_by_city()
RETURNS TABLE (city TEXT, player_id INT, total_rewards INT)
AS $$
BEGIN
    RETURN QUERY
    SELECT r.city, c.player_id, COUNT(*) AS total_rewards
    FROM race_rewards rr
    JOIN races r ON rr.race_id = r.race_id
    JOIN race_participation rp ON rr.race_id = rp.race_id
    JOIN cars c ON rp.car_id = c.car_id
    GROUP BY r.city, c.player_id
    ORDER BY r.city, total_rewards DESC
    LIMIT 5;
END;
$$ LANGUAGE plpgsql;

-- Race Ratings & Rewards by Month
SELECT t.month, r.name AS race_name,
       AVG(rp.rating) AS avg_rating,
       COUNT(rr.part_id) AS total_rewards
FROM race_participation rp
JOIN races r ON rp.race_id = r.race_id
JOIN dim_time t ON DATE(rp.completed_at) = t.date
LEFT JOIN race_rewards rr ON rp.race_id = rr.race_id
GROUP BY t.month, r.name;

-- Player Activity Summary
CREATE OR REPLACE FUNCTION player_activity_summary(p_id INT)
RETURNS TABLE (races_completed INT, total_time INTERVAL, total_rewards INT)
AS $$
BEGIN
    RETURN QUERY
    SELECT COUNT(DISTINCT rp.race_id),
           SUM(r.duration_minutes * interval '1 minute'),
           COUNT(rr.part_id)
    FROM race_participation rp
    JOIN cars c ON rp.car_id = c.car_id
    JOIN races r ON rp.race_id = r.race_id
    LEFT JOIN race_rewards rr ON rp.race_id = rr.race_id
    WHERE c.player_id = p_id;
END;
$$ LANGUAGE plpgsql;

-- Monthly City-Based Number of Player Engagement
SELECT t.month, r.city,
       COUNT(DISTINCT c.player_id) AS engaged_players
FROM race_participation rp
JOIN cars c ON rp.car_id = c.car_id
JOIN races r ON rp.race_id = r.race_id
JOIN dim_time t ON DATE(rp.completed_at) = t.date
GROUP BY t.month, r.city;

-- Most Frequently Played Races with Avg Reward > 100 & Duration > 30 mins
SELECT r.name AS race_name,
       COUNT(*) AS times_played,
       AVG(rp.reward_points) AS avg_reward,
       AVG(r.duration_minutes) AS avg_duration
FROM race_participation rp
JOIN races r ON rp.race_id = r.race_id
GROUP BY r.name
HAVING AVG(rp.reward_points) > 100
   AND AVG(r.duration_minutes) > 30
ORDER BY times_played DESC;
