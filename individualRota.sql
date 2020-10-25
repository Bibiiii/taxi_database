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


TTITLE CENTER "I N D I V I D U A L  R O T A" SKIP 4-


SET TERMOUT ON
PROMPT Please enter your name. WARNING: cAsE sEnSiTiVe! 
PROMPT Enter your first name.
ACCEPT f_name CHAR PROMPT 'First name:'
PROMPT Enter your second name.
ACCEPT l_name CHAR PROMPT 'Last name:'

spool individualrota.lst
SELECT (first_name || ' ' || last_name) AS name,
start_time,
end_time 
FROM drivers
right join shift_times 
on drivers.shift_time_id = shift_times.shift_time_id 
WHERE first_name = '&&f_name' 
and last_name = '&&l_name' 
order by drivers.shift_time_id, last_name;
SELECT (first_name || ' ' || last_name) AS name,
start_time,
end_time 
FROM operators
right join shift_times 
on operators.shift_time_id = shift_times.shift_time_id 
WHERE first_name = '&&f_name' 
and last_name = '&&l_name' 
order by operators.shift_time_id, last_name;
spool off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF