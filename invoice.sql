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
UNDEF client;
UNDEF client_name;
COLUMN "name" HEADING "Client name" format a25
COLUMN "location_from"  HEADING "Location travelled from" format a25
COLUMN "location_to" HEADING "Location travelled to" format a25
COLUMN "cost" HEADING "Cost" format  999,990.00
COLUMN "Payment_ID" HEADING "Payment ID" format 9999999;
COLUMN today_date noprint new_val invoice_date
SELECT TO_CHAR(sysdate, 'DD-Mon-YYYY') today_date FROM dual;
TTITLE CENTER "C L I E N T  I N V O I C E" SKIP 4-
LEFT "QMTaxico" RIGHT  SKIP 1-
LEFT "Mile End" SKIP 1-
LEFT "London" SKIP 1-
LEFT "E1 4NS" SKIP 1-
LEFT "United Kingdom"  SKIP 3-
LEFT "Invoice date: " invoice_date SKIP 2-
LEFT "Client id: " client  SKIP 2-


SET TERMOUT ON
PROMPT Enter Booking Number to Check Out
ACCEPT client NUMBER PROMPT 'Client Number :'
spool invoice.lst

BREAK ON name SKIP 2; 
COMPUTE SUM LABEL "Total" of cost on name

SELECT DISTINCT first_name || ' ' || last_name AS name, location_from, location_to, cost, bookings.payment_id
from bookings, clients, booking_payments
where clients.client_id = &&client
and bookings.client_id = &&client
and booking_payments.payment_status_id != 2
ORDER BY payment_id;
spool off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF