--SAMPLE DATA--

--USERS
INSERT INTO users (name, age, gender) VALUES
('Arijit', 22, 'male'),
('Riya', 24, 'female');

--SLEEP_SESSIONS
INSERT INTO sleep_sessions
(user_id, sleep_date, bed_time, wake_time, total_sleep_minutes)
VALUES
(1, '2026-02-20', '2026-02-20 23:00:00', '2026-02-21 07:00:00', 420),
(1, '2026-02-21', '2026-02-21 23:30:00', '2026-02-22 06:30:00', 360),
(2, '2026-02-20', '2026-02-20 22:45:00', '2026-02-21 06:45:00', 450);

--SLEEP_CYCLES
INSERT INTO sleep_cycles
(session_id, cycle_number, start_time, end_time, duration_minutes)
VALUES
(1, 1, '2026-02-20 23:00:00', '2026-02-21 00:30:00', 90),
(1, 2, '2026-02-21 00:30:00', '2026-02-21 02:00:00', 90),
(2, 1, '2026-02-21 23:30:00', '2026-02-22 01:00:00', 90),
(3, 1, '2026-02-20 22:45:00', '2026-02-21 00:15:00', 90);

--SLEEP_STAGES
INSERT INTO sleep_stages
(cycle_id, stage_type, start_time, end_time, duration_minutes)
VALUES
-- Session 1
(1, 'LIGHT', '2026-02-20 23:00:00', '2026-02-20 23:30:00', 30),
(1, 'DEEP',  '2026-02-20 23:30:00', '2026-02-21 00:00:00', 30),
(1, 'REM',   '2026-02-21 00:00:00', '2026-02-21 00:30:00', 30),

-- Session 2
(3, 'LIGHT', '2026-02-21 23:30:00', '2026-02-22 00:00:00', 30),
(3, 'REM',   '2026-02-22 00:00:00', '2026-02-22 00:30:00', 30),
(3, 'AWAKE', '2026-02-22 00:30:00', '2026-02-22 01:00:00', 30);

--SLEEP_QUALITY_METRICS
INSERT INTO sleep_quality_metrics
(session_id, rem_percentage, deep_percentage, sleep_score)
VALUES
(1, 20.0, 25.0, 80),
(2, 15.0, 10.0, 60),
(3, 22.0, 30.0, 85);

--Queries--

--Calculates average REM% and Deep% across all sessions per user.
SELECT
    u.name,
    ROUND(AVG(m.rem_percentage), 2) AS avg_rem_percentage,
    ROUND(AVG(m.deep_percentage), 2) AS avg_deep_percentage
FROM users u
JOIN sleep_sessions s ON u.user_id = s.user_id
JOIN sleep_quality_metrics m ON s.session_id = m.session_id
GROUP BY u.user_id;

---

--Poor Sleep Detection Report: Identifies nights where Sleep score < 65 OR Deep sleep < 15%
SELECT
    u.name,
    s.sleep_date,
    m.sleep_score,
    m.deep_percentage
FROM sleep_sessions s
JOIN users u ON s.user_id = u.user_id
JOIN sleep_quality_metrics m ON s.session_id = m.session_id
WHERE m.sleep_score < 65
   OR m.deep_percentage < 15;

--Sleep Efficiency Analysis:shows how much of the time in bed was actually spent sleeping.
SELECT
    u.name,
    s.sleep_date,
    s.total_sleep_minutes,
    ROUND(
        (s.total_sleep_minutes * 100.0) /
        ((julianday(s.wake_time) - julianday(s.bed_time)) * 24 * 60),
    2) AS sleep_efficiency_percentage
FROM sleep_sessions s
JOIN users u ON s.user_id = u.user_id;


--Number of Cycles Per Night
SELECT
    u.name,
    s.sleep_date,
    COUNT(c.cycle_id) AS number_of_cycles
FROM sleep_sessions s
JOIN users u ON s.user_id = u.user_id
JOIN sleep_cycles c ON s.session_id = c.session_id
GROUP BY s.session_id;
