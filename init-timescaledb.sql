-- Enable TimescaleDB
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- Create the evidence_ts table
CREATE TABLE IF NOT EXISTS evidence_ts (
    ts TIMESTAMPTZ PRIMARY KEY NOT NULL,
    evidence_uuid TEXT NOT NULL,
    evidence_status JSONB NOT NULL,
    labels JSONB NOT NULL
);

-- Convert it to a hypertable
SELECT create_hypertable('evidence_ts', 'ts', if_not_exists => TRUE);

CREATE INDEX ON evidence_ts USING GIN (labels);
