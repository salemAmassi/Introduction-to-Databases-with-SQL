# ORDER BY

## 📘 What is `ORDER BY`?

The `ORDER BY` clause in SQL is used to **sort the result set** of a query based on one or more columns. It is typically the **last clause** in a SELECT statement.

---

## Syntax

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition
ORDER BY column1 [ASC | DESC], column2 [ASC | DESC], ...;
```

* `ASC`: Ascending order (default)
* `DESC`: Descending order

---

## Execution Order in SQL Queries

### Logical Execution Order:

1. `FROM`
2. `WHERE`
3. `GROUP BY`
4. `HAVING`
5. `SELECT`
6. `ORDER BY` ← Sorting is done **after** data is selected

---

## Basic Example

```sql
SELECT lo_prompt_category, lo_rating
FROM llm_output_v2
ORDER BY lo_rating;
```

## Using DESC (Descending)

```sql
SELECT lo_prompt_category, lo_rating
FROM llm_output_v2
ORDER BY lo_rating DESC;
```

---

## Sorting by Multiple Columns

```sql
SELECT lo_prompt_category, DATE_FORMAT(lo_date_created, '%Y-%m-%d')
FROM llm_output_v2
ORDER BY lo_prompt_category , lo_date_created;
```

1. First, groups by `lo_prompt_category` alphabetically.
2. Then, sorts each category's rating DESC.

This is called **lexicographical sorting** — like sorting by first name, then by last name.

---

## Using Aliases or Expressions

You can sort by **column aliases** or **calculated values**.

```sql
SELECT lo_prompt_category, AVG(lo_rating) AS rating -- 3
FROM llm_output_v2 -- 1
GROUP BY lo_prompt_category -- 2
ORDER BY rating DESC, lo_prompt_category; -- 4
```

Or even by column number (not recommended):

```sql
SELECT lo_prompt_category, AVG(lo_rating) AS rating
FROM llm_output_v2
GROUP BY lo_prompt_category
ORDER BY 2 DESC, 1;
```

> ⚠️ Note: Avoid using column numbers in production code — it's less readable and error-prone.

---

## ORDER BY and NULLs

By default:

* In **MySQL**, `NULL`s are treated as **lower than any value** in **ascending** order.

```sql
SELECT name, age
FROM employees
ORDER BY age ASC;  -- NULLs come first
```

To control this behavior (MySQL 8.0+):

```sql
ORDER BY age ASC NULLS LAST;
ORDER BY age DESC NULLS FIRST;
```

> Supported only in **MySQL 8.0+**

---

```sql
SELECT lo_prompt_category, COALESCE(lo_rating,'Unreviewed') AS rating
FROM llm_output_v2
ORDER BY lo_prompt_category , rating;
```

## ORDER BY with LIMIT

Useful for **pagination** or getting **top N records**.

```sql
SELECT lo_model_name, lo_rating, lo_id
FROM llm_output_v2
ORDER BY lo_rating DESC
LIMIT 10;
```

---

## ORDER BY and Indexing (Performance)

* `ORDER BY` **can use indexes** to improve performance **only if**:

  * The sorting columns are covered by an index.
  * The query can use the index **without needing to scan the full table**.

> Using `ORDER BY` with `LIMIT` is a common performance optimization (called "index skip scan").

---

## Tips & Best Practices

| Tip                                                         | Why                  |
| ----------------------------------------------------------- | -------------------- |
| Always specify `ASC` or `DESC` for clarity                  | Avoid ambiguity      |
| Use indexed columns when sorting large result sets          | Improves performance |
| Sort by **expression alias** if you're computing values     | Cleaner queries      |
| Use `COLLATE` for case-sensitive or locale-specific sorting | More control         |

---
