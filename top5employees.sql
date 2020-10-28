CLEAR SCREEN
SET FEEDBACK OFF
SET TERMOUT OFF
CLEAR COLUMN
TTITLE OFF
BTITLE OFF
SET PAGESIZE 100
SET LINESIZE 78
SET TERMOUT ON;

spool top5employees.lst
SELECT driver_id, count(*) as "Number of bookings dealt with" FROM bookings group by driver_id order by count(*) desc fetch first 5 rows only;
SELECT operator_id, count(*) as "Number of bookings dealt with" FROM bookings group by bookings.operator_id order by count(*) desc fetch first 5 rows only;
spool OFF
CLEAR COLUMN
TTITLE OFF
BTITLE OFF