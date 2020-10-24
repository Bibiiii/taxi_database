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
SET LINESIZE 90
COLUMN 'revenue_item' HEADING 'Transaction Number'
COLUMN 'gross_profit' HEADING 'Amount'
COLUMN 'current_balance' HEADING 'Current Amount'
COLUMN 'booking_datetime' HEADING 'Date and Time of Transaction'
COLUMN 'description' HEADING 'Description'

TTITLE CENTER "B A L A N C E  S H E E T" SKIP 4-


SET TERMOUT ON
PROMPT Enter day, month and year to check.
ACCEPT check_date CHAR PROMPT '(DD-MON-YYYY) : ' 
spool monthlybalancesheet.lst
SELECT DISTINCT revenue_item, gross_profit, current_balance, booking_datetime, description 
FROM revenue 
FULL OUTER JOIN bookings 
ON revenue.revenue_item = bookings.booking_id 
FULL OUTER JOIN outgoings 
ON revenue.revenue_item = outgoings.payment_id 
WHERE booking_datetime > TO_DATE('&&check_date', 'DD-MON-YYYY') 
AND booking_datetime < ADD_MONTHS(TO_DATE('&&check_date', 'DD-MON-YYYY') , 1) 
AND current_balance IS NOT NULL 
ORDER BY revenue_item;  
SPOOL OFF
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF