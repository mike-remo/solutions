/*
LeetCode Solution - 185. Department Top Three Salaries
By Michael Remollino (mike dot remo @ g mail dot com)
https://leetcode.com/problems/department-top-three-salaries/
*/

WITH cte AS (
SELECT e.id, e.departmentId, e.name, e.salary
     , DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY salary DESC) AS rankedByDept
FROM Employee e
)
SELECT d.name AS Department, c.name as Employee, c.salary
FROM CTE c
LEFT JOIN Department d
  ON d.id = c.departmentId
WHERE rankedByDept < 4
ORDER BY c.id
