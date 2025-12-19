CREATE TABLE dim_region (
    region_id     NUMBER PRIMARY KEY,
    region_name   VARCHAR2(50) NOT NULL
);

CREATE TABLE dim_player (
    player_id     NUMBER PRIMARY KEY,
    username      VARCHAR2(50) NOT NULL,
    region_id     NUMBER NOT NULL,

    CONSTRAINT fk_dim_player_region
        FOREIGN KEY (region_id)
        REFERENCES dim_region(region_id)
);

CREATE TABLE dim_quest (
    quest_id      NUMBER PRIMARY KEY,
    quest_name    VARCHAR2(100) NOT NULL,
    difficulty    VARCHAR2(20)
);

CREATE TABLE dim_item (
    item_id        NUMBER PRIMARY KEY,
    item_name      VARCHAR2(100) NOT NULL,
    item_type      VARCHAR2(50),
    reward_points  NUMBER
);

--Task 1 : Add dim_time table
CREATE TABLE dim_time (
    time_id        NUMBER PRIMARY KEY,
    date_value     DATE NOT NULL,
    day            NUMBER,
    month          NUMBER,
    quarter        NUMBER,
    year           NUMBER,
    weekday        VARCHAR2(10)
);


