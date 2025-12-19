--Task 4b : quest ratings and rewards monthly

CREATE OR REPLACE PROCEDURE sp_quest_ratings_rewards_monthly 
(
    p_result OUT report_types.ref_cursor
) AS
BEGIN
    OPEN p_result FOR
        SELECT
            q.quest_name,
            t.month,
            t.year,
            AVG(fr.rating) AS avg_rating,
            AVG(fp.reward_points) AS avg_reward_points
        FROM fact_quest_ratings fr
        JOIN fact_quest_participation fp
            ON fr.quest_id = fp.quest_id
        JOIN dim_quest q
            ON fr.quest_id = q.quest_id
        JOIN dim_time t
            ON fr.time_id = t.time_id
        GROUP BY q.quest_name, t.month, t.year
        ORDER BY t.year, t.month;
END;
/
