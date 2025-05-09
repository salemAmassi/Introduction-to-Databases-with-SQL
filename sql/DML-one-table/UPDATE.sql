
-- 2. update exisiting row :
-- CASE 1: Basic Update
UPDATE llm_output_v2
SET lo_rating = 5
WHERE lo_id = 1;

-- CASE 2: UPDATE llm_output_v2
SET lo_rating = 4,
    lo_is_reviewed = 1
WHERE lo_model_name = 'gpt-4';


-- CASE 5: Missing WHERE Clause
UPDATE llm_output_v2
SET lo_rating = 1;

