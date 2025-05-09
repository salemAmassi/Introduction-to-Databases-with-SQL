-- 1. Insert new Data into table
-- Syntax: INSERT INTO <table_name> (c1, c2, c3, ..., cn) VALUES (v1, v2, v3, ..., vn)
-- CASE 1:  Insert all values (without Id)
INSERT INTO
    llm_output_v2 (
        lo_prompt,
        lo_text,
        lo_date_created,
        lo_is_reviewed,
        lo_model_name,
        lo_user_email,
        lo_rating
    )
VALUES
    (
        'What is relational algebra?',
        'Relational algebra is a procedural query language...',
        '2025-05-01 10:00:00',
        1,
        'gpt-4',
        'alice@example.com',
        2
    );
-- CASE 2: Insert the id explicitly
INSERT INTO llm_output_v2 (
    lo_id, lo_prompt, lo_text, lo_user_email, lo_rating
) VALUES (
    100, 'What is DML?', 'DML is used to manipulate data...', 'test@example.com', 4
);

-- CASE 3: Insert Using Defaults
INSERT INTO
    llm_output_v2 (
        lo_prompt,
        lo_text,
        lo_user_email,
        lo_rating
    )
VALUES
    (
        'Explain the concept of normalization.',
        'Normalization is the process of structuring relational data...',
        'bob@example.com',
        4
    );

-- CASE 4: Insert Violating NOT NULL
INSERT INTO
    llm_output_v2 (lo_prompt, lo_text, lo_user_email)
VALUES
    (
        NULL,
        'Response with missing prompt.',
        'carol@example.com'
    );

-- CASE 4: Insert Violating UNIQUE Constraint
-- First one succeeds
INSERT INTO
    llm_output_v2 (
        lo_prompt,
        lo_text,
        lo_user_email,
        lo_rating
    )
VALUES
    (
        'What is a primary key?',
        'A primary key uniquely identifies each record.',
        'sami@example.com',
        3
    );

-- Second one fails: same email
INSERT INTO
    llm_output_v2 (
        lo_prompt,
        lo_text,
        lo_user_email,
        lo_rating
    )
VALUES
    (
        'What is a primary key?',
        'A primary key uniquely identifies each record.',
        'david@example.com',
        5
    );
-- #1062 - Duplicate entry 'A primary key uniquely identifies each record.-What is a prim...' for key 'unique_output'



-- CASE 6: Insert Violating CHECK Constraint
INSERT INTO
    llm_output_v2 (
        lo_prompt,
        lo_text,
        lo_user_email,
        lo_rating
    )
VALUES
    (
        'Give a fun fact about SQL.',
        'The SQL language was standardized in 1986!',
        'eve@example.com',
        7
    );
-- #4025 - CONSTRAINT `llm_output_v2.lo_rating` failed for `llm_tracking_db`.`llm_output_v2`


-- CASE 7: Omitting Optional Fields Safely
--  TODO 
-- CASE 8: Insert all columns values
INSERT INTO llm_output_v2
VALUES (
    100,
    'what is prompt?',
    'prompt is user input for the LLM',
    '2025-05-09 14:05:00',
    1,
    'o1',
    'john@gmail.com',
    2
)

