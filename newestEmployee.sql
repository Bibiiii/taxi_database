CLEAR SCREEN
SET FEEDBACK OFF
SET TERMOUT OFF
SET VERIFY OFF
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF

SET PAGESIZE 100
SET LINESIZE 78

COLUMN "name" HEADING "Name" format a25
COLUMN "date_of_join" HEADING "Join Date" format a25


TTITLE CENTER "N E W E S T  E M P L O Y E E" SKIP 4-

SET TERMOUT ON
spool newestEmployee.lst

TTITLE "N E W E S T  D R I V E R"

SELECT (first_name || ' ' || last_name) AS name, date_of_join
FROM drivers
WHERE date_of_join=(
SELECT MAX(date_of_join) FROM drivers);

TTITLE "N E W E S T  O P E R A T O R"

SELECT (first_name || ' ' || last_name) AS name, date_of_join
FROM operators
WHERE date_of_join=(
SELECT MAX(date_of_join) FROM operators);

spool off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF