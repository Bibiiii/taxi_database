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

TTITLE CENTER "W O R K  R O T A" SKIP 4-


SET TERMOUT ON
spool workrota.lst
SELECT DISTINCT revenue_item, gross_profit, current_balance, booking_datetime from revenue FULL OUTER JOIN bookings ON revenue.revenue_item = bookings.booking_id where booking_datetime > TO_DATE('&&check_date', 'DD-MON-YYYY') and booking_datetime < ADD_MONTHS(TO_DATE('&&check_date', 'DD-MON-YYYY') , 1) and current_balance IS NOT NULL order by revenue_item;  
spool off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF