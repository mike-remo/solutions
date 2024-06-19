/*
Hacker Rank Solution (MSSQL)
By Michael Remollino (mike dot remo @ g mail dot com)
https://www.hackerrank.com/challenges/the-report/
*/

-- Alternate joinless query
WITH cte AS (
SELECT CASE WHEN Marks > 70 THEN Name ELSE NULL END AS Names
            , CASE WHEN Marks = 100 THEN 10 ELSE CEILING(Marks/10)+1 END AS Grade
            , Marks
FROM Students
)
SELECT * FROM cte
ORDER BY Grade DESC, Names ASC;

-- Standard query using join
SELECT CASE WHEN Marks > 70 THEN Name ELSE NULL END AS Names
            , Grade
            , Marks
FROM Students s
LEFT JOIN Grades g ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY Grade DESC, Names ASC;