CREATE SCHEMA IF NOT EXISTS change_log;

CREATE TABLE change_log.changelog (
    id SERIAL PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by TEXT NOT NULL,
    script_name TEXT NOT NULL,
    script_details TEXT
);
