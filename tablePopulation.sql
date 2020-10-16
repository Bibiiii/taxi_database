SET TIMING ON;
INSERT INTO addresses(line_1, line_2, city, postcode) VALUES ('64', 'Zoo Lane', 'London', 'SW2 2FA');

INSERT INTO driver_employment_types(description) VALUES ('percent_cut');
INSERT INTO driver_employment_types(description) VALUES ('fixed_salary');

INSERT INTO shift_times(start_time, end_time) VALUES('00:00', '08:00');
INSERT INTO shift_times(start_time, end_time) VALUES('08:00', '16:00');
INSERT INTO shift_times(start_time, end_time) VALUES('16:00', '24:00');

INSERT INTO vehicle_owners(first_name, last_name, tel, email, address_id) VALUES ('Joe', 'Bloggs', '01212345', 'Joe@Bloggs.net', 1);


INSERT INTO drivers(first_name, last_name, tel, email, date_of_join, address_id, shift_time_id, employment_type_id) VALUES ('Liam', 'Radley', '01234', 'l.radley@taxico.com', '01-JAN-2019', 1, 1, 1);
INSERT INTO drivers(first_name, last_name, tel, email, date_of_join, address_id, shift_time_id, employment_type_id) VALUES ('Bill', 'Gates', '01234', 'b.gates@taxico.com', '01-JAN-2019', 1, 1, 2);


INSERT INTO operators(first_name, last_name, tel, email, call_count, date_of_join, address_id, shift_time_id) VALUES ('Ada', 'Lovelace', '01111', 'a.lovelace@taxico.com', 1, '01-JAN-2018', 1, 1);

INSERT INTO client_types(description) VALUES ('corporate');
INSERT INTO client_types(description) VALUES ('private');

INSERT INTO clients(first_name, last_name, tel, email, address_id, client_type) VALUES ('Thomas', 'Watson', '019543', 'T.Watson@taxico.com', 1, 1);

INSERT INTO vehicle_status(description) VALUES ('roadworthy');
INSERT INTO vehicle_status(description) VALUES ('in_for_service');
INSERT INTO vehicle_status(description) VALUES ('written_off');

INSERT INTO vehicles(registration_number, last_mot, status_id, owner_id) VALUES ('EA12 DFG', '08-SEP-2020', 1, 1);

ALTER TRIGGER update_balance DISABLE;
INSERT INTO revenue(gross_profit, current_balance) VALUES (0.0, 0.0);
ALTER TRIGGER update_balance ENABLE; 
INSERT INTO payment_status(description) VALUES ('paid');

INSERT INTO booking_types(description) VALUES ('one-off');

INSERT INTO bookings(location_from, location_to, booking_time, call_received, cost, operator_id, driver_id, client_id, payment_id, booking_type_id) VALUES ('Home', 'Work', TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), 25, 1, 1, 1, 1, 1);
INSERT INTO bookings(location_from, location_to, booking_time, call_received, cost, operator_id, driver_id, client_id, payment_id, booking_type_id) VALUES ('Home', 'Work', TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), 25, 1, 2, 1, 2, 1);

INSERT INTO outgoings(description, cost, payment_status) VALUES('gas bill', 20, 1);

SET TIMING OFF;