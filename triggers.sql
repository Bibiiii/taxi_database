-- CREATE OR REPLACE TRIGGER check_transaction_source
-- 	BEFORE INSERT OR UPDATE 
-- 	ON revenue
-- 	FOR EACH ROW
-- 	DECLARE 
-- 		doesExistBookings INT;
-- 		doesExistOutgoings INT;
-- 	BEGIN
-- 		SELECT COUNT(*) INTO doesExistBookings FROM booking_payments WHERE payment_id = :NEW.transaction_source;
-- 		SELECT COUNT(*) INTO doesExistOutgoings FROM outgoings WHERE payment_id = :NEW.transaction_source;
-- 		IF (doesExistBookings = 0 AND doesExistOutgoings = 0)
-- 			THEN RAISE_APPLICATION_ERROR(-20001, 'Transaction source not recorded in either the bookings or outgoings table.');
-- 		END IF;
-- 	END;
-- /

-- ^ not sure if we need this, the process will have now been automated. ^

CREATE OR REPLACE TRIGGER create_payment_on_booking
    AFTER INSERT
    ON bookings
    FOR EACH ROW
    DECLARE
        payment_id INT := :NEW.payment_id;
        client_id INT := :NEW.client_id;
        cost NUMBER := :NEW.cost;
		employment_type_id VARCHAR(45);
    BEGIN
        DBMS_OUTPUT.PUT_LINE('CREATING BOOKING PAYMENT');
        INSERT INTO booking_payments(payment_id, total_cost, payment_status_id, client_id) VALUES (payment_id, cost, 1, client_id);
        DBMS_OUTPUT.PUT_LINE('CREATING REVENUE TABLE ENTRY');
        INSERT INTO revenue(revenue_item, gross_profit, current_balance) VALUES (payment_id, cost, cost);
		SELECT employment_type_id INTO employment_type_id FROM drivers WHERE driver_id = :NEW.driver_id;
		IF employment_type_id < 2 THEN 
			DBMS_OUTPUT.PUT_LINE('DEDUCTING WAGE');
			INSERT INTO outgoings(payment_id, description, cost, payment_status) VALUES (payment_id + 1, 'wages', 0.1 * cost, 1);
		ELSE 
			DBMS_OUTPUT.PUT_LINE('NO WAGE TO DEDUCT');
		END IF;
    END;
/

CREATE OR REPLACE TRIGGER update_outgoings
	AFTER INSERT
	ON outgoings
	FOR EACH ROW
	DECLARE
        payment_id INT := :NEW.payment_id;
        cost NUMBER := :NEW.cost;
	BEGIN
        DBMS_OUTPUT.PUT_LINE('ADDING OUTGOING TO REVENUE TABLE.');
		INSERT INTO revenue (revenue_item, gross_profit, current_balance) VALUES (payment_id, - cost, - cost);
	END;
/

CREATE OR REPLACE TRIGGER update_balance
    BEFORE INSERT
    ON REVENUE
    FOR EACH ROW
    DECLARE
        current_balance NUMBER;
    BEGIN
        SELECT current_balance INTO current_balance FROM revenue WHERE revenue_item = (SELECT MAX(revenue_item) FROM revenue);
        :NEW.current_balance := :NEW.gross_profit + current_balance;
        DBMS_OUTPUT.PUT_LINE('REVENUE TABLE ENTRY CREATED');
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