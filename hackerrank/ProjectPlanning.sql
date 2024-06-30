/*
Hacker Rank Solution (MSSQL)
By Michael Remollino (mike dot remo at g mail dot com)
https://www.hackerrank.com/challenges/sql-projects/
*/

WITH cte AS (
    SELECT MIN(start_date) AS FirstDate
    FROM Projects
), cte2 AS (
    SELECT start_date, end_date
                , ROW_NUMBER() OVER (ORDER BY start_date) AS rowno
                , DATEDIFF(dd, (SELECT FirstDate FROM cte), end_date) AS diff
    FROM Projects
)
--SELECT start_date, end_date, diff, rowno, (diff - rowno) AS seqno
SELECT MIN(start_date), MAX(end_date)
FROM cte2
GROUP BY (diff - rowno)
ORDER BY DATEDIFF(dd, MIN(start_date), MAX(end_date)), MIN(start_date) ASC;