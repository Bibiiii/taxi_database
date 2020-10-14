DROP TABLE revenue PURGE;
DROP TABLE bookings PURGE;
DROP TABLE booking_payments PURGE;
DROP TABLE operators PURGE;
DROP TABLE drivers PURGE;
DROP TABLE vehicles PURGE;
DROP TABLE clients PURGE;
DROP TABLE booking_types PURGE;
DROP TABLE client_types PURGE;
DROP TABLE vehicle_owners PURGE;
DROP TABLE driver_employment_types PURGE;
DROP TABLE vehicle_status PURGE;
DROP TABLE shift_times PURGE;
DROP TABLE payment_status PURGE;
DROP TABLE addresses PURGE;

SET SERVEROUTPUT ON;

CREATE TABLE addresses (
	address_id INT PRIMARY KEY,
	line_1 VARCHAR2(45) NOT NULL,
	line_2 VARCHAR2(45),
	city VARCHAR2(45) NOT NULL,
	postcode VARCHAR2(45) NOT NULL);

CREATE TABLE payment_status (
	payment_status_id INT PRIMARY KEY,
	description VARCHAR2(45) NOT NULL);	

CREATE TABLE shift_times (
	shift_time_id INT PRIMARY KEY,
	start_time TIMESTAMP NOT NULL,
	end_time TIMESTAMP NOT NULL);

CREATE TABLE vehicle_status (
	status_id INT PRIMARY KEY,
	description VARCHAR2(45) NOT NULL UNIQUE CHECK (description IN ('roadworthy', 'in_for_service', 'written_off')));

CREATE TABLE driver_employment_types (
	type_id INT PRIMARY KEY,
	description VARCHAR2(45) UNIQUE NOT NULL CHECK (description IN ('fixed_salary', 'percent_cut')));

CREATE TABLE vehicle_owners (
	owner_id INT PRIMARY KEY,
	first_name VARCHAR2(45) NOT NULL,
	last_name VARCHAR2(45) NOT NULL,
	tel VARCHAR2(45) NOT NULL,
	email VARCHAR2(45) NOT NULL,
	address_id INT NOT NULL,
	CONSTRAINT vehicle_owners_fk0 FOREIGN KEY (address_id) REFERENCES addresses(address_id));

CREATE TABLE client_types (
	type_id INT PRIMARY KEY,
	description VARCHAR2(255) NOT NULL CHECK (description IN ('private', 'corporate')));

CREATE TABLE booking_types (
	booking_type_id INT PRIMARY KEY,
	description VARCHAR2(255) UNIQUE NOT NULL);

CREATE TABLE clients (
	client_id INT PRIMARY KEY,
	first_name VARCHAR2(45) NOT NULL,
	last_name VARCHAR2(45) NOT NULL,
	tel VARCHAR2(45) NOT NULL,
	email VARCHAR2(45) NOT NULL,
	address_id INT NOT NULL, 
	client_type INT NOT NULL,
	CONSTRAINT clients_fk0 FOREIGN KEY (address_id) REFERENCES addresses(address_id),
	CONSTRAINT clients_fk1 FOREIGN KEY (client_type) REFERENCES client_types(type_id));

CREATE TABLE vehicles (
	registration_number VARCHAR2(45) PRIMARY KEY,
	last_mot DATE NOT NULL,
	status_id INT NOT NULL,
	owner_id INT NOT NULL,
	CONSTRAINT vehicles_fk0 FOREIGN KEY (status_id) REFERENCES vehicle_status(status_id),
	CONSTRAINT vehicles_fk1 FOREIGN KEY (owner_id) REFERENCES vehicle_owners(owner_id));

CREATE TABLE drivers (
	driver_id INT PRIMARY KEY,
	first_name VARCHAR2(45) NOT NULL,
	last_name VARCHAR2(45) NOT NULL,
	tel VARCHAR2(45) NOT NULL,
	email VARCHAR2(45) NOT NULL,
	date_of_join DATE NOT NULL,
	address_id INT NOT NULL,
	shift_time_id INT NOT NULL,
	employment_type INT NOT NULL,
	registration_number INT NOT NULL UNIQUE,
	CONSTRAINT drivers_fk4 FOREIGN KEY (address_id) REFERENCES addresses(address_id),
	CONSTRAINT drivers_fk0 FOREIGN KEY (shift_time_id) REFERENCES shift_times(shift_time_id),
	CONSTRAINT drivers_fk1 FOREIGN KEY (employment_type) REFERENCES driver_employment_types(type_id));

CREATE TABLE operators (
	operator_id INT PRIMARY KEY CHECK (operator_id <= 8),
	first_name VARCHAR2(45) NOT NULL,
	last_name VARCHAR2(45) NOT NULL,
	tel VARCHAR2(45) NOT NULL,
	email VARCHAR2(45) NOT NULL,
	call_count INT NOT NULL,
	date_of_join DATE NOT NULL,
	address_id INT NOT NULL,
	shift_time_id INT NOT NULL,
	CONSTRAINT operators_fk0 FOREIGN KEY (address_id) REFERENCES addresses(address_id),
	CONSTRAINT operators_fk1 FOREIGN KEY (shift_time_id) REFERENCES shift_times(shift_time_id));

CREATE TABLE booking_payments(	
	payment_id INT PRIMARY KEY,
	card_last_4 VARCHAR2(45) NOT NULL,
	total_cost NUMBER(10,4) NOT NULL CHECK (total_cost > 0),
	payment_status_id INT NOT NULL,
	client_id INT NOT NULL,
	CONSTRAINT payments_fk0 FOREIGN KEY (payment_status_id) REFERENCES payment_status(payment_status_id),
	CONSTRAINT payments_fk1 FOREIGN KEY (client_id) REFERENCES clients(client_id));

CREATE TABLE bookings (
	booking_id INT PRIMARY KEY,
	location_from VARCHAR2(45) NOT NULL,
	location_to VARCHAR2(45) NOT NULL,
	booking_time TIMESTAMP NOT NULL,
	call_received TIMESTAMP NOT NULL,
	operator_id INT NOT NULL,
	driver_id INT NOT NULL,
	client_id INT NOT NULL,
	payment_id INT NOT NULL,
	booking_type_id INT NOT NULL,
	CONSTRAINT bookings_fk0 FOREIGN KEY (operator_id) REFERENCES operators(operator_id),
	CONSTRAINT bookings_fk1 FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
	CONSTRAINT bookings_fk2 FOREIGN KEY (client_id) REFERENCES clients(client_id),
	CONSTRAINT bookings_fk3 FOREIGN KEY (payment_id) REFERENCES booking_payments(payment_id),
	CONSTRAINT bookings_fk4 FOREIGN KEY (booking_type_id) REFERENCES booking_types(booking_type_id));

CREATE TABLE outgoings (
	outgoing_id INT PRIMARY KEY,
	description VARCHAR(45) NOT NULL CHECK (description IN ('gas bill','electricity bill', 'car maintenance', 'wages', 'office expenses')),
	amount NUMBER(10,4) NOT NULL CHECK (amount > 0)
)

CREATE TABLE revenue (
	revenue_item INT PRIMARY KEY,
	gross_profit NUMBER(10,4) NOT NULL,
	net_profit NUMBER(10,4) NOT NULL,
	transaction_source INT NOT NULL,
	current_balance NUMBER(10,4) NOT NULL);

CREATE OR REPLACE TRIGGER check_transaction_source
	BEFORE INSERT OR UPDATE 
	ON revenue
	FOR EACH ROW
	BEGIN
		IF (COUNT(SELECT * FROM booking_payments where booking_id = :NEW.transaction_source) = 0)
			THEN RAISE_APPLICATION_ERROR(-20001, 'Transaction source not recorded in either the bookings or outgoings table.');
		END IF;
	END;
/
-- WIP
-- CREATE OR REPLACE TRIGGER update_balance_booking
-- 	AFTER INSERT 
-- 	ON booking_payments
-- 	FOR EACH ROW
-- 	DECLARE 
-- 		amount_earned NUMBER(10,4) := :NEW.total_cost;
-- 		payment_id INT := :NEW.payment_id;
-- 		current_balance NUMBER(10,4) := :NEW.current_balance;
-- 	BEGIN
-- 		INSERT INTO revenue (gross_profit, net_profit, booking_id, current_balance) 
-- 		VALUES (amount_earned, amount_earned - , , );
-- 	END;
-- /

CREATE OR REPLACE TRIGGER check_MOT_date
	BEFORE INSERT OR UPDATE
	ON vehicles
	FOR EACH ROW
	BEGIN
	IF(:NEW.LAST_MOT < ADD_MONTHS(SYSDATE, -12)) THEN DBMS_OUTPUT.PUT_LINE('There has not been an MOT in the last year. Putting car in for a service.'); 
	:NEW.status_id := 2;
	END IF;
	END;
/

CREATE OR REPLACE TRIGGER check_MOT_and_status
	BEFORE UPDATE
	on vehicles
	FOR EACH ROW
	BEGIN
		IF(:NEW.LAST_MOT < ADD_MONTHS(SYSDATE, -12) AND :NEW.status_id = 1) THEN
		RAISE_APPLICATION_ERROR(-20001, 'You cannot bring this car back on the road while it is in need of an MOT.');
		END IF;
	END;
/

CREATE OR REPLACE TRIGGER prevent_status_change_write_off
	BEFORE UPDATE
	ON vehicles
	FOR EACH ROW
	BEGIN
		IF(:OLD.status_id = 3 AND :NEW.status_id <> 3) THEN RAISE_APPLICATION_ERROR(-20001, 'This vehicle has been written off. You cannot bring it back on the road.');
		END IF;
	END;
/

COMMIT;
SET TIMING ON;
INSERT INTO addresses(address_id, line_1, line_2, city, postcode) VALUES (1, '64', 'Zoo Lane', 'London', 'SW2 2FA');
INSERT INTO vehicle_owners(owner_id, first_name, last_name, tel, email, address_id) VALUES (1, 'Joe', 'Bloggs', '01212345', 'Joe@Bloggs.net', 1);
INSERT INTO vehicle_status(status_id, description) VALUES (1, 'roadworthy');
INSERT INTO vehicle_status(status_id, description) VALUES (2, 'in_for_service');
INSERT INTO vehicle_status(status_id, description) VALUES (3, 'written_off');
INSERT INTO vehicles(registration_number, last_mot, status_id, owner_id) VALUES ('EA12 DFG', '08-SEP-2018', 1, 1);
UPDATE vehicles SET status_id = 1 WHERE registration_number = 'EA12 DFG';
SET TIMING OFF;


