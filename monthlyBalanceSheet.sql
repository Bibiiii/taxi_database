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
SET LINESIZE 100
COLUMN 'revenue_item' HEADING 'Transaction Number' format 99999
COLUMN 'gross_profit' HEADING 'Amount' format 9,999.99
COLUMN 'current_balance' HEADING 'Current Amount' format 9,999,999.99
COLUMN 'DATETIME' HEADING 'Date and Time of Transaction' format a30
COLUMN 'description' HEADING 'Description' format a25

TTITLE CENTER "B A L A N C E  S H E E T" SKIP 4-


SET TERMOUT ON
PROMPT Enter day, month and year to check.
ACCEPT check_date CHAR PROMPT '(DD-MON-YYYY) : ' 
spool monthlybalancesheet.lst
SELECT DISTINCT revenue_item, gross_profit, current_balance, to_char(booking_datetime) as datetime, description 
FROM revenue 
FULL OUTER JOIN bookings 
ON revenue.revenue_item = bookings.booking_id 
FULL OUTER JOIN outgoings 
ON revenue.revenue_item = outgoings.payment_id 
WHERE booking_datetime BETWEEN TO_DATE('&&check_date', 'DD-MON-YYYY') AND ADD_MONTHS(TO_DATE('&&check_date', 'DD-MON-YYYY') , 1) 
AND current_balance IS NOT NULL 
ORDER BY revenue_item;  
SPOOL OFF
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF