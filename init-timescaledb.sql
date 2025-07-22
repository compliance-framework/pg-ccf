-- Enable TimescaleDB
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- Create the evidence_ts table
CREATE TABLE IF NOT EXISTS evidence_ts (
    ts TIMESTAMPTZ NOT NULL default now(),
    evidence_uuid text NOT NULL,
    evidence_status JSONB NOT NULL,
    labels JSONB NOT NULL,
    PRIMARY KEY (ts, evidence_id)
);

-- Convert it to a hypertable
SELECT create_hypertable('evidence_ts', 'ts', if_not_exists => TRUE);

CREATE INDEX ON evidence_ts USING GIN (labels);
