SET TIMING ON;

@addressPopulation.sql

INSERT INTO driver_employment_types(description) VALUES ('percent_cut');
INSERT INTO driver_employment_types(description) VALUES ('fixed_salary');

INSERT INTO shift_times(start_time, end_time) VALUES('00:00', '08:00');
INSERT INTO shift_times(start_time, end_time) VALUES('08:00', '16:00');
INSERT INTO shift_times(start_time, end_time) VALUES('16:00', '24:00');

-- address id 1-1000
@vehicleOwnerPopulation.sql

-- address id 1001-2000
@driverPopulation.sql

-- address id 2001-2008
@operatorPopulation.sql

INSERT INTO client_types(description) VALUES ('corporate');
INSERT INTO client_types(description) VALUES ('private');

-- adderss id 2009-5000
@clientPopulation.sql

INSERT INTO vehicle_status(description) VALUES ('roadworthy');
INSERT INTO vehicle_status(description) VALUES ('in_for_service');
INSERT INTO vehicle_status(description) VALUES ('written_off');

@vehiclePopulation.sql

ALTER TRIGGER update_balance DISABLE;
INSERT INTO revenue(gross_profit, current_balance) VALUES (0, 0);
ALTER TRIGGER update_balance ENABLE; 

INSERT INTO payment_status(description) VALUES ('pending');
INSERT INTO payment_status(description) VALUES ('paid');
INSERT INTO payment_status(description) VALUES ('declined');

INSERT INTO booking_types(description) VALUES ('one-off');
INSERT INTO booking_types(description) VALUES ('weekly');
INSERT INTO booking_types(description) VALUES ('daily');
INSERT INTO booking_types(description) VALUES ('monthly');

@bookingPopulation.sql

INSERT INTO outgoings(description, cost, payment_status) VALUES('gas bill', 20, 1);

SET TIMING OFF;