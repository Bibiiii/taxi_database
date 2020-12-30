-- Indexing

SET TIMING ON

SELECT FIRST_NAME, LAST_NAME, EMAIL FROM CLIENTS
WHERE CLIENTS.EMAIL = 'jhawtryfd@cornell.edu';

SELECT FIRST_NAME, LAST_NAME, EMAIL FROM CLIENTS
WHERE CLIENTS.EMAIL LIKE '%.edu%';

UPDATE CLIENTS SET EMAIL = 'EDU: ' || EMAIL
WHERE CLIENTS.EMAIL LIKE ‘%.edu%';

CREATE UNIQUE INDEX EMAIL_I ON CLIENTS(EMAIL);

SELECT first_name, last_name
FROM drivers
WHERE shift_time_id = 3
UNION
SELECT first_name, last_name
FROM operators
WHERE shift_time_id = 3
;
