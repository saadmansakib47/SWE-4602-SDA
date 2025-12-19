--Task 3 : ETL Script to load data into reporting database

--Loading Dimensions
--Load regions
INSERT INTO dim_region (region_id, region_name)
SELECT region_id, region_name
FROM region;

--Load Players
INSERT INTO dim_player (player_id, username, region_id)
SELECT player_id, username, region_id
FROM player;

--Load Quests
INSERT INTO dim_quest (quest_id, quest_name, difficulty)
SELECT quest_id, quest_name, difficulty
FROM quest;

--Load Items
INSERT INTO dim_item (item_id, item_name, item_type, reward_points)
SELECT i.item_id, i.item_name, it.type_name, i.rarity * 10
FROM item i
JOIN item_type it ON i.item_type_id = it.item_type_id;

--Loading Facts 
--Load Quest Participation Facts
INSERT INTO fact_quest_participation
(player_id, quest_id, time_id, duration_minutes, reward_points)
SELECT
    c.player_id,
    cq.quest_id,
    t.time_id,
    cq.duration_minutes,
    q.reward_xp
FROM character_quest cq
JOIN character c ON cq.character_id = c.character_id
JOIN quest q ON cq.quest_id = q.quest_id
JOIN dim_time t ON t.date_value = cq.completed_at;

--Load Ratings Fact
INSERT INTO fact_quest_ratings (player_id, quest_id, rating, time_id)
SELECT
    pqv.player_id,
    pqv.quest_id,
    pqv.vote,
    t.time_id
FROM player_quest_vote pqv
JOIN dim_time t ON t.date_value = pqv.voted_at;





