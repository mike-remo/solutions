/*
Hacker Rank Solution (MSSQL)
By Michael Remollino (mike dot remo at g mail dot com)
https://www.hackerrank.com/challenges/symmetric-pairs/
*/

WITH cte AS (
SELECT x, y
    , ROW_NUMBER() OVER (ORDER BY x ASC) AS rn
FROM Functions
)
SELECT DISTINCT a.x, a.y
FROM cte a
INNER JOIN cte b
ON a.x = b.y
AND b.x = a.y
AND a.rn != b.rn
AND a.rn <= b.rn;