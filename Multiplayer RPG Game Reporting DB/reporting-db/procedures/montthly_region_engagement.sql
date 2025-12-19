--Task 4d : monthly region based number of player engagement

CREATE OR REPLACE PROCEDURE sp_monthly_region_engagement (
    p_result OUT report_types.ref_cursor
) AS
BEGIN
    OPEN p_result FOR
        SELECT
            r.region_name,
            t.month,
            t.year,
            COUNT(DISTINCT fp.player_id) AS active_players
        FROM fact_quest_participation fp
        JOIN dim_player p ON fp.player_id = p.player_id
        JOIN dim_region r ON p.region_id = r.region_id
        JOIN dim_time t ON fp.time_id = t.time_id
        GROUP BY r.region_name, t.month, t.year
        ORDER BY t.year, t.month;
END;
/