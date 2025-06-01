-- 001_init_schema.sql
-- Initial Schema Setup for SpeedVerse
-- Author: Saadman Sakib 210042165
-- Description: Creates base tables and inserts sample data

DROP TABLE IF EXISTS car_parts, race_rewards, race_participation, player_preferences, parts, cars, races, players;

-- 1. Players
CREATE TABLE players 
(
    player_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Cars
CREATE TABLE cars 
(
    car_id SERIAL PRIMARY KEY,
    player_id INT REFERENCES players(player_id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    model VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Parts
CREATE TABLE parts 
(
    part_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    part_type VARCHAR(50) NOT NULL,
    rarity VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Car-Parts Junction Table (Many-to-Many)
CREATE TABLE car_parts 
(
    car_id INT REFERENCES cars(car_id) ON DELETE CASCADE,
    part_id INT REFERENCES parts(part_id) ON DELETE CASCADE,
    PRIMARY KEY (car_id, part_id)
);

-- 5. Races
CREATE TABLE races 
(
    race_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    duration_minutes INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    average_rating FLOAT DEFAULT 0.0
);

-- 6. Race Participation (Many Cars per Race)
CREATE TABLE race_participation 
(
    participation_id SERIAL PRIMARY KEY,
    car_id INT REFERENCES cars(car_id) ON DELETE CASCADE,
    race_id INT REFERENCES races(race_id) ON DELETE CASCADE,
    completed_at TIMESTAMP,
    is_up_vote BOOLEAN
);

-- 7. Race Rewards (Many-to-Many: races ⇄ parts)
CREATE TABLE race_rewards 
(
    race_id INT REFERENCES races(race_id) ON DELETE CASCADE,
    part_id INT REFERENCES parts(part_id) ON DELETE CASCADE,
    PRIMARY KEY (race_id, part_id)
);

-- 8. Player Preferred Part Types
CREATE TABLE player_preferences 
(
    player_id INT REFERENCES players(player_id) ON DELETE CASCADE,
    part_type VARCHAR(50) NOT NULL,
    PRIMARY KEY (player_id, part_type)
);

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