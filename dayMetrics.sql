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
SET LINESIZE 85

COLUMN "id" HEADING "Id number" format 9999
COLUMN "occupation" HEADING "Occupation" format a15
COLUMN "first_name" HEADING "First name" format a15
COLUMN "last_name" HEADING "Last name" format a15
COLUMN "count(booking_id)" HEADING "Number of bookings" format 999
COLUMN "count(*)" HEADING "Number of calls taken"
TTITLE CENTER "D A Y  M E T R I C S" SKIP 4-

SET TERMOUT ON
PROMPT Please enter the day you wish to examine.
ACCEPT date_check CHAR PROMPT 'Day (DD-MON-YYYY): '
SPOOL daymetrics.lst 
SELECT drivers.driver_id as id, 'Driver' as occupation, first_name, last_name, count(booking_id) FROM drivers FULL OUTER JOIN bookings on drivers.driver_id = bookings.driver_id where bookings.booking_datetime > '&&date_check' and bookings.booking_datetime < (TO_DATE('&&date_check', 'DD-MON-YYYY') + 1) group by drivers.driver_id, drivers.first_name, drivers.last_name order by drivers.driver_id;
SELECT operators.operator_id as id, 'Operator' as occupation, first_name, last_name, count(*) FROM operators FULL OUTER JOIN bookings on operators.operator_id = bookings.operator_id where bookings.booking_datetime > '&&date_check' and bookings.booking_datetime < (TO_DATE('&&date_check', 'DD-MON-YYYY') + 1) group by operators.operator_id, operators.first_name, operators.last_name order by operators.operator_id;
SPOOl off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF