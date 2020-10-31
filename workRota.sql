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
TTITLE "D R I V E R S"
SELECT (first_name || ' ' || last_name) AS name, start_time, end_time FROM drivers left join shift_times on drivers.shift_time_id = shift_times.shift_time_id order by drivers.shift_time_id, last_name;
TTITLE "O P E R A T O R S"
SELECT (first_name || ' ' || last_name) AS name, start_time, end_time FROM operators left join shift_times on operators.shift_time_id = shift_times.shift_time_id order by operators.shift_time_id, last_name;
spool off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF