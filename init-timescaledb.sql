-- Enable TimescaleDB
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- Create the evidence_ts table
CREATE TABLE IF NOT EXISTS evidence_time_series (
    evidence_time TIMESTAMPTZ NOT NULL default now(),
    evidence_uuid TEXT NOT NULL,
    evidence_status JSONB NOT NULL,
    labels JSONB NOT NULL,
    PRIMARY KEY (evidence_time, evidence_uuid)
);

-- Convert it to a hypertable
SELECT create_hypertable('evidence_time_series', 'evidence_time', if_not_exists => TRUE);

CREATE INDEX ON evidence_time_series USING GIN (labels);
