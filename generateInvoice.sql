CLEAR SCREEN
PROMPT Press Enter to create an invoice
SET FEEDBACK OFF
SET TERMOUT OFF
SET VERIFY OFF
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF
SET PAGESIZE 80
SET LINESIZE 70
COLUMN bookingid new_val booking_id
COLUMN "Client name" format a30
COLUMN "From" format a4
COLUMN "To" format a4
COLUMN "Via" format a4
COLUMN "Class" format a10
COLUMN "Ticket Price" format 99999.99
COLUMN today_date new_val invoice_date
-- COLUMN addr1 noprint new_val booker_add1
-- COLUMN addr2 noprint new_val booker_add2
-- COLUMN addr3 noprint new_val booker_add3
-- COLUMN city noprint new_val booker_city
-- COLUMN county noprint new_val booker_county
-- COLUMN postcode noprint new_val booker_post
-- COLUMN country noprint new_val booker_country
-- COLUMN journeyid new_val journey_no
TTITLE CENTER "C L I E N T  I N V O I C E" SKIP 4-
LEFT "QMTaxico"  RIGHT client_name SKIP 1-
LEFT "Mile End" SKIP 1-
LEFT "London" SKIP 1-
LEFT "Client id: " &booking
LEFT "London" SKIP 1-
LEFT "E1 4NS" SKIP 1-
LEFT "United Kingdom"  SKIP 1-
RIGHT SKIP 3-
LEFT "Invoice date: " today_date SKIP 1-
SKIP 1- LEFT "Invoice
Number:"  SKIP 3-
UNDEF client;
SET TERMOUT ON
PROMPT Enter Booking Number to Check Out
ACCEPT client NUMBER PROMPT 'Client Number :'
SELECT first_name + last_name INTO client_name FROM clients where client_id = &&client; 
spool invoice.lst

-- SELECT location_from, location_to, cost, payment_id FROM bookings where client_id = ;
-- BREAK ON bookingid SKIP 3
-- COMPUTE sum label 'Total Cost' of "Ticket Price" on bookingid
SELECT DISTINCT location_from, location_to, cost, payment_id from bookings where client_id = &&client ORDER BY payment_id;
-- FROM booking book,
-- booker bkr,
-- address a,
-- fares f,
-- segment s,
-- journey j,
-- passenger p
-- WHERE bkr.bookerid = book.bookerid
-- AND bkr.addrid = a.addrid
-- AND book.bookingid = p.bookingid
-- AND book.bookingid = s.bookingid
-- AND s.journeyid = f.journeyid
-- AND j.journeyid = f.journeyid
-- AND book.bookingid = &&booking
-- AND exists(select 'X' from planeflight pf where pf.flightid =
-- s.flightid and pf.local_departure_time between f.startdate and
-- f.enddate)
-- ORDER BY j.journeyid;
spool off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF