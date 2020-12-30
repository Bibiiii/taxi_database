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
SET LINESIZE 120
UNDEF City;

COLUMN "line_1" HEADING "Address Line 1" format a30
COLUMN "line_2" HEADING "Address Line 2" format a30
COLUMN "postcode" HEADING "Postcode" format a30

SET TERMOUT ON
PROMPT Enter City to Check Out
ACCEPT City VARCHAR2 PROMPT 'City: '
CLEAR SCREEN
spool clientsWithNoBookingsInCertainCity.lst

-- Returns addresses in certain city that have no booking
SELECT line_1, line_2, postcode FROM addresses
WHERE EXISTS (
SELECT *
FROM clients
WHERE (NOT EXISTS (SELECT * FROM bookings WHERE clients.client_id = bookings.client_id)) AND city IN '&&City');


spool off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF