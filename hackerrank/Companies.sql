/*
Hacker Rank Solution (MSSQL)
By Michael Remollino (mike dot remo @ g mail dot com)
https://www.hackerrank.com/challenges/the-company/
*/

SELECT  CO.company_code, founder
            , COUNT(DISTINCT LM.lead_manager_code) AS LMs
            , COUNT(DISTINCT SM.senior_manager_code) AS SMs
            , COUNT(DISTINCT MA.manager_code) AS MAs
            , COUNT(DISTINCT EM.employee_code) AS EMs
FROM Company CO
LEFT JOIN Lead_Manager LM ON LM.company_code = CO.company_code
LEFT JOIN Senior_Manager SM ON SM.company_code = CO.company_code
    AND SM.lead_manager_code = LM.lead_manager_code
LEFT JOIN Manager MA ON MA.company_code = CO.company_code 
    AND MA.senior_manager_code = SM.senior_manager_code
LEFT JOIN Employee EM ON EM.company_code = CO.company_code
    AND EM.manager_code = MA.manager_code
GROUP BY CO.company_code, founder
ORDER BY CO.company_code ASC;