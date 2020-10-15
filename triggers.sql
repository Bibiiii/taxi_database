
CREATE OR REPLACE TRIGGER check_transaction_source
	BEFORE INSERT OR UPDATE 
	ON revenue
	FOR EACH ROW
	DECLARE 
		doesExistBookings INT;
		doesExistOutgoings INT;
	BEGIN
		SELECT COUNT(*) INTO doesExistBookings FROM booking_payments WHERE payment_id = :NEW.transaction_source;
		SELECT COUNT(*) INTO doesExistOutgoings FROM outgoings WHERE payment_id = :NEW.transaction_source;
		IF (doesExistBookings = 0 AND doesExistOutgoings = 0)
			THEN RAISE_APPLICATION_ERROR(-20001, 'Transaction source not recorded in either the bookings or outgoings table.');
		END IF;
	END;
/

CREATE OR REPLACE TRIGGER create_payment_on_booking
    AFTER INSERT
    ON bookings
    FOR EACH ROW
    BEGIN
        DBMS_OUTPUT.PUT_LINE('CREATING BOOKING PAYMENT');
        INSERT INTO booking_payments(payment_id, total_cost, payment_status_id, client_id) VALUES (:NEW.payment_id, 20, 1, :NEW.client_id);
    END;
/

-- CREATE OR REPLACE TRIGGER update_balance_booking
-- 	AFTER INSERT 
-- 	ON booking_payments
-- 	FOR EACH ROW
-- 	DECLARE 
-- 		amount_earned NUMBER(10,4) := :NEW.total_cost;
-- 		payment_id INT := :NEW.payment_id;
-- 		transaction_no INT;
-- 		current_balance NUMBER(10,4);
-- 		employment_type VARCHAR(45);
-- 		percent_cut NUMBER(10,4);
-- 		driver_id INT;
-- 	BEGIN
-- 		SELECT driver_id INTO driver_id FROM bookings where payment_id = payment_id;
-- 		SELECT employment_type INTO employment_type FROM drivers where driver_id = driver_id;
-- 		SELECT MAX(revenue_item) INTO transaction_no FROM revenue; 
-- 		SELECT current_balance INTO current_balance FROM revenue WHERE revenue_item = transaction_no;
-- 		INSERT INTO revenue (gross_profit, transaction_source, current_balance) VALUES (amount_earned, transaction_no, current_balance + amount_earned);
-- 		IF (employment_type = 'percent_cut')
-- 			THEN
-- 			percent_cut := 0.1;
--             DBMS_OUTPUT.PUT_LINE('ADDING IN COMMISSION TO OUTGOINGS');
-- 			INSERT INTO outgoings(description, amount, payment_status) VALUES ('wages', amount_earned * percent_cut, 1);
-- 		END IF;
-- 	END;
-- /

CREATE OR REPLACE TRIGGER update_outgoings
	BEFORE INSERT
	ON outgoings
	FOR EACH ROW
	DECLARE
		amount_spent NUMBER(10,4) := :NEW.amount;
		payment_id INT := :NEW.payment_id;
		transaction_no INT;
		current_balance NUMBER(10,4);
	BEGIN
		SELECT MAX(revenue_item) INTO transaction_no FROM revenue;
		SELECT current_balance INTO current_balance FROM revenue where revenue_item = transaction_no;
        DBMS_OUTPUT.PUT_LINE('ADDING OUTGOING TO REVENUE TABLE.');
		INSERT INTO revenue (gross_profit, transaction_source, current_balance) VALUES (-amount_spent, payment_id, current_balance - amount_spent);
	END;
/


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