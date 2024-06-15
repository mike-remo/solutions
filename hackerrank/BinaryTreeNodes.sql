/*
Hacker Rank Solution (MSSQL)
By Michael Remollino (mike dot remo @ g mail dot com)
https://www.hackerrank.com/challenges/binary-search-tree-1/
*/

SELECT N, CASE
    WHEN P IS NULL THEN 'Root'
    WHEN N IN (SELECT P FROM BST) THEN 'Inner'
    ELSE 'Leaf' END AS Output
FROM BST
ORDER BY N;