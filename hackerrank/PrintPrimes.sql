/*
Hacker Rank Solution (MSSQL)
By Michael Remollino (mike dot remo @ g mail dot com)
https://www.hackerrank.com/challenges/print-prime-numbers/
*/

WITH cte AS (
    SELECT 2 AS n
    UNION
    SELECT * FROM GENERATE_SERIES(3, 1000, 2) odds
), cte_primes AS (
    SELECT n
    FROM cte
    WHERE NOT EXISTS (
        SELECT 1 FROM cte excl
        WHERE cte.n > excl.n AND cte.n % excl.n = 0 )
)
SELECT STRING_AGG(n, '&')
FROM cte_primes