drop sequence ADDRESS_ID_SEQ;
drop sequence BOOKINGS_ID_SEQ;
drop sequence BOOKING_ID_SEQ;
drop sequence CLIENTS_ID_SEQ;
drop sequence CLIENT_ID_SEQ;
drop sequence DRIVER_ID_SEQ;
drop sequence OPERATOR_ID_SEQ;
drop sequence OWNER_ID_SEQ;
drop sequence PAYMENT_ID_SEQ;
drop sequence PAYMENT_STATUS_SEQ;
drop sequence REVENUE_ITEM_SEQ;
drop sequence SHIFT_TIME_ID_SEQ;
drop sequence STATUS_ID_SEQ;
drop sequence TYPE_ID_SEQ;
drop sequence OUTGOINGS_ID_SEQ;

--auto increment for the address table PK.
CREATE SEQUENCE address_id_seq;

CREATE OR REPLACE TRIGGER address_id_trig
BEFORE INSERT ON addresses
FOR EACH ROW
BEGIN
	SELECT address_id_seq.NEXTVAL
	INTO :NEW.address_id
	FROM dual;
END;
/

--auto increment for the payment_status table PK.
CREATE SEQUENCE payment_status_seq;

CREATE OR REPLACE TRIGGER payment_status_id_trig
BEFORE INSERT ON payment_status
FOR EACH ROW
BEGIN
	SELECT payment_status_seq.NEXTVAL
	INTO :NEW.payment_status_id
	FROM dual;
END;
/


--auto increment for the shift_times table PK.
CREATE SEQUENCE shift_time_id_seq;

CREATE OR REPLACE TRIGGER shift_time_id_trig
BEFORE INSERT ON shift_times
FOR EACH ROW
BEGIN
	SELECT shift_time_id_seq.NEXTVAL
	INTO :NEW.shift_time_id
	FROM dual;
END;
/


--auto increment for the vehicle_status table PK.
CREATE SEQUENCE status_id_seq;

CREATE OR REPLACE TRIGGER status_id_trig
BEFORE INSERT ON vehicle_status
FOR EACH ROW
BEGIN
	SELECT status_id_seq.NEXTVAL
	INTO :NEW.status_id
	FROM dual;
END;
/


--auto increment for the driver_employment_types table PK.
CREATE SEQUENCE type_id_seq;

CREATE OR REPLACE TRIGGER type_id_trig
BEFORE INSERT ON driver_employment_types
FOR EACH ROW
BEGIN
	SELECT type_id_seq.NEXTVAL
	INTO :NEW.type_id
	FROM dual;
END;
/


--auto increment for the vehicle_owners table PK.
CREATE SEQUENCE owner_id_seq;

CREATE OR REPLACE TRIGGER owner_id_trig
BEFORE INSERT ON vehicle_owners
FOR EACH ROW
BEGIN
	SELECT owner_id_seq.NEXTVAL
	INTO :NEW.owner_id
	FROM dual;
END;
/


--auto increment for the client_types table PK.
CREATE SEQUENCE client_id_seq;

CREATE OR REPLACE TRIGGER client_id_trig
BEFORE INSERT ON client_types
FOR EACH ROW
BEGIN
	SELECT client_id_seq.NEXTVAL
	INTO :NEW.type_id
	FROM dual;
END;
/


--auto increment for the booking_types table PK.
CREATE SEQUENCE booking_id_seq;

CREATE OR REPLACE TRIGGER booking_type_id_trig
BEFORE INSERT ON booking_types
FOR EACH ROW
BEGIN
	SELECT booking_id_seq.NEXTVAL
	INTO :NEW.booking_type_id
	FROM dual;
END;
/

-- auto increment for outgoings table PK.
CREATE SEQUENCE outgoings_id_seq;

CREATE OR REPLACE TRIGGER outgoings_id_trig
BEFORE INSERT ON outgoings
FOR EACH ROW
BEGIN
	SELECT outgoings_id_seq.NEXTVAL
	INTO :NEW.payment_id
	FROM dual;
END;
/

--auto increment for the clients table PK.
CREATE SEQUENCE clients_id_seq;

CREATE OR REPLACE TRIGGER clients_id_trig
BEFORE INSERT ON clients
FOR EACH ROW
BEGIN
	SELECT clients_id_seq.NEXTVAL
	INTO :NEW.client_id
	FROM dual;
END;
/


--Auto increment for registration_number PK on vehicles table shouldn’t be done.


--auto increment for the drivers table PK.
CREATE SEQUENCE driver_id_seq;

CREATE OR REPLACE TRIGGER driver_id_trig
BEFORE INSERT ON drivers
FOR EACH ROW
BEGIN
	SELECT driver_id_seq.NEXTVAL
	INTO :NEW.driver_id
	FROM dual;
END;
/


--auto increment for the operators table PK.
CREATE SEQUENCE operator_id_seq;

CREATE OR REPLACE TRIGGER operator_id_trig
BEFORE INSERT ON operators
FOR EACH ROW
BEGIN
	SELECT operator_id_seq.NEXTVAL
	INTO :NEW.operator_id
	FROM dual;
END;
/


--auto increment for the payments table PK.
CREATE SEQUENCE payment_id_seq;

CREATE OR REPLACE TRIGGER payment_id_trig
BEFORE INSERT ON booking_payments
FOR EACH ROW
BEGIN
	SELECT payment_id_seq.NEXTVAL
	INTO :NEW.payment_id
	FROM dual;
END;
/


--auto increment for the bookings table PK.
CREATE SEQUENCE bookings_id_seq;

CREATE OR REPLACE TRIGGER bookings_id_trig
BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
	SELECT bookings_id_seq.NEXTVAL
	INTO :NEW.booking_id
	FROM dual;
END;
/


--auto increment for the revenue table PK. (NOT SURE IF WE SHOULD DO IT HERE TOO?)
CREATE SEQUENCE revenue_item_seq;

CREATE OR REPLACE TRIGGER revenue_item_trig
BEFORE INSERT ON revenue
FOR EACH ROW
BEGIN
	SELECT revenue_item_seq.NEXTVAL
	INTO :NEW.revenue_item
	FROM dual;
END;
/
