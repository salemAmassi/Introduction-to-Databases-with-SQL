
-- 1. Creating DB Objects
DROP DATABASE IF EXISTS llm_tracking_db;
CREATE DATABASE IF NOT EXISTS llm_tracking_db;
USE llm_tracking_db;

-- 1.1 Create llm_output (v1): without any constraint
CREATE TABLE IF NOT EXISTS llm_output_v1 (
    lo_id INT ,
    lo_text VARCHAR(200) ,
    lo_prompt VARCHAR(200)  ,
    lo_date_created TIMESTAMP ,
    lo_is_reviewed TINYINT(1),
    lo_model_name VARCHAR(50) ,
    lo_user_email VARCHAR(100) ,
    lo_rating TINYINT
);

-- 1.2 Create llm_output (v2): adding constraints:

CREATE TABLE IF NOT EXISTS llm_output_v2 (
    lo_id INT PRIMARY KEY AUTO_INCREMENT, -- primary key + Auto increase the ID
    lo_prompt TEXT NOT NULL, -- no blank values
    lo_text TEXT NOT NULL, -- no blank values
    lo_date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- set default value the current timestamp
    lo_is_reviewed TINYINT(1) DEFAULT 0 CHECK (lo_is_reviewed IN (0, 1)), -- set default value: 0, check if value either 0 and 1
    lo_model_name VARCHAR(50) DEFAULT 'gpt-3.5', -- Set default value : gpt-3.5
    lo_user_email VARCHAR(100) UNIQUE, -- Ensure no Duplicates
    lo_rating(2) TINYINT CHECK (lo_rating BETWEEN 1 AND 5), -- check if lo_rating is between 1-5
);

-- 2. Delete Structures

-- 2.1 Delete the whole object
DROP TABLE IF EXISTS llm_output_v1;

-- Delete Whole Table and Recreate it
TRUNCATE TABLE llm_output_v2;

-- TODO: 

-- 3. Modify Existing Structures
-- 3.1 Change Table Name
-- 3.2 Change Column Structure (Name, data type, constraint)
-- 3.3 Delete Column
-- 3.4 Add new Column

-- 4. Define Constraints using ALTER


