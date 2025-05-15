
-- 1. Creating DB Objects
DROP DATABASE IF EXISTS llm_tracking_db;
CREATE DATABASE IF NOT EXISTS llm_tracking_db;
USE llm_tracking_db;

-- 1.1 Create llm_output (v1): without any constraint
CREATE TABLE IF NOT EXISTS llm_output_v1 (
    lo_id INT ,
    lo_prompt TEXT  ,
    lo_text TEXT ,
    lo_date_created TIMESTAMP ,
    lo_is_reviewed TINYINT(1),
    lo_model_name VARCHAR(50) ,
    lo_user_email VARCHAR(100) ,
    lo_rating TINYINT
);

-- 1.2 Create llm_output (v2): adding constraints:

CREATE TABLE IF NOT EXISTS llm_output_v2 (
    lo_id INT PRIMARY KEY AUTO_INCREMENT, -- primary key + Auto increase the ID
    lo_prompt VARCHAR(200)  NOT NULL, -- no blank values
    lo_text TEXT NOT NULL, -- no blank values
    lo_date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- set default value the current timestamp
    lo_is_reviewed TINYINT(1) DEFAULT 0 CHECK (lo_is_reviewed IN (0, 1)), -- set default value: 0, check if value either 0 and 1
    lo_model_name VARCHAR(50) DEFAULT 'gpt-3.5', -- Set default value : gpt-3.5
    lo_user_email VARCHAR(100) UNIQUE, -- Ensure no Duplicates
    lo_rating TINYINT(2) CHECK (lo_rating BETWEEN 1 AND 5), -- check if lo_rating is between 1-5
    lo_prompt_category VARCHAR(50)
);

-- 2. Delete Structures

-- 2.1 Delete the whole object
DROP TABLE IF EXISTS llm_output_v1;

-- Delete Whole Table and Recreate it
TRUNCATE TABLE llm_output_v2;


-- 3. Modify Existing Structures
-- 3.1 Change Table Name

ALTER TABLE llm_output_v2 RENAME TO llm_output_constrained;
RENAME TABLE llm_output_constrained TO llm_output_v2;


-- 3.2 Change Column Structure :
-- 3.2.1 Rename the column:

-- First: using CHANGE: re-define the whole column
ALTER TABLE llm_output_v2 CHANGE lo_model_name lo_model VARCHAR(50) DEFAULT 'gpt-3.5';

-- Second: using RENAME:
-- NOT Supported on Mariadb 10.4 because its based on MySQL 5.7 not 8.0
-- ALTER TABLE llm_output_v2 RENAME COLUMN lo_model TO lo_model_name;

-- 3.2.2 Change the column datatype:
ALTER TABLE llm_output_v2 CHANGE lo_date_created lo_date_created DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE llm_output_v2 CHANGE lo_id lo_id INT UNSIGNED;
ALTER TABLE llm_output_v2 MODIFY lo_rating TINYINT(1);


-- Change column name and datatype at once:

ALTER TABLE llm_output_v2 CHANGE lo_model lo_model_name VARCHAR(100);
ALTER TABLE llm_output_v2 CHANGE lo_is_reviewed  lo_is_rated TINYINT DEFAULT 0 CHECK (lo_is_rated IN (0, 1));


-- 3.3 Add new Column
ALTER TABLE llm_output_v2 ADD COLUMN accuracy TINYINT(3) NOT NULL DEFAULT 0;
-- 3.4 Delete Column
ALTER TABLE llm_output_v2 DROP COLUMN accuracy;



-- 4 ADD CONSTRAINT to column:
ALTER TABLE llm_output_v2 CHANGE lo_model_name lo_model_name VARCHAR(100) NOT NULL;
-- Add constraint without name:
ALTER TABLE llm_output_v2 MODIFY lo_model_name  VARCHAR(100) CHECK(lo_model_name IN ('gpt-3.5', 'gpt-4o', 'gpt-4o-mini' ));
-- Add constraint with name:
ALTER TABLE llm_output_v2 ADD CONSTRAINT chk_rating_range CHECK (lo_rating BETWEEN 1 AND 5);
ALTER TABLE llm_output_v2 ADD CONSTRAINT unique_value UNIQUE(lo_user_email);

-- Drop Constraint with name:
ALTER TABLE llm_output_v2 DROP CONSTRAINT unique_value; 


-- Modify Constraint by name:
-- No direct way to do it, but you can drop the old constraint and ADD the new version of it
ALTER TABLE llm_output_v2 DROP CONSTRAINT chk_rating_range;
ALTER TABLE llm_output_v2 ADD CONSTRAINT chk_rating_range CHECK( lo_rating IN (1,2,3,4,5));



