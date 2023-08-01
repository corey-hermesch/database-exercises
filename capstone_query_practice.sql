USE telco_churn;

SELECT  customer_id, gender, senior_citizen
                            , partner, dependents, tenure, phone_service
                            , multiple_lines, customers.internet_service_type_id
                            , internet_service_types.internet_service_type
                            , online_security, online_backup
                            , device_protection, tech_support
                            , streaming_tv, streaming_movies
                            , customers.contract_type_id
                            , contract_types.contract_type
                            , paperless_billing, customers.payment_type_id
                            , payment_types.payment_type
                            , monthly_charges, total_charges
                            , churn
                        FROM customers
                        JOIN contract_types USING (contract_type_id)
                        JOIN internet_service_types USING (internet_service_type_id)
                        JOIN payment_types USING (payment_type_id)
                        ;
                        
use curriculum_logs;
SELECT id, name, start_date, end_date, program_id
FROM cohorts;


select * from logs;


use used_cars;
SELECT * 
FROM cars;

use capstones;

select *
from cohorts;

select *
from joins;

select * 
from students;

select * 
from teams;

SELECT *
FROM cohorts
JOIN joins ON (cohorts.id = joins.cohort_id)
JOIN students ON (joins.student_id = students.id)
JOIN teams ON (teams.id = joins.team_id)
WHERE cohorts.cohort_name = 'Pagel' 
   AND cohorts.is_active = 'yes'
ORDER BY team_name
;

SELECT *
FROM students
LEFT JOIN joins ON (students.id = joins.student_id)
;