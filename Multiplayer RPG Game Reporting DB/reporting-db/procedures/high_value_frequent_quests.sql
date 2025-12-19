--Task 4e : most frequently played quests, with rewards more than 100 points and duration more than 30 minutes 

CREATE OR REPLACE PROCEDURE sp_high_value_frequent_quests 
(
    p_result OUT report_types.ref_cursor
) AS
BEGIN
    OPEN p_result FOR
        SELECT
            q.quest_name,
            COUNT(fp.quest_id) AS play_count,
            AVG(fp.reward_points) AS avg_reward,
            AVG(fp.duration_minutes) AS avg_duration
        FROM fact_quest_participation fp
        JOIN dim_quest q ON fp.quest_id = q.quest_id
        GROUP BY q.quest_name
        HAVING
            AVG(fp.reward_points) > 100
            AND AVG(fp.duration_minutes) > 30
        ORDER BY play_count DESC;
END;
/
