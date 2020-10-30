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
SET LINESIZE 100

COLUMN "id" HEADING "Address ID" format 9,999
COLUMN "Amount" HEADING "Amount" format 999
COLUMN "name" HEADING "Address" format a25
COLUMN "city" HEADING "City" format a25
COLUMN "postcode" HEADING "Postcode" format a25

TTITLE CENTER "A D D R E S S E S  W I T H  M U L T I P L E  O C C U P A N T S" SKIP 4-

SET TERMOUT ON
spool multipleOccupants.lst


SELECT drivers.address_id as id, COUNT(drivers.address_id) AS Amount, line_1 || ' ' || line_2 AS name, city, postcode
FROM addresses LEFT JOIN drivers ON drivers.address_id = addresses.address_id 
GROUP BY drivers.address_id, line_1, line_2, city, postcode HAVING COUNT(drivers.address_id) > 1;


spool off
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF