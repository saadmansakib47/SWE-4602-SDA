--Task 4c : player activity summary (quest completed, total time, reward points)

CREATE OR REPLACE PROCEDURE sp_player_activity_summary (
    p_result OUT report_types.ref_cursor
) AS
BEGIN
    OPEN p_result FOR
        SELECT
            p.username,
            COUNT(fp.quest_id) AS quests_completed,
            SUM(fp.duration_minutes) AS total_time,
            SUM(fp.reward_points) AS reward_points
        FROM fact_quest_participation fp
        JOIN dim_player p ON fp.player_id = p.player_id
        GROUP BY p.username
        ORDER BY quests_completed DESC;
END;
/