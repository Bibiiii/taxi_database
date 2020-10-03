CREATE TABLE "addresses" (
	"address_id" INT NOT NULL,
	"line_1" VARCHAR2(45) NOT NULL,
	"line_2" VARCHAR2(45),
	"city" VARCHAR2(45) NOT NULL,
	"postcode" VARCHAR2(45) NOT NULL,
	constraint ADDRESSES_PK PRIMARY KEY ("address_id"));


/
CREATE TABLE "clients" (
	"client_id" INT NOT NULL,
	"first_name" VARCHAR2(45) NOT NULL,
	"last_name" VARCHAR2(45) NOT NULL,
	"tel" VARCHAR2(45) NOT NULL,
	"email" VARCHAR2(45) NOT NULL,
	"address_id" INT NOT NULL,
	"client_type" INT NOT NULL,
	constraint CLIENTS_PK PRIMARY KEY ("client_id"));


/
CREATE TABLE "bookings" (
	"booking_id" INT NOT NULL,
	"location_from" VARCHAR2(45) NOT NULL,
	"location_to" VARCHAR2(45) NOT NULL,
	"booking_time" TIMESTAMP NOT NULL,
	"call_received" TIMESTAMP NOT NULL,
	"operator_id" INT NOT NULL,
	"driver_id" INT NOT NULL,
	"client_id" INT NOT NULL,
	"payment_id" INT NOT NULL,
	"booking_type_id" INT NOT NULL,
	constraint BOOKINGS_PK PRIMARY KEY ("booking_id"));


/
CREATE TABLE "drivers" (
	"driver_id" INT NOT NULL,
	"first_name" VARCHAR2(45) NOT NULL,
	"last_name" VARCHAR2(45) NOT NULL,
	"tel" VARCHAR2(45) NOT NULL,
	"email" VARCHAR2(45) NOT NULL,
	"date_of_join" DATE NOT NULL,
	"address_id" INT NOT NULL,
	"shift_time_id" INT NOT NULL,
	"employment_type" INT NOT NULL,
	constraint DRIVERS_PK PRIMARY KEY ("driver_id"));


/
CREATE TABLE "operators" (
	"operator_id" INT NOT NULL,
	"first_name" VARCHAR2(45) NOT NULL,
	"last_name" VARCHAR2(45) NOT NULL,
	"tel" VARCHAR2(45) NOT NULL,
	"email" VARCHAR2(45) NOT NULL,
	"call_count" INT NOT NULL,
	"date_of_join" DATE NOT NULL,
	"address_id" INT NOT NULL,
	"shift_time_id" INT NOT NULL,
	constraint OPERATORS_PK PRIMARY KEY ("operator_id"));


/
CREATE TABLE "payment_status" (
	"payment_status_id" INT NOT NULL,
	"description" VARCHAR2(45) NOT NULL,
	constraint PAYMENT_STATUS_PK PRIMARY KEY ("payment_status_id"));


/
CREATE TABLE "payments" (
	"payment_id" INT NOT NULL,
	"card_last_4" VARCHAR2(45) NOT NULL,
	"total_cost" INT NOT NULL,
	"payment_status_id" INT NOT NULL,
	"client_id" INT NOT NULL,
	constraint PAYMENTS_PK PRIMARY KEY ("payment_id"));


/
CREATE TABLE "shift_times" (
	"shift_time_id" INT NOT NULL,
	"start_time" TIMESTAMP NOT NULL,
	"end_time" TIMESTAMP NOT NULL,
	constraint SHIFT_TIMES_PK PRIMARY KEY ("shift_time_id"));


/
CREATE TABLE "shifts" (
	"shift_id" INT NOT NULL,
	"shift_time_id" INT NOT NULL,
	"driver_id" INT NOT NULL,
	"operator_id" INT NOT NULL,
	constraint SHIFTS_PK PRIMARY KEY ("shift_id"));


/
CREATE TABLE "vehicle_owners" (
	"owner_id" INT NOT NULL,
	"first_name" VARCHAR2(45) NOT NULL,
	"last_name" VARCHAR2(45) NOT NULL,
	"tel" VARCHAR2(45) NOT NULL,
	"email" VARCHAR2(45) NOT NULL,
	"address_id" INT NOT NULL,
	constraint VEHICLE_OWNERS_PK PRIMARY KEY ("owner_id"));


/
CREATE TABLE "vehicle_status" (
	"status_id" INT NOT NULL,
	"description" VARCHAR2(45) NOT NULL,
	constraint VEHICLE_STATUS_PK PRIMARY KEY ("status_id"));


/
CREATE TABLE "vehicles" (
	"registration_number" VARCHAR2(45) NOT NULL,
	"last_mot" TIMESTAMP NOT NULL,
	"status_id" INT NOT NULL,
	"owner_id" INT NOT NULL,
	constraint VEHICLES_PK PRIMARY KEY ("registration_number"));


/
CREATE TABLE "revenue" (
	"revenue_item" INT NOT NULL,
	"gross_profit" INT NOT NULL,
	"net_profit" INT NOT NULL,
	"booking_id" INT NOT NULL,
	constraint REVENUE_PK PRIMARY KEY ("revenue_item"));

CREATE sequence "REVENUE_REVENUE_ITEM_SEQ";

CREATE trigger "BI_REVENUE_REVENUE_ITEM"
  before insert on "revenue"
  for each row
begin
  select "REVENUE_REVENUE_ITEM_SEQ".nextval into :NEW."revenue_item" from dual;
end;

/
CREATE TABLE "driver_employment_types" (
	"type_id" INT NOT NULL,
	"description" VARCHAR2(45) UNIQUE NOT NULL,
	constraint DRIVER_EMPLOYMENT_TYPES_PK PRIMARY KEY ("type_id"));


/
CREATE TABLE "client_types" (
	"type_id" INT NOT NULL,
	"description" VARCHAR2(255) NOT NULL,
	constraint CLIENT_TYPES_PK PRIMARY KEY ("type_id"));

CREATE sequence "CLIENT_TYPES_TYPE_ID_SEQ";

CREATE trigger "BI_CLIENT_TYPES_TYPE_ID"
  before insert on "client_types"
  for each row
begin
  select "CLIENT_TYPES_TYPE_ID_SEQ".nextval into :NEW."type_id" from dual;
end;

/
CREATE TABLE "booking_types" (
	"booking_type_id" INT NOT NULL,
	"description" VARCHAR2(255) UNIQUE NOT NULL,
	constraint BOOKING_TYPES_PK PRIMARY KEY ("booking_type_id"));

CREATE sequence "BOOKING_TYPES_BOOKING_TYPE_ID_SEQ";

CREATE trigger "BI_BOOKING_TYPES_BOOKING_TYPE_ID"
  before insert on "booking_types"
  for each row
begin
  select "BOOKING_TYPES_BOOKING_TYPE_ID_SEQ".nextval into :NEW."booking_type_id" from dual;
end;

/

ALTER TABLE "clients" ADD CONSTRAINT "clients_fk0" FOREIGN KEY ("address_id") REFERENCES "addresses"("address_id");
ALTER TABLE "clients" ADD CONSTRAINT "clients_fk1" FOREIGN KEY ("client_type") REFERENCES "client_types"("type_id");

ALTER TABLE "bookings" ADD CONSTRAINT "bookings_fk0" FOREIGN KEY ("operator_id") REFERENCES "operators"("operator_id");
ALTER TABLE "bookings" ADD CONSTRAINT "bookings_fk1" FOREIGN KEY ("driver_id") REFERENCES "drivers"("driver_id");
ALTER TABLE "bookings" ADD CONSTRAINT "bookings_fk2" FOREIGN KEY ("client_id") REFERENCES "clients"("client_id");
ALTER TABLE "bookings" ADD CONSTRAINT "bookings_fk3" FOREIGN KEY ("payment_id") REFERENCES "payments"("payment_id");
ALTER TABLE "bookings" ADD CONSTRAINT "bookings_fk4" FOREIGN KEY ("booking_type_id") REFERENCES "booking_types"("booking_type_id");

ALTER TABLE "drivers" ADD CONSTRAINT "drivers_fk0" FOREIGN KEY ("shift_time_id") REFERENCES "shift_times"("shift_time_id");
ALTER TABLE "drivers" ADD CONSTRAINT "drivers_fk1" FOREIGN KEY ("employment_type") REFERENCES "driver_employment_types"("type_id");

ALTER TABLE "operators" ADD CONSTRAINT "operators_fk0" FOREIGN KEY ("address_id") REFERENCES "addresses"("address_id");
ALTER TABLE "operators" ADD CONSTRAINT "operators_fk1" FOREIGN KEY ("shift_time_id") REFERENCES "shift_times"("shift_time_id");


ALTER TABLE "payments" ADD CONSTRAINT "payments_fk0" FOREIGN KEY ("payment_status_id") REFERENCES "payment_status"("payment_status_id");
ALTER TABLE "payments" ADD CONSTRAINT "payments_fk1" FOREIGN KEY ("client_id") REFERENCES "clients"("client_id");


ALTER TABLE "shifts" ADD CONSTRAINT "shifts_fk0" FOREIGN KEY ("shift_time_id") REFERENCES "shift_times"("shift_time_id");
ALTER TABLE "shifts" ADD CONSTRAINT "shifts_fk1" FOREIGN KEY ("driver_id") REFERENCES "drivers"("driver_id");
ALTER TABLE "shifts" ADD CONSTRAINT "shifts_fk2" FOREIGN KEY ("operator_id") REFERENCES "operators"("operator_id");

ALTER TABLE "vehicle_owners" ADD CONSTRAINT "vehicle_owners_fk0" FOREIGN KEY ("address_id") REFERENCES "addresses"("address_id");


ALTER TABLE "vehicles" ADD CONSTRAINT "vehicles_fk0" FOREIGN KEY ("status_id") REFERENCES "vehicle_status"("status_id");
ALTER TABLE "vehicles" ADD CONSTRAINT "vehicles_fk1" FOREIGN KEY ("owner_id") REFERENCES "vehicle_owners"("owner_id");

ALTER TABLE "revenue" ADD CONSTRAINT "revenue_fk0" FOREIGN KEY ("booking_id") REFERENCES "bookings"("booking_id");



