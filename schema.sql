--USERS — Stores each person using the sleep tracking app--
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER CHECK (age > 0),
    gender TEXT CHECK (gender IN ('male', 'female', 'other', 'prefer_not_say'))
);

--SLEEP_SESSIONS — One row represents one full night of sleep for a user--
CREATE TABLE sleep_sessions (
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,

    sleep_date DATE NOT NULL,
    bed_time DATETIME NOT NULL,
    wake_time DATETIME NOT NULL,

    total_sleep_minutes INTEGER,

    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

---SLEEP_CYCLES — Each session is broken into multiple sleep cycles---
CREATE TABLE sleep_cycles (
    cycle_id INTEGER PRIMARY KEY AUTOINCREMENT,
    session_id INTEGER NOT NULL,

    cycle_number INTEGER NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    duration_minutes INTEGER,

    FOREIGN KEY (session_id) REFERENCES sleep_sessions(session_id)
);

---SLEEP_STAGES — Each cycle contains REM, deep, light, and awake stages---
CREATE TABLE sleep_stages (
    stage_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cycle_id INTEGER NOT NULL,

    stage_type TEXT NOT NULL
        CHECK (stage_type IN ('REM', 'DEEP', 'LIGHT', 'AWAKE')),

    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    duration_minutes INTEGER,

    FOREIGN KEY (cycle_id) REFERENCES sleep_cycles(cycle_id)
);

---SLEEP_QUALITY_METRICS — Pre-calculated sleep quality stats per session---
CREATE TABLE sleep_quality_metrics (
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    session_id INTEGER NOT NULL,

    rem_percentage REAL CHECK (rem_percentage BETWEEN 0 AND 100),
    deep_percentage REAL CHECK (deep_percentage BETWEEN 0 AND 100),
    sleep_score REAL CHECK (sleep_score BETWEEN 0 AND 100),

    FOREIGN KEY (session_id) REFERENCES sleep_sessions(session_id)
);

--Speed up queries filtering sessions by user
CREATE INDEX idx_sleep_sessions_user_id
ON sleep_sessions(user_id);

--Speed up queries retrieving cycles within a session
CREATE INDEX idx_sleep_cycles_session_id
ON sleep_cycles(session_id);

--Speed up queries retrieving stages within a cycle
CREATE INDEX idx_sleep_stages_cycle_id
ON sleep_stages(cycle_id);
