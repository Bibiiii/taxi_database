SET TIMING ON;

@addressPopulation.sql

-- 19.812 seconds --

INSERT INTO driver_employment_types(description) VALUES ('percent_cut');
INSERT INTO driver_employment_types(description) VALUES ('fixed_salary');

INSERT INTO shift_times(start_time, end_time) VALUES('00:00', '08:00');
INSERT INTO shift_times(start_time, end_time) VALUES('08:00', '16:00');
INSERT INTO shift_times(start_time, end_time) VALUES('16:00', '24:00');

-- 0.088 seconds --

-- address id 1-1000
@veichleOwnerPopulation.sql

-- 3.915 seconds --

-- address id 1001-2000
@driverPopulation.sql

-- address id 2001-2008
@operatorPopulation.sql

INSERT INTO client_types(description) VALUES ('corporate');
INSERT INTO client_types(description) VALUES ('private');

-- adderss id 2009-3008
@clientPopulation.sql

INSERT INTO vehicle_status(description) VALUES ('roadworthy');
INSERT INTO vehicle_status(description) VALUES ('in_for_service');
INSERT INTO vehicle_status(description) VALUES ('written_off');

@vehiclePopulation.sql

ALTER TRIGGER update_balance DISABLE;
INSERT INTO revenue(gross_profit, current_balance) VALUES (0.0, 0.0);
ALTER TRIGGER update_balance ENABLE; 

INSERT INTO payment_status(description) VALUES ('pending');
INSERT INTO payment_status(description) VALUES ('paid');
INSERT INTO payment_status(description) VALUES ('declined');

INSERT INTO booking_types(description) VALUES ('one-off');
INSERT INTO booking_types(description) VALUES ('weekly');
INSERT INTO booking_types(description) VALUES ('daily');
INSERT INTO booking_types(description) VALUES ('monthly');

INSERT INTO bookings(location_from, location_to, booking_time, call_received, cost, operator_id, driver_id, client_id, payment_id, booking_type_id) VALUES ('Home', 'Work', TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), 25, 1, 1, 1, 1, 1);
INSERT INTO bookings(location_from, location_to, booking_time, call_received, cost, operator_id, driver_id, client_id, payment_id, booking_type_id) VALUES ('Home', 'Work', TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), 25, 1, 2, 1, 2, 1);

INSERT INTO outgoings(description, cost, payment_status) VALUES('gas bill', 20, 1);

SET TIMING OFF;