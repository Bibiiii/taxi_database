-- CREATE DATABASE taxico;

-- FLAT_RATE CONSTANT NUMBER(1) := 1;
-- PERCENT_CUT CONSTANT NUMBER(1) := 2;

-- SUBTYPE PAY_TYPE IS BINARY_INTEGER RANGE 1..2;

DROP TABLE payments;
DROP TABLE bookings;
DROP TABLE clients;
DROP TABLE frequencies;
DROP TABLE operators;
DROP TABLE cars;
DROP TABLE drivers;


CREATE TABLE drivers(
    id INTEGER PRIMARY KEY,
    driver_name VARCHAR(50) NOT NULL UNIQUE,
    driver_address VARCHAR(100) NOT NULL,
    tel VARCHAR(12) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    start_of_employment DATE NOT NULL,
    pay_type VARCHAR(12) CHECK( pay_type IN ('flat rate', 'percent cut'))
    );

CREATE TABLE cars(
    registration VARCHAR(12) PRIMARY KEY,
    owner INTEGER ,
    car_status VARCHAR(14) CHECK( car_status IN ('roadworthy', 'in_for_service', 'written_off')),
    last_MOT_test DATE NOT NULL,
    CONSTRAINT owner_fk FOREIGN KEY (owner) REFERENCES drivers (id)
);

CREATE TABLE operators( 
    id INTEGER PRIMARY KEY,
    operator_name VARCHAR(50) NOT NULL UNIQUE,
    operator_address VARCHAR(100) NOT NULL,
    tel VARCHAR(12) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    start_of_employment DATE NOT NULL,
    number_of_calls INTEGER DEFAULT ON NULL 0 CHECK (number_of_calls >= 0),
    CONSTRAINT num_operators CHECK (id <= 8)
);

CREATE TABLE frequencies( -- NOT HAPPY WITH HOW THIS IS, WOULD PREFER TO HAVE AS USER DEFINED TYPE.
    id int PRIMARY KEY,
    frequency VARCHAR(20)
);


CREATE TABLE clients(
    client_id INTEGER PRIMARY KEY,
    client_type VARCHAR(9) CHECK (client_type IN ('corporate', 'private')),
    name VARCHAR(50) NOT NULL,
    frequency INTEGER NOT NULL,
    time_picked_up TIMESTAMP NOT NULL,
    cost_per_trip NUMBER NOT NULL CHECK (cost_per_trip >= 0),
    CONSTRAINT freq_cnst FOREIGN KEY (frequency) REFERENCES frequencies (id)
);

CREATE TABLE bookings (
    booking_id INTEGER PRIMARY KEY,
    call_taken_by INTEGER NOT NULL,
    picked_up_by INTEGER NOT NULL,
    time_called TIMESTAMP NOT NULL,
    time_picked_up TIMESTAMP NOT NULL,
    time_dropped_off TIMESTAMP NOT NULL,
    picked_up_from VARCHAR(50) NOT NULL,
    dropped_at VARCHAR(50) NOT NULL,
    CONSTRAINT operator_fk FOREIGN KEY (call_taken_by) REFERENCES operators (id),
    CONSTRAINT driver_fk FOREIGN KEY (picked_up_by) REFERENCES drivers (id)
);

CREATE TABLE payments (
payment_id INTEGER PRIMARY KEY,
description VARCHAR(50) NOT NULL,
cost NUMBER NOT NULL CHECK (cost <> 0.00),
paid SMALLINT DEFAULT ON NULL 0
);

-- CREATE OR REPLACE TRIGGER payment_id_valid
--     BEFORE
--     INSERT OR UPDATE 
--     ON PAYMENTS
-- BEGIN
--     IF (NOT EXISTS (SELECT booking_id FROM BOOKINGS WHERE booking_id = NEW.payment_id) AND NOT EXISTS(SELECT client_id FROM CLIENTS WHERE client_id = NEW.payment_id))
--         RAISE_APPLICATION_ERROR(-408, "PAYMENT ID IS INVALID.");
-- END;
-- /

-- CREATE OR REPLACE TRIGGER TEST
--     BEFORE
--     INSERT OR UPDATE
--     ON DRIVERS
-- BEGIN
-- DBMS.PUT.PRINTLN("T R I G G E R E D")
-- END;
-- /