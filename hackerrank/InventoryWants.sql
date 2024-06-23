/*
Hacker Rank Solution (MSSQL)
By Michael Remollino (mike dot remo @ g mail dot com)
https://www.hackerrank.com/challenges/harry-potter-and-wands/
*/

WITH cte AS (
    SELECT id, age, coins_needed, power
                , RANK() OVER (PARTITION BY age, power  ORDER BY coins_needed ASC) as min_coins
    FROM Wands w
    LEFT JOIN Wands_Property p
    ON w.code = p.code
    WHERE is_evil = 0
)
SELECT id, age, coins_needed, power
FROM cte
WHERE min_coins = 1
ORDER BY power DESC, age DESC;