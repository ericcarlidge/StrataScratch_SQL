# Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. For simplicity, 
# assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and 
# earliest page_exit. Output the user_id and their average session time.

SELECT user_id, AVG(TIMESTAMPDIFF(SECOND, load_time, exit_time)) AS session_time
FROM (
    SELECT 
        DATE(timestamp), 
        user_id, 
        MAX(IF(action = 'page_load', timestamp, NULL)) as load_time,
        MIN(IF(action = 'page_exit', timestamp, NULL)) as exit_time
    FROM facebook_web_log
    GROUP BY 1, 2
) t 
GROUP BY user_id
HAVING session_time IS NOT NULL;
