-- Select examples for llm_output_v2

-- 1. Select everything
SELECT *
FROM llm_output_v2;


-- Execution: Full table scan (reads every row).
-- Notes: Avoid in production on wide tables—retrieves all columns whether you need them or not, increasing I/O and network traffic.

-- 2. Select specific columns
SELECT lo_prompt,
       lo_rating
FROM llm_output_v2;

-- 3. Filtering with WHERE (Reviewed outputs only)
SELECT lo_prompt,
       lo_user_email,
       lo_is_reviewed
FROM llm_output_v2
WHERE lo_is_reviewed = 1;


-- found problem: there are outputs that not reviewed but have rating
SELECT COUNT(*)
FROM llm_output_v2
WHERE lo_is_reviewed = 0 AND lo_rating <> 0;



-- AND, OR, NOT, BETWEEN , IN

-- 3.1 Return only high-rated, reviewed outputs:(AND)

SELECT lo_prompt,
       lo_rating,
       lo_is_reviewed
  FROM llm_output_v2
 WHERE lo_rating >= 4
   AND lo_is_reviewed = 1;

-- 3.2 Find outputs that either weren’t reviewed or scored poorly:(OR)

SELECT lo_prompt,
       lo_rating,
       lo_is_reviewed
  FROM llm_output_v2
 WHERE lo_is_reviewed = 0
    OR lo_rating < 2;

-- 3.3 Exclude all reviewed outputs:(NOT)

SELECT lo_prompt,
       lo_is_reviewed
  FROM llm_output_v2
 WHERE NOT lo_is_reviewed;


-- 3.4 Select outputs created in a given date window:(BETWEEN)

SELECT lo_prompt,
       lo_date_created
  FROM llm_output_v2
 WHERE lo_date_created
       BETWEEN '2025-04-01' AND '2025-04-30';

-- 3.4 Filter by multiple model names at once: (IN)
SELECT lo_prompt,
       lo_model_name
  FROM llm_output_v2
 WHERE lo_model_name
       IN ('gpt-3', 'gpt-4', 'llama-4');


-- 3.5 Finds unreviewed “gpt-4” or “llama-4” outputs rated 3–5 or any outputs created in the first ten days of May 2025. (Combine them all)
SELECT lo_prompt,
       lo_model_name,
       lo_rating,
       lo_date_created
  FROM llm_output_v2
 WHERE lo_model_name IN ('gpt-4','llama-4')
   AND lo_rating BETWEEN 3 AND 5
   AND NOT lo_is_reviewed
   OR lo_date_created BETWEEN '2025-05-01' AND '2025-05-10';


-- 5. Date filtering (Outputs created on or after April 20, 2025)



-- 6. Distinct values (List each model name only once)
SELECT DISTINCT lo_model_name
FROM llm_output_v2;



