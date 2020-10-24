CLEAR SCREEN
SET FEEDBACK OFF
SET TERMOUT OFF
SET VERIFY OFF
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF
SET PAGESIZE 80
SET LINESIZE 95

TTITLE CENTER "M O N T H L Y  B A L A N C E  S H E E T" SKIP 4-


SET TERMOUT ON
PROMPT Enter day, month and year to check.
ACCEPT check_date CHAR PROMPT '(DD-MON-YYYY) : ' 
spool invoice.lst
SELECT DISTINCT revenue_item, gross_profit, current_balance, booking_datetime from revenue FULL OUTER JOIN bookings ON revenue.revenue_item = bookings.booking_id where booking_datetime > TO_DATE('&&check_date', 'DD-MON-YYYY') and booking_datetime < ADD_MONTHS(TO_DATE('&&check_date', 'DD-MON-YYYY') , 1)  order by revenue_item;  
spool off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF