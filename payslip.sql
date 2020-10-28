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
SET LINESIZE 78

COLUMN "name" HEADING "Name" format a25
COLUMN "drivecount" HEADING "Number of runs performed" format a25
COLUMN "total_wage" HEADING "Total wage" format 9,999.99


TTITLE CENTER "P A Y S L I P" SKIP 4-

SET DBMS_OUTPUT ON;
SET TERMOUT ON
PROMPT Please enter your name. WARNING: cAsE sEnSiTiVe! 
PROMPT Enter your first name.
ACCEPT f_name CHAR PROMPT 'First name:'
PROMPT Enter your second name.
ACCEPT l_name CHAR PROMPT 'Last name:'

CREATE OR REPLACE VIEW payslip AS
    SELECT (SUM(cost) * 0.1) AS total_wage FROM bookings WHERE driver_id = (SELECT driver_id FROM drivers WHERE first_name = '&&f_name' AND last_name = '&&l_name' AND employment_type_id = 2) GROUP BY driver_id
    UNION
    SELECT 10 AS total_wage from drivers WHERE first_name = '&&f_name' AND last_name = '&&l_name' AND employment_type_id = 1
    UNION
    SELECT 9.50 AS total_wage from operators WHERE first_name = '&&f_name' AND last_name = '&&l_name';
spool payslip.lst
select * from payslip;
spool OFF
CLEAR COLUMN
CLEAR BREAK
CLEAR COMPUTE
TTITLE OFF
BTITLE OFF
