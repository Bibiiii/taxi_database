DROP TABLE revenue CASCADE CONSTRAINTS PURGE;
DROP TABLE outgoings CASCADE CONSTRAINTS PURGE;
DROP TABLE bookings CASCADE CONSTRAINTS PURGE;
DROP TABLE booking_payments CASCADE CONSTRAINTS PURGE;
DROP TABLE operators CASCADE CONSTRAINTS PURGE;
DROP TABLE drivers CASCADE CONSTRAINTS PURGE;
DROP TABLE vehicles CASCADE CONSTRAINTS PURGE;
DROP TABLE clients  CASCADE CONSTRAINTS PURGE;
DROP TABLE booking_types CASCADE CONSTRAINTS PURGE;
DROP TABLE client_types CASCADE CONSTRAINTS PURGE;
DROP TABLE vehicle_owners CASCADE CONSTRAINTS PURGE;
DROP TABLE driver_employment_types CASCADE CONSTRAINTS PURGE;
DROP TABLE vehicle_status CASCADE CONSTRAINTS PURGE;
DROP TABLE shift_times CASCADE CONSTRAINTS PURGE;
DROP TABLE payment_status CASCADE CONSTRAINTS PURGE;
DROP TABLE addresses CASCADE CONSTRAINTS PURGE;
DROP TABLE employees  CASCADE CONSTRAINTS PURGE;

SET SERVEROUTPUT ON;

-- EXPERIMENT BEFORE DENORMALIZATION

SET TIMING ON

SELECT first_name, last_name
FROM drivers
WHERE shift_time_id = 3
UNION
SELECT first_name, last_name
FROM operators
WHERE shift_time_id = 3
;

-- ADD ALL TABLES
@denormalizationTableCreation.sql

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR2(45) NOT NULL,
    last_name VARCHAR2(45) NOT NULL,
    shift_time_id INT NOT NULL,
);

CREATE OR REPLACE PROCEDURE add_employee (
	first_name_in IN VARCHAR2,
	last_name_in IN VARCHAR2,
	tel_in IN VARCHAR2,
	email_in IN VARCHAR2,
	shift_id_in IN INT)
IS
BEGIN
	INSERT INTO employees(first_name, last_name, tel, email, shift_time_id, date_of_join)
	VALUES (first_name_in, last_name_in, tel_in, email_in, shift_id_in, '15-Jul-2019');
END add_employee;
/

@tablePopulation.sql
@autoIncrement.sql

drop sequence employee_id_seq;

--auto increment for the employees table PK.
CREATE SEQUENCE employee_id_seq;

CREATE OR REPLACE TRIGGER employee_id_trig
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	SELECT employee_id_seq.NEXTVAL
	INTO :NEW.employee_id
	FROM dual;
END;
/

@triggers.sql

SELECT first_name, last_name
FROM employees
WHERE shift_time_id = 3
                                          
COMMIT;

