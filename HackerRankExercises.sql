USE 311_data;
SELECT * 
FROM cases;

SELECT *
FROM cases
WHERE (case_id % 2) = 0;

SELECT *
FROM cases;

(SELECT COUNT(case_late) FROM cases) - (SELECT COUNT(DISTINCT case_late) FROM cases);

(SELECT COUNT(case_late) - COUNT(DISTINCT case_late) FROM cases);