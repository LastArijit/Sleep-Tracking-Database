Project - Sleep Tracking Database

A relational database designed to **store, structure, and analyze human sleep patterns**.

This project models sleep scientifically by representing **sleep sessions, sleep cycles, and sleep stages** in a normalized relational structure. The system enables analytical insights such as sleep quality metrics, cycle analysis, and REM/deep sleep distribution.

The database is designed as the **data layer for a sleep tracking application**, focusing on understanding sleep structure rather than simply recording time asleep.

---

# Project Overview

Humans spend roughly **one-third of their lives sleeping**, yet most people have little insight into the structure or quality of their sleep.

This project creates a structured database capable of:

* Tracking nightly sleep sessions
* Breaking sleep into cycles
* Recording physiological sleep stages
* Calculating sleep quality metrics
* Enabling analytical queries about sleep behavior

The goal is to provide a **clean and scalable relational model** for sleep analysis.

---

# Database Structure

The database consists of **five main entities**:

| Table                     | Purpose                                         |
| ------------------------- | ----------------------------------------------- |
| **users**                 | Stores user information                         |
| **sleep_sessions**        | Stores each night's sleep session               |
| **sleep_cycles**          | Represents sleep cycles within a session        |
| **sleep_stages**          | Stores physiological sleep stages within cycles |
| **sleep_quality_metrics** | Stores calculated sleep quality metrics         |

The design follows a **hierarchical structure**:

```
User
  └── Sleep Session
        └── Sleep Cycle
              └── Sleep Stage
```

Sleep quality metrics are calculated **per session**.

---

# Entity Relationship Diagram

The database structure is illustrated in the ER diagram in Sleep.png file.

Relationships:

* **One user → many sleep sessions**
* **One sleep session → many sleep cycles**
* **One sleep cycle → many sleep stages**
* **One sleep session → one sleep quality metrics record**

---

# Sleep Stages Modeled

The database tracks four physiological sleep stages:

| Stage     | Description                         |
| --------- | ----------------------------------- |
| **REM**   | Dreaming, memory consolidation      |
| **DEEP**  | Physical recovery and muscle repair |
| **LIGHT** | Transitional sleep                  |
| **AWAKE** | Brief wake periods                  |

These stages allow deeper analysis of **sleep quality and sleep structure**.

---

# Sleep Quality Metrics

To simplify analysis, calculated metrics are stored per session:

| Metric                    | Description                             |
| ------------------------- | --------------------------------------- |
| **REM Percentage**        | Percentage of sleep spent in REM        |
| **Deep Sleep Percentage** | Percentage of sleep spent in deep sleep |
| **Sleep Score**           | Overall sleep quality score (0–100)     |

Storing these values improves **query performance** and simplifies reporting.

---

# Performance Optimizations

Indexes are used to speed up common analytical queries.

```
CREATE INDEX idx_sleep_sessions_user_id
ON sleep_sessions(user_id);

CREATE INDEX idx_sleep_cycles_session_id
ON sleep_cycles(session_id);

CREATE INDEX idx_sleep_stages_cycle_id
ON sleep_stages(cycle_id);
```

These indexes improve performance when retrieving:

* Sessions per user
* Cycles per session
* Stages per cycle

---

# Example Analytical Questions

This database enables queries such as:

* What is the **average REM percentage per week**?
* Which nights had **poor deep sleep**?
* How many **sleep cycles occur per night**?
* Is there a **relationship between bedtime and sleep quality**?

---

# Limitations

This database intentionally focuses only on sleep structure.

Not included:

* Lifestyle factors (caffeine, alcohol, exercise)
* Medical diagnoses
* Environmental factors (noise, light, temperature)
* Biometric sensor readings (heart rate, oxygen)

The sleep score model is also **simplified for demonstration purposes**.

---

# Technologies Used

* **SQL**
* **Relational Database Design**
* **Entity Relationship Modeling**
* **GitHub for version control**

---

# Author

**Arijit Poddar**

Student and Data Enthusiast focused on:

* SQL
* Data Analysis
* Database Design
* Analytics Engineering

---

# Video Overview

Project walkthrough:

[https://youtu.be/UEwDco54R_I](https://youtu.be/UEwDco54R_I)
