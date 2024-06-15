/*
Hacker Rank Solution (MSSQL)
By Michael Remollino (mike dot remo @ g mail dot com)
https://www.hackerrank.com/challenges/15-days-of-learning-sql/
*/

-- Sample values for testing

-- INIT database
CREATE TABLE Submissions (
  submission_date DATE,
  submission_id INT,
  hacker_id INT,
  score INT
);

INSERT INTO Submissions(submission_date, submission_id, hacker_id, score) VALUES
('3/1/2016',8494,20703,0),
('3/1/2016',22403,53473,15),
('3/1/2016',23965,79722,60),
('3/1/2016',30173,36396,70),
('3/2/2016',34928,20703,0),
('3/2/2016',38740,15758,80),
('3/2/2016',42769,79722,25),
('3/2/2016',44364,79722,60),
('3/3/2016',45440,20703,0),
('3/3/2016',49050,36396,70),
('3/3/2016',50273,79722,5),
('3/4/2016',50344,20703,0),
('3/4/2016',51360,44065,90),
('3/4/2016',54404,53473,65),
('3/4/2016',61533,79722,45),
('3/5/2016',72852,20703,0),
('3/5/2016',74546,38289,0),
('3/5/2016',76487,62529,0),
('3/5/2016',82439,36396,10),
('3/5/2016',90006,36396,40),
('3/6/2016',90404,20703,0);

-- QUERY database

-- Step 1: Get user w/ most submissiosn per day, tie-breaker goes to lowest id
WITH cte1 AS (
SELECT submission_date 
     , DENSE_RANK() OVER (PARTITION BY submission_date ORDER BY COUNT(submission_id) DESC) AS rank1
     , DENSE_RANK() OVER (PARTITION BY submission_date ORDER BY hacker_id)AS rank2
     , hacker_id
FROM Submissions
GROUP BY submission_date, hacker_id
), cte2 AS (
SELECT submission_date
     , ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY rank1, rank2) AS rownum
     , hacker_id
FROM cte1
)
SELECT submission_date, hacker_id
FROM cte2
WHERE rownum = 1
ORDER BY submission_date ASC;

-- Step 2: Count consecutive login days for each user from start date
WITH cte1 AS (
  SELECT DISTINCT submission_date, hacker_id
  FROM Submissions
  WHERE submission_date BETWEEN '2016-03-01' AND '2016-03-15'
), cte2 AS (
  SELECT submission_date, hacker_id
  FROM cte1
  WHERE cte1.submission_date = '2016-03-01'
  UNION ALL
  SELECT cte1.submission_date, cte1.hacker_id
  FROM cte1
  INNER JOIN cte2 ON cte2.submission_date = DATEADD(dd, -1, cte1.submission_date)
  AND cte1.hacker_id = cte2.hacker_id
)
SELECT submission_date, COUNT(DISTINCT hacker_id) as unqH
-- ,STRING_AGG(hacker_id, ',') AS unqH
FROM cte2
GROUP BY submission_date;

-- Final Combined Query
WITH cte1 AS (
SELECT submission_date 
     , DENSE_RANK() OVER (PARTITION BY submission_date ORDER BY COUNT(submission_id) DESC) AS rank1
     , DENSE_RANK() OVER (PARTITION BY submission_date ORDER BY hacker_id)AS rank2
     , hacker_id
FROM Submissions
GROUP BY submission_date, hacker_id
), cte2 AS (
SELECT submission_date
     , ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY rank1, rank2) AS rownum
     , hacker_id
FROM cte1
), cteR AS (
  SELECT submission_date, hacker_id
  FROM Submissions sub
  WHERE sub.submission_date = '2016-03-01'
  UNION ALL
  SELECT sub.submission_date, sub.hacker_id
  FROM Submissions sub
  INNER JOIN cteR ON cteR.submission_date = DATEADD(dd, -1, sub.submission_date)
  AND sub.hacker_id = cteR.hacker_id
  WHERE sub.submission_date < '2016-03-16'
), cte4 AS (
  SELECT submission_date, COUNT(DISTINCT hacker_id) as unqH
  FROM cteR
  GROUP BY submission_date
)
SELECT cte2.submission_date, cte4.unqH, cte2.hacker_id, h.name
FROM cte2
LEFT JOIN Hackers h ON cte2.hacker_id = h.hacker_id
LEFT JOIN cte4 ON cte2.submission_date = cte4.submission_date
WHERE rownum = 1
ORDER BY cte2.submission_date;