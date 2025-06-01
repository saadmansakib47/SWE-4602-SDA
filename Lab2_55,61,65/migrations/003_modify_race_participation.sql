ALTER TABLE race_participation
DROP COLUMN is_up_vote;

ALTER TABLE race_participation
ADD COLUMN rating SMALLINT CHECK (rating BETWEEN 1 AND 5),
ADD COLUMN rating_timestamp TIMESTAMP;
