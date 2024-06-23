/*
Hacker Rank Solution (MSSQL)
By Michael Remollino (mike dot remo @ g mail dot com)
https://www.hackerrank.com/challenges/challenges/
*/

-- Ver #2
WITH cte1 AS (
    SELECT h.hacker_id, name, COUNT(challenge_id) AS ttl_ch
    FROM Challenges c
    INNER JOIN Hackers h ON h.hacker_id  = c.hacker_id
    GROUP BY h.hacker_id, name
), cte2 AS (
    SELECT ttl_ch
    FROM cte1
    GROUP BY ttl_ch
    HAVING COUNT(ttl_ch) = 1
)
SELECT *
FROM cte1
WHERE ttl_ch = (SELECT MAX(ttl_ch) FROM cte1)
OR ttl_ch IN (SELECT ttl_ch FROM cte2)
ORDER BY ttl_ch DESC, hacker_id ASC


-- Ver #1
WITH cte1 AS (
    SELECT h.hacker_id, name, COUNT(challenge_id) AS ttl_ch
    FROM Challenges c
    INNER JOIN Hackers h ON h.hacker_id  = c.hacker_id
    GROUP BY h.hacker_id, name
), cte2 AS (
    SELECT hacker_id, name, ttl_ch
    FROM cte1
    WHERE ttl_ch = (SELECT MAX(ttl_ch) FROM  cte1)
), cte3 AS (
    SELECT ttl_ch
    FROM cte1
    GROUP BY ttl_ch
    HAVING COUNT(ttl_ch) = 1
), cte4 AS (
    SELECT hacker_id, name, cte1.ttl_ch
    FROM cte1
    INNER JOIN cte3 ON cte3.ttl_ch = cte1.ttl_ch
)
SELECT * FROM cte2
UNION SELECT * FROM cte4
ORDER BY ttl_ch DESC, hacker_id ASC