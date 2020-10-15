SET TIMING ON;
INSERT INTO addresses(address_id, line_1, line_2, city, postcode) VALUES (1, '64', 'Zoo Lane', 'London', 'SW2 2FA');

INSERT INTO driver_employment_types(type_id, description) VALUES (1, 'percent_cut');
INSERT INTO driver_employment_types(type_id, description) VALUES (2, 'fixed_salary');

INSERT INTO shift_times(shift_time_id, start_time, end_time) VALUES(1, '00:00', '08:00');
INSERT INTO shift_times(shift_time_id, start_time, end_time) VALUES(2, '08:00', '16:00');
INSERT INTO shift_times(shift_time_id, start_time, end_time) VALUES(3, '16:00', '24:00');

INSERT INTO vehicle_owners(owner_id, first_name, last_name, tel, email, address_id) VALUES (1, 'Joe', 'Bloggs', '01212345', 'Joe@Bloggs.net', 1);


INSERT INTO drivers(driver_id, first_name, last_name, tel, email, date_of_join, address_id, shift_time_id, employment_type) VALUES (1, 'Liam', 'Radley', '01234', 'a.turing@taxico.com', '01-JAN-2019', 1, 1, 1);

INSERT INTO operators(operator_id, first_name, last_name, tel, email, call_count, date_of_join, address_id, shift_time_id) VALUES (1, 'Ada', 'Lovelace', '01111', 'a.lovelace@taxico.com', 1, '01-JAN-2018', 1, 1);

INSERT INTO client_types(type_id, description) VALUES (1, 'corporate');
INSERT INTO client_types(type_id, description) VALUES (2, 'private');

INSERT INTO clients(client_id, first_name, last_name, tel, email, address_id, client_type) VALUES (1, 'Thomas', 'Watson', '019543', 'T.Watson@taxico.com', 1, 1);

INSERT INTO vehicle_status(status_id, description) VALUES (1, 'roadworthy');
INSERT INTO vehicle_status(status_id, description) VALUES (2, 'in_for_service');
INSERT INTO vehicle_status(status_id, description) VALUES (3, 'written_off');

INSERT INTO vehicles(registration_number, last_mot, status_id, owner_id) VALUES ('EA12 DFG', '08-SEP-2020', 1, 1);

INSERT INTO payment_status(payment_status_id, description) VALUES (1, 'paid');
INSERT INTO booking_types(booking_type_id, description) VALUES (1, 'One-off');
INSERT INTO bookings(booking_id, location_from, location_to, booking_time, call_received, operator_id, driver_id, client_id, payment_id, booking_type_id) VALUES (1, 'Home', 'Work', TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), 1, 1, 1, 1, 1);
SET TIMING OFF;