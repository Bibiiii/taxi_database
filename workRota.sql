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
COLUMN "start_time" HEADING "Start" format a25
COLUMN "end_time" HEADING "End" format a25


TTITLE CENTER "W O R K  R O T A" SKIP 4-


SET TERMOUT ON
spool workrota.lst

SELECT (first_name || ' ' || last_name) AS name, start_time, end_time FROM drivers right join shift_times on drivers.shift_time_id = shift_times.shift_time_id order by drivers.shift_time_id, last_name;

spool off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF