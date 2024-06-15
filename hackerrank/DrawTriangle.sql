/*
Hacker Rank Solution (MSSQL)
By Michael Remollino (mike dot remo @ g mail dot com)
https://www.hackerrank.com/challenges/draw-the-triangle-1/
https://www.hackerrank.com/challenges/draw-the-triangle-2/
*/

--Using procedural code
DECLARE @p INT;
SET @p = 20;
WHILE @p > 0
BEGIN
   PRINT REPLICATE('*  ', @p)
   SET @p = @p - 1;
END;

DECLARE @p INT;
SET @p = 1;
WHILE @p < 21
BEGIN
   PRINT REPLICATE('*  ', @p)
   SET @p = @p + 1;
END;

--Using set based code
WITH rcte AS (
    SELECT CAST(REPLICATE('* ', 1) AS VARCHAR(50)) AS x, 1 AS p
    UNION ALL
    SELECT CAST(REPLICATE('* ', p+1) AS VARCHAR(50)), p+1
    FROM rcte
    WHERE p < 20
)
SELECT x FROM rcte
ORDER BY p ASC;
--ORDER BY p DESC;