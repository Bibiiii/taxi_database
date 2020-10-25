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
SET LINESIZE 70

COLUMN "id" HEADING "Driver id" format 999999
COLUMN "first_name" HEADING "First name" format a15
COLUMN "last_name" HEADING "Last name" format a15
COLUMN "count(booking_id)" HEADING "Number of bookings" format 999

TTITLE CENTER "D A Y  M E T R I C S" SKIP 4-


SET TERMOUT ON
PROMPT Please enter the day you wish to examine.
ACCEPT date_check CHAR PROMPT 'Day (DD-MON-YYYY): '
SPOOL daymetrics.lst 
SELECT drivers.driver_id as id, first_name, last_name, count(booking_id) FROM drivers FULL OUTER JOIN bookings on drivers.driver_id = bookings.driver_id where bookings.booking_datetime > '&&date_check' and bookings.booking_datetime < (TO_DATE('&&date_check', 'DD-MON-YYYY') + 1) group by drivers.driver_id, drivers.first_name, drivers.last_name order by drivers.driver_id;
spool off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF