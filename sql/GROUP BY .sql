-- 1. Use group by without aggregation
-- TO ANSWER: what email it will retrieve for each model?
--- Mysql by default allows it, if you wanna disallow, you can use: SET sql_mode = 'ONLY_FULL_GROUP_BY';
-- It will retrieve the first value it finds for each group.
SELECT
    lo_model_name,
    lo_user_email
FROM
    llm_output_v2
GROUP BY
    lo_model_name, lo_user_email;

--------------------------------------------
-- 2. GROUP BY with aggregation:
SELECT
    lo_model_name,
    GROUP_CONCAT(DISTINCT lo_prompt_category) categories
FROM
    llm_output_v2
GROUP BY
    lo_model_name;

-- 2.1. Single-Column Grouping
SELECT
    lo_model_name,
    COUNT(DISTINCT lo_user_email) AS unique_users_per_model
FROM
    llm_output_v2
GROUP BY
    lo_model_name;

--------------------------------------------
SELECT
    lo_model_name AS MODEL,
    COUNT(DISTINCT lo_id) AS total_responses_per_model,
    AVG(lo_rating) AS avg_rating_per_model,
    SUM(lo_is_reviewed) AS total_reviewed_responses,
    COUNT(lo_is_reviewed) - SUM(lo_is_reviewed) AS total_unreviewed_responses,
    MAX(lo_date_created) AS most_recent_date,
    MIN(lo_date_created) AS oldest_date
FROM
    llm_output_v2
GROUP BY
    lo_model_name;

--------------------------------------------
SELECT
    lo_model_name AS MODEL,
    COUNT(DISTINCT lo_id) AS total_responses_per_category,
    AVG(lo_rating) AS avg_rating_per_category,
    SUM(lo_is_reviewed) AS total_reviewed_responses,
    COUNT(lo_is_reviewed) - SUM(lo_is_reviewed) AS total_unreviewed_responses,
    MAX(lo_date_created) AS most_recent_date,
    MIN(lo_date_created) AS oldest_date
FROM
    llm_output_v2
GROUP BY
    lo_prompt_category;

-- 2.2. Multicolumn Grouping
SELECT
    lo_model_name AS MODEL,
    lo_prompt_category AS CATEGORY,
    AVG(lo_rating) AS 'Average Rating',
    SUM(lo_is_reviewed) AS 'Total reviewes'
FROM llm_output_v2
GROUP BY lo_model_name, lo_prompt_category;

--------------------------------------------

SELECT
    lo_model_name AS MODEL,
    lo_prompt_category AS CATEGORY,
    AVG(lo_rating) AS 'Average Rating',
    SUM(lo_is_reviewed) AS 'Total reviewes',
    GROUP_CONCAT(DISTINCT EXTRACT(YEAR FROM lo_date_created) ORDER BY lo_date_created DESC) AS 'Years'
FROM llm_output_v2
GROUP BY lo_model_name, lo_prompt_category;

--------------------------------------------

SELECT
    lo_user_email AS USER,
    lo_rating AS RATING,
    GROUP_CONCAT(DISTINCT lo_prompt_category ORDER BY lo_prompt_category) AS CATEGORIES
FROM llm_output_v2
GROUP BY lo_user_email, lo_rating;


-- 2.3.  Grouping via Expressions
SELECT
    EXTRACT(YEAR FROM lo_date_created) AS 'YEAR',
    EXTRACT(MONTH FROM lo_date_created) AS 'MONTH',
    COUNT(DISTINCT lo_user_email) AS unique_users
FROM llm_output_v2
GROUP BY EXTRACT(YEAR FROM lo_date_created),
         EXTRACT(MONTH FROM lo_date_created) ;




-- 2.4. Generating Rollups
SELECT
    EXTRACT(YEAR FROM lo_date_created) AS 'YEAR',
    EXTRACT(MONTH FROM lo_date_created) AS 'MONTH',
    COUNT(DISTINCT lo_user_email) AS unique_users
FROM llm_output_v2
GROUP BY EXTRACT(YEAR FROM lo_date_created),
         EXTRACT(MONTH FROM lo_date_created) WITH ROLLUP;

SELECT
    lo_user_email AS USER,
    lo_rating AS RATING,
    GROUP_CONCAT(DISTINCT lo_prompt_category ORDER BY lo_prompt_category) AS CATEGORIES
FROM llm_output_v2
GROUP BY lo_user_email, lo_rating WITH ROLLUP;


-- 3. Filtering groups
SELECT
    lo_prompt_category AS CATEGORY,
    COUNT(lo_id) AS total_responses,
    AVG(lo_rating) AS avg_rating,
    SUM(lo_is_reviewed) AS total_reviewed_responses,
    COUNT(lo_is_reviewed) - SUM(lo_is_reviewed) AS total_unreviewed_responses,
    MAX(lo_date_created) AS most_recent_date,
    MIN(lo_date_created) AS oldest_date
FROM
    llm_output_v2
WHERE EXTRACT(YEAR FROM lo_date_created) = '2025'
GROUP BY
    lo_prompt_category
HAVING
    AVG(lo_rating) >= 3;
SELECT AVG(lo_rating)
FROM llm_output_v2
WHERE lo_prompt_category = 'Education' AND EXTRACT(YEAR FROM lo_date_created) = '2025';



-- COUNTRY -> CITY -> BLOCK -> STREET -> HOUSE 

