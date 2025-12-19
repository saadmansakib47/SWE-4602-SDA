--Task 4a : region wise popular quests

CREATE OR REPLACE PROCEDURE sp_region_popular_quests (
    p_result OUT report_types.ref_cursor
) AS
BEGIN
    OPEN p_result FOR
        SELECT
            r.region_name,
            q.quest_name,
            COUNT(fr.rating) AS total_votes
        FROM fact_quest_ratings fr
        JOIN dim_player p ON fr.player_id = p.player_id
        JOIN dim_region r ON p.region_id = r.region_id
        JOIN dim_quest q ON fr.quest_id = q.quest_id
        GROUP BY r.region_name, q.quest_name
        ORDER BY r.region_name, total_votes DESC;
END;
/

