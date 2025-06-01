-- SAMPLE DATA (I have used AI to generate this part) --

-- Players
INSERT INTO players (username, email) VALUES
('Speedster1', 'speedster1@example.com'),
('RacerX', 'racerx@example.com'),
('DriftQueen', 'driftqueen@example.com');

-- Cars
INSERT INTO cars (player_id, name, model) VALUES
(1, 'Red Comet', 'RX-99'),
(1, 'Night Streak', 'ZX-3000'),
(2, 'Shadow Bolt', 'Neo-V8'),
(3, 'Sun Chaser', 'GT-Lux');

-- Parts
INSERT INTO parts (name, part_type, rarity) VALUES
('Turbo X', 'Turbo', 'Epic'),
('Grip Max Tires', 'Tire', 'Rare'),
('Overdrive Engine', 'Engine', 'Legendary'),
('Air Suspension', 'Suspension', 'Common');

-- Car Parts
INSERT INTO car_parts VALUES
(1, 1), (1, 2),
(2, 3), (3, 1),
(3, 2), (4, 4);

-- Races
INSERT INTO races (name, city, duration_minutes) VALUES
('Turbo Rally', 'NeoTokyo', 25),
('Skyline Showdown', 'Skyline Bay', 30),
('Mecha Mayhem', 'Mecha Hills', 45),
('Solar Sprint', 'Solar Drift', 40);

-- Race Participation
INSERT INTO race_participation (car_id, race_id, completed_at, is_up_vote) VALUES
(1, 1, CURRENT_TIMESTAMP - INTERVAL '3 days', true),
(2, 2, CURRENT_TIMESTAMP - INTERVAL '2 days', true),
(3, 3, CURRENT_TIMESTAMP - INTERVAL '1 day', NULL),
(4, 4, CURRENT_TIMESTAMP, false);

-- Race Rewards
INSERT INTO race_rewards VALUES
(1, 1), (1, 2),
(2, 3),
(3, 1),
(4, 4);

-- Player Preferences
INSERT INTO player_preferences VALUES
(1, 'Turbo'), (1, 'Tire'),
(2, 'Engine'),
(3, 'Suspension');