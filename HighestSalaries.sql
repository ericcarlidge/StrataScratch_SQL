# You have been asked to find the job titles of the highest-paid employees.
# Your output should include the highest-paid title or multiple titles with the same salary.

SELECT title.worker_title
FROM title
JOIN worker ON title.worker_ref_id=worker.worker_id
WHERE salary IN (SELECT MAX(salary)
                    FROM worker);
