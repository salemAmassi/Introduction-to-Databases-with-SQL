# Mysql built-in functions
 
## 🧵 1. String Functions

Used for manipulating or analyzing text data.

| Function                               | Description               | Example                                           | Notes                              |
| -------------------------------------- | ------------------------- | ------------------------------------------------- | ---------------------------------- |
| `CONCAT()`                             | Joins two or more strings | `CONCAT('A', 'B') → 'AB'`                         | NULL if any argument is NULL       |
| `CONCAT_WS()`                          | Joins with a separator    | `CONCAT_WS('-', '2025','05','29') → '2025-05-29'` | Skips NULL values                  |
| `SUBSTRING()` / `SUBSTR()`             | Extract substring         | `SUBSTRING('Hello', 2, 3) → 'ell'`                | Indexing starts at 1               |
| `LEFT(str, len)`                       | Leftmost characters       | `LEFT('Hello', 2) → 'He'`                         | Returns NULL if length < 0         |
| `RIGHT(str, len)`                      | Rightmost characters      | `RIGHT('Hello', 2) → 'lo'`                        | –                                  |
| `LENGTH()`                             | Bytes length              | `LENGTH('ABC') → 3`                               | Use `CHAR_LENGTH()` for characters |
| `CHAR_LENGTH()` / `CHARACTER_LENGTH()` | Character count           | `CHAR_LENGTH('你好') → 2`                           | Works with multibyte strings       |
| `TRIM()`                               | Removes spaces (or chars) | `TRIM('  abc  ') → 'abc'`                         | Use `LEADING`, `TRAILING`, `BOTH`  |
| `LOWER()` / `LCASE()`                  | Convert to lowercase      | `LOWER('ABC') → 'abc'`                            | –                                  |
| `UPPER()` / `UCASE()`                  | Convert to uppercase      | `UPPER('abc') → 'ABC'`                            | –                                  |
| `REPLACE()`                            | Replace substring         | `REPLACE('abc', 'b', 'x') → 'axc'`                | Case-sensitive                     |
| `REVERSE()`                            | Reverse the string        | `REVERSE('abc') → 'cba'`                          | –                                  |
| `INSTR()`                              | Position of substring     | `INSTR('abcabc', 'b') → 2`                        | Returns 0 if not found             |
| `LOCATE(substr, str[, start])`         | Position of substring     | `LOCATE('b','abcabc') → 2`                        | 1-based index                      |
| `POSITION(substr IN str)`              | Same as `LOCATE()`        | –                                                 | SQL standard syntax                |
| `REPEAT(str, n)`                       | Repeats string            | `REPEAT('x', 3) → 'xxx'`                          | –                                  |
| `SPACE(n)`                             | n spaces                  | `SPACE(3) → '   '`                                | –                                  |
| `LPAD(str, len, pad)`                  | Pad left                  | `LPAD('A', 3, 'x') → 'xxA'`                       | –                                  |
| `RPAD(str, len, pad)`                  | Pad right                 | `RPAD('A', 3, 'x') → 'Axx'`                       | –                                  |
| `ASCII(str)`                           | ASCII code of 1st char    | `ASCII('A') → 65`                                 | NULL if empty string               |
| `CHAR(n, ...)`                         | Convert codes to chars    | `CHAR(65) → 'A'`                                  | Reverse of `ASCII()`               |
| `FIELD(val, val1, val2, ...)`          | Index of val              | `FIELD('B', 'A','B','C') → 2`                     | Returns 0 if not found             |
| `FIND_IN_SET(str, str_list)`           | Position in comma list    | `FIND_IN_SET('b', 'a,b,c') → 2`                   | Returns 0 if not found             |

---

## 📅 2. Date and Time Functions

Work with date, time, and datetime data.

### 🔧 Extraction and Formatting

| Function                     | Description        | Example                                         | Notes                                 |
| ---------------------------- | ------------------ | ----------------------------------------------- | ------------------------------------- |
| `NOW()`                      | Current datetime   | `NOW() → '2025-05-29 12:00:00'`                 | With fractional seconds if configured |
| `CURDATE()`                  | Current date       | `CURDATE() → '2025-05-29'`                      | Date only                             |
| `CURTIME()`                  | Current time       | `CURTIME() → '12:00:00'`                        | Time only                             |
| `YEAR()`, `MONTH()`, `DAY()` | Extract parts      | `YEAR(NOW()) → 2025`                            | Same for `HOUR()`, `MINUTE()` etc.    |
| `DATE_FORMAT(date, format)`  | Custom format      | `DATE_FORMAT(NOW(), '%d-%m-%Y') → '29-05-2025'` | Like `strftime` in C                  |
| `TIME_FORMAT()`              | Custom time format | –                                               | Time formatting only                  |

#### Date format

| DAY                     |    MONTH     | YEAR&Time                                         |
| -------------------------------------------------------- | -------------------------------------------------------- | ------------------------ |
| %a => The short weekday name, such as Sun, Mon| %b => The short month name,such as Jan, Feb| %y => Short Numeric year (25)|
| %d => The numeric da of the month (00..31)| %M =>  The full month name January. .December| %Y => Full Numeric year (2025)|
| %j => The day of year (001..366)|%m => The numeric month (0.01-02.12)| %H => Hour in 24 format|
| %W => The full weekday name (Sunday.. Saturday) | %c => The numeric month (0-1-2-12)| %h => Hour in 12 format|
| %w => The numeric day of the week (0=Sunday..6=Saturday)||%i => Minutes within the hour|

### 📐 Calculations and Intervals

| Function                         | Description       | Example                                         | Notes                  |
| -------------------------------- | ----------------- | ----------------------------------------------- | ---------------------- |
| `DATEDIFF(d1, d2)`               | Days between      | `DATEDIFF('2025-06-01','2025-05-29') → 3`       | d1 - d2                |
| `TIMEDIFF(t1, t2)`               | Time between      | `TIMEDIFF('12:30:00', '12:00:00') → '00:30:00'` | Works for DATETIME too |
| `ADDDATE(date, INTERVAL n unit)` | Add time          | `ADDDATE('2025-05-29', INTERVAL 7 DAY)`         | Same as `DATE_ADD()`   |
| `SUBDATE()`                      | Subtract time     | –                                               | Same as `DATE_SUB()`   |
| `LAST_DAY(date)`                 | Last day of month | `LAST_DAY('2025-05-10') → '2025-05-31'`         | Useful for reports     |
| `DAYOFWEEK()`, `DAYOFYEAR()`     | Day position      | `DAYOFWEEK('2025-05-29') → 5 (Thursday)`        | 1 = Sunday             |

---

## 🔢 3. Numeric Functions

For math operations, rounding, and random values.

| Function                 | Description            | Example                     | Notes                        |
| ------------------------ | ---------------------- | --------------------------- | ---------------------------- |
| `ABS(n)`                 | Absolute value         | `ABS(-5) → 5`               | –                            |
| `CEIL(n)` / `CEILING(n)` | Round up               | `CEIL(4.2) → 5`             | –                            |
| `FLOOR(n)`               | Round down             | `FLOOR(4.9) → 4`            | –                            |
| `ROUND(n, d)`            | Round to d decimals    | `ROUND(4.567, 2) → 4.57`    | No `d` → round to integer    |
| `TRUNCATE(n, d)`         | Truncate to d decimals | `TRUNCATE(4.567, 2) → 4.56` | No rounding                  |
| `MOD(a, b)` / `%`        | Modulus                | `MOD(10, 3) → 1`            | Remainder of division        |
| `POWER(x, y)`            | Exponentiation         | `POWER(2, 3) → 8`           | –                            |
| `SQRT(n)`                | Square root            | `SQRT(16) → 4`              | Returns NULL if n < 0        |
| `RAND([seed])`           | Random float \[0,1)    | `RAND() → 0.12345`          | Use seed for reproducibility |
| `SIGN(n)`                | Sign of number         | `SIGN(-8) → -1`             | 0 if zero                    |
| `PI()`                   | Pi constant            | `PI() → 3.14159...`         | –                            |
| `LOG(x)`                 | Natural log            | `LOG(1) → 0`                | Use `LOG10()` for base-10    |
| `EXP(x)`                 | e^x                    | `EXP(1) → 2.718...`         | –                            |

---

## ✅ 4. Boolean Functions (Logic & Conditionals)

Used in expressions for filtering or assigning values.

| Function                             | Description          | Example                               | Notes                               |
| ------------------------------------ | -------------------- | ------------------------------------- | ----------------------------------- |
| `IF(condition, true_val, false_val)` | Conditional logic    | `IF(score > 50, 'Pass', 'Fail')`      | Like `if-else`                      |
| `IFNULL(expr1, expr2)`               | If NULL, use other   | `IFNULL(NULL, 'default') → 'default'` | Same as COALESCE() for 2 values     |
| `NULLIF(expr1, expr2)`               | Return NULL if equal | `NULLIF(5, 5) → NULL`                 | Useful in avoiding division by zero |
| `ISNULL(expr)`                       | Is value NULL?       | `ISNULL(NULL) → 1`                    | Returns 1 or 0                      |
| `COALESCE(val1, val2, ...)`          | First non-null       | `COALESCE(NULL, NULL, 'A') → 'A'`     | More flexible than `IFNULL()`       |

---

## 🧪 Tips for Use

* Combine string and conditional functions for dynamic labels:

  ```sql
  SELECT name, IF(gpa > 3.5, 'Honors', 'Regular') AS status FROM students;
  ```

* Format numbers as currency:

  ```sql
  SELECT CONCAT('$', FORMAT(price, 2)) FROM products;
  ```

* Calculate date differences:

  ```sql
  SELECT DATEDIFF(CURDATE(), birthdate) / 365 AS age FROM users;
  ```

## 📅 2. Date and Time Functions

Work with date, time, and datetime data.

### 🔧 Extraction and Formatting

| Function                     | Description        | Example                                         | Notes                                 |
| ---------------------------- | ------------------ | ----------------------------------------------- | ------------------------------------- |
| `NOW()`                      | Current datetime   | `NOW() → '2025-05-29 12:00:00'`                 | With fractional seconds if configured |
| `CURDATE()`                  | Current date       | `CURDATE() → '2025-05-29'`                      | Date only                             |
| `CURTIME()`                  | Current time       | `CURTIME() → '12:00:00'`                        | Time only                             |
| `YEAR()`, `MONTH()`, `DAY()` | Extract parts      | `YEAR(NOW()) → 2025`                            | Same for `HOUR()`, `MINUTE()` etc.    |
| `DATE_FORMAT(date, format)`  | Custom format      | `DATE_FORMAT(NOW(), '%d-%m-%Y') → '29-05-2025'` | Like `strftime` in C                  |
| `TIME_FORMAT()`              | Custom time format | –                                               | Time formatting only                  |

### 📐 Calculations and Intervals

| Function                         | Description       | Example                                         | Notes                  |
| -------------------------------- | ----------------- | ----------------------------------------------- | ---------------------- |
| `DATEDIFF(d1, d2)`               | Days between      | `DATEDIFF('2025-06-01','2025-05-29') → 3`       | d1 - d2                |
| `TIMEDIFF(t1, t2)`               | Time between      | `TIMEDIFF('12:30:00', '12:00:00') → '00:30:00'` | Works for DATETIME too |
| `ADDDATE(date, INTERVAL n unit)` | Add time          | `ADDDATE('2025-05-29', INTERVAL 7 DAY)`         | Same as `DATE_ADD()`   |
| `SUBDATE()`                      | Subtract time     | –                                               | Same as `DATE_SUB()`   |
| `LAST_DAY(date)`                 | Last day of month | `LAST_DAY('2025-05-10') → '2025-05-31'`         | Useful for reports     |
| `DAYOFWEEK()`, `DAYOFYEAR()`     | Day position      | `DAYOFWEEK('2025-05-29') → 5 (Thursday)`        | 1 = Sunday             |

---

## 🔢 3. Numeric Functions

For math operations, rounding, and random values.

| Function                 | Description            | Example                     | Notes                        |
| ------------------------ | ---------------------- | --------------------------- | ---------------------------- |
| `ABS(n)`                 | Absolute value         | `ABS(-5) → 5`               | –                            |
| `CEIL(n)` / `CEILING(n)` | Round up               | `CEIL(4.2) → 5`             | –                            |
| `FLOOR(n)`               | Round down             | `FLOOR(4.9) → 4`            | –                            |
| `ROUND(n, d)`            | Round to d decimals    | `ROUND(4.567, 2) → 4.57`    | No `d` → round to integer    |
| `TRUNCATE(n, d)`         | Truncate to d decimals | `TRUNCATE(4.567, 2) → 4.56` | No rounding                  |
| `MOD(a, b)` / `%`        | Modulus                | `MOD(10, 3) → 1`            | Remainder of division        |
| `POWER(x, y)`            | Exponentiation         | `POWER(2, 3) → 8`           | –                            |
| `SQRT(n)`                | Square root            | `SQRT(16) → 4`              | Returns NULL if n < 0        |
| `RAND([seed])`           | Random float \[0,1)    | `RAND() → 0.12345`          | Use seed for reproducibility |
| `SIGN(n)`                | Sign of number         | `SIGN(-8) → -1`             | 0 if zero                    |
| `PI()`                   | Pi constant            | `PI() → 3.14159...`         | –                            |
| `LOG(x)`                 | Natural log            | `LOG(1) → 0`                | Use `LOG10()` for base-10    |
| `EXP(x)`                 | e^x                    | `EXP(1) → 2.718...`         | –                            |

---

## ✅ 4. Boolean Functions (Logic & Conditionals)

Used in expressions for filtering or assigning values.

| Function                             | Description          | Example                               | Notes                               |
| ------------------------------------ | -------------------- | ------------------------------------- | ----------------------------------- |
| `IF(condition, true_val, false_val)` | Conditional logic    | `IF(score > 50, 'Pass', 'Fail')`      | Like `if-else`                      |
| `IFNULL(expr1, expr2)`               | If NULL, use other   | `IFNULL(NULL, 'default') → 'default'` | Same as COALESCE() for 2 values     |
| `NULLIF(expr1, expr2)`               | Return NULL if equal | `NULLIF(5, 5) → NULL`                 | Useful in avoiding division by zero |
| `ISNULL(expr)`                       | Is value NULL?       | `ISNULL(NULL) → 1`                    | Returns 1 or 0                      |
| `COALESCE(val1, val2, ...)`          | First non-null       | `COALESCE(NULL, NULL, 'A') → 'A'`     | More flexible than `IFNULL()`       |

---

## 🧪 Tips for Use

* Combine string and conditional functions for dynamic labels:

  ```sql
  SELECT name, IF(gpa > 3.5, 'Honors', 'Regular') AS status FROM students;
  ```

* Format numbers as currency:

  ```sql
  SELECT CONCAT('$', FORMAT(price, 2)) FROM products;
  ```

* Calculate date differences:

  ```sql
  SELECT DATEDIFF(CURDATE(), birthdate) / 365 AS age FROM users;
  ```

