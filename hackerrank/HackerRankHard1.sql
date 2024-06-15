/*
Hacker Rank Solution (MSSQL)
By Michael Remollino (mike dot remo @ g mail dot com)
https://www.hackerrank.com/challenges/interviews/
*/

-- Sample values for testing

-- INIT database
CREATE TABLE Contests (
  contest_id INT,
  hacker_id INT,
  name VARCHAR(100)
);
CREATE TABLE Colleges (
  college_id INT,
  contest_id INT
);
CREATE TABLE Challenges (
  challenge_id INT,
  college_id INT
);
CREATE TABLE View_Stats (
  challenge_id INT,
  total_views INT,
  total_unique_views INT
);
CREATE TABLE Submission_Stats (
  challenge_id INT,
  total_submissions INT,
  total_accepted_submissions INT
);

INSERT INTO Contests(contest_id, hacker_id, name) VALUES
(66406, 17973, 'Rose'),
(66556, 79153, 'Angela'),
(94828, 80275, 'Frank');

INSERT INTO Colleges(college_id, contest_id) VALUES
(11219, 66406),
(32473, 66556),
(56685, 94828);

INSERT INTO Challenges (challenge_id, college_id) VALUES
(18765, 11219),
(47127, 11219),
(60292, 32473),
(72974, 56685);

INSERT INTO View_Stats (challenge_id, total_views, total_unique_views) VALUES
(47127, 26, 19),
(47127, 15, 14),
(18765, 43, 10),
(18765, 72, 13),
(75516, 35, 17),
(60292, 11, 10),
(72974, 41, 15),
(75516, 75, 11);

INSERT INTO Submission_Stats (challenge_id, total_submissions, total_accepted_submissions) VALUES
(75516, 34, 12),
(47127, 27, 10),
(47127, 56, 18),
(75516, 74, 12),
(75516, 83, 8),
(72974, 68, 24),
(72974, 82, 14),
(47127, 28, 11);

-- QUERY database
WITH cte1 AS (
SELECT cha.challenge_id
     , SUM(ISNULL(total_views,0)) AS ttl_view
     , SUM(ISNULL(total_unique_views,0)) AS ttl_unqv
FROM Challenges cha
LEFT JOIN View_Stats vie ON vie.challenge_id = cha.challenge_id
GROUP BY cha.challenge_id
), cte2 AS (
SELECT cha.challenge_id
     , SUM(ISNULL(total_submissions,0)) AS ttl_subm
     , SUM(ISNULL(total_accepted_submissions,0)) AS ttl_accs
FROM Challenges cha
LEFT JOIN Submission_Stats sub ON sub.challenge_id = cha.challenge_id
GROUP BY cha.challenge_id
)
SELECT con.contest_id, hacker_id, name
     , SUM(ttl_subm) AS ttl_submitted
     , SUM(ttl_accs) AS ttl_accepted
     , SUM(ttl_view) AS ttl_views
     , SUM(ttl_unqv) AS ttl_uq_views
     --, COUNT(cha.challenge_id) AS hits
FROM Contests con
LEFT JOIN Colleges col ON col.contest_id = con.contest_id
LEFT JOIN Challenges cha ON cha.college_id = col.college_id
LEFT JOIN cte1 ON cte1.challenge_id = cha.challenge_id
LEFT JOIN cte2 ON cte2.challenge_id = cha.challenge_id
GROUP BY con.contest_id, hacker_id, name
HAVING COUNT(cha.challenge_id) > 0
ORDER BY con.contest_id ASC;