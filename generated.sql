DROP TABLE revenue;
DROP TABLE bookings;
DROP TABLE payments;
DROP TABLE operators;
DROP TABLE drivers;
DROP TABLE vehicles;
DROP TABLE clients;
DROP TABLE booking_types;
DROP TABLE client_types;
DROP TABLE vehicle_owners;
DROP TABLE driver_employment_types;
DROP TABLE vehicle_status;
DROP TABLE shift_times;
DROP TABLE payment_status;
DROP TABLE addresses;

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
	description VARCHAR2(45) NOT NULL CHECK (description IN ('roadworthy', 'in_for_service', 'written_off')));

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

-- CREATE sequence CLIENT_TYPES_TYPE_ID_SEQ;

-- CREATE trigger BI_CLIENT_TYPES_TYPE_ID
--   before insert on client_types
--   for each row
--   begin
--   select CLIENT_TYPES_TYPE_ID_SEQ.nextval into :NEW.type_id from dual;
--   end;
-- /

CREATE TABLE booking_types (
	booking_type_id INT PRIMARY KEY,
	description VARCHAR2(255) UNIQUE NOT NULL);

-- CREATE sequence BOOKING_TYPES_BOOKING_TYPE_ID_SEQ;

-- CREATE trigger BI_BOOKING_TYPES_BOOKING_TYPE_ID
--   before insert on booking_types
--   for each row
-- begin
--   select BOOKING_TYPES_BOOKING_TYPE_ID_SEQ.nextval into :NEW.booking_type_id from dual;
-- end;
-- /

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
	last_mot TIMESTAMP NOT NULL,
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

CREATE TABLE payments (
	payment_id INT PRIMARY KEY,
	card_last_4 VARCHAR2(45) NOT NULL,
	total_cost INT NOT NULL CHECK (total_cost > 0),
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
	CONSTRAINT bookings_fk3 FOREIGN KEY (payment_id) REFERENCES payments(payment_id),
	CONSTRAINT bookings_fk4 FOREIGN KEY (booking_type_id) REFERENCES booking_types(booking_type_id));

CREATE TABLE revenue (
	revenue_item INT PRIMARY KEY,
	gross_profit INT NOT NULL,
	net_profit INT NOT NULL,
	booking_id INT NOT NULL,
	CONSTRAINT revenue_fk0 FOREIGN KEY (booking_id) REFERENCES bookings(booking_id));

-- CREATE sequence REVENUE_REVENUE_ITEM_SEQ;

-- CREATE trigger BI_REVENUE_REVENUE_ITEM
--   before insert on revenue
--   for each row
-- begin
--   select REVENUE_REVENUE_ITEM_SEQ.nextval into :NEW.revenue_item from dual;
-- end;

-- /

COMMIT;






