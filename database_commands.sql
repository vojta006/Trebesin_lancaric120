-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public.customer | type: TABLE --
-- DROP TABLE IF EXISTS public.customer CASCADE;
CREATE TABLE public.customer (
	customer_id integer NOT NULL,
	first_name varchar(50),
	last_name varchar(100),
	email_address varchar(100),
	login_name varchar(50),
	login_password char(50),
	phone_number char(12),
	CONSTRAINT customer_id PRIMARY KEY (customer_id)

);
-- ddl-end --
ALTER TABLE public.customer OWNER TO postgres;
-- ddl-end --

-- object: public.payments | type: TABLE --
-- DROP TABLE IF EXISTS public.payments CASCADE;
CREATE TABLE public.payments (
	payment_id integer NOT NULL,
	payment_date date,
	payment_price integer,
	order_id_orders integer,
	payment_code smallint NOT NULL,
	payment_id_payment_code smallint,
	CONSTRAINT payments_pk PRIMARY KEY (payment_id)

);
-- ddl-end --
ALTER TABLE public.payments OWNER TO postgres;
-- ddl-end --

-- object: public.products | type: TABLE --
-- DROP TABLE IF EXISTS public.products CASCADE;
CREATE TABLE public.products (
	product_id integer NOT NULL,
	product_description text,
	product_name varchar(100),
	CONSTRAINT product_id PRIMARY KEY (product_id)

);
-- ddl-end --
ALTER TABLE public.products OWNER TO postgres;
-- ddl-end --

-- object: public.orders | type: TABLE --
-- DROP TABLE IF EXISTS public.orders CASCADE;
CREATE TABLE public.orders (
	order_id integer NOT NULL,
	order_status_code smallint NOT NULL,
	order_details text,
	customer_id_customer integer,
	price integer,
	status_code_id_status_codes smallint,
	CONSTRAINT oder_id PRIMARY KEY (order_id)

);
-- ddl-end --
ALTER TABLE public.orders OWNER TO postgres;
-- ddl-end --

-- object: customer_fk | type: CONSTRAINT --
-- ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS customer_fk CASCADE;
ALTER TABLE public.orders ADD CONSTRAINT customer_fk FOREIGN KEY (customer_id_customer)
REFERENCES public.customer (customer_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.ordered_items | type: TABLE --
-- DROP TABLE IF EXISTS public.ordered_items CASCADE;
CREATE TABLE public.ordered_items (
	item_id integer NOT NULL,
	item_description text,
	item_quantity integer,
	order_id_orders integer,
	product_id_products integer,
	item_price integer,
	CONSTRAINT item_id PRIMARY KEY (item_id)

);
-- ddl-end --
ALTER TABLE public.ordered_items OWNER TO postgres;
-- ddl-end --

-- object: orders_fk | type: CONSTRAINT --
-- ALTER TABLE public.ordered_items DROP CONSTRAINT IF EXISTS orders_fk CASCADE;
ALTER TABLE public.ordered_items ADD CONSTRAINT orders_fk FOREIGN KEY (order_id_orders)
REFERENCES public.orders (order_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: products_fk | type: CONSTRAINT --
-- ALTER TABLE public.ordered_items DROP CONSTRAINT IF EXISTS products_fk CASCADE;
ALTER TABLE public.ordered_items ADD CONSTRAINT products_fk FOREIGN KEY (product_id_products)
REFERENCES public.products (product_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.address | type: TABLE --
-- DROP TABLE IF EXISTS public.address CASCADE;
CREATE TABLE public.address (
	address_id integer NOT NULL,
	street varchar(50),
	house_number varchar(10),
	orientation_number varchar(10),
	country varchar(3),
	city varchar(50),
	zip varchar(10),
	customer_id_customer integer,
	CONSTRAINT address_pk PRIMARY KEY (address_id)

);
-- ddl-end --
ALTER TABLE public.address OWNER TO postgres;
-- ddl-end --

-- object: customer_fk | type: CONSTRAINT --
-- ALTER TABLE public.address DROP CONSTRAINT IF EXISTS customer_fk CASCADE;
ALTER TABLE public.address ADD CONSTRAINT customer_fk FOREIGN KEY (customer_id_customer)
REFERENCES public.customer (customer_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: address_uq | type: CONSTRAINT --
-- ALTER TABLE public.address DROP CONSTRAINT IF EXISTS address_uq CASCADE;
ALTER TABLE public.address ADD CONSTRAINT address_uq UNIQUE (customer_id_customer);
-- ddl-end --

-- object: public.stock_items | type: TABLE --
-- DROP TABLE IF EXISTS public.stock_items CASCADE;
CREATE TABLE public.stock_items (
	item_id integer NOT NULL,
	item_description text,
	item_quantity integer,
	product_id_products integer,
	price integer,
	CONSTRAINT item_id PRIMARY KEY (item_id)

);
-- ddl-end --
ALTER TABLE public.stock_items OWNER TO postgres;
-- ddl-end --

-- object: products_fk | type: CONSTRAINT --
-- ALTER TABLE public.stock_items DROP CONSTRAINT IF EXISTS products_fk CASCADE;
ALTER TABLE public.stock_items ADD CONSTRAINT products_fk FOREIGN KEY (product_id_products)
REFERENCES public.products (product_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.status_codes | type: TABLE --
-- DROP TABLE IF EXISTS public.status_codes CASCADE;
CREATE TABLE public.status_codes (
	status_code_id smallint NOT NULL,
	status_code_description text,
	CONSTRAINT order_status_codes_pk PRIMARY KEY (status_code_id)

);
-- ddl-end --
ALTER TABLE public.status_codes OWNER TO postgres;
-- ddl-end --

-- object: status_codes_fk | type: CONSTRAINT --
-- ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS status_codes_fk CASCADE;
ALTER TABLE public.orders ADD CONSTRAINT status_codes_fk FOREIGN KEY (status_code_id_status_codes)
REFERENCES public.status_codes (status_code_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: orders_uq | type: CONSTRAINT --
-- ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS orders_uq CASCADE;
ALTER TABLE public.orders ADD CONSTRAINT orders_uq UNIQUE (status_code_id_status_codes);
-- ddl-end --

-- object: orders_fk | type: CONSTRAINT --
-- ALTER TABLE public.payments DROP CONSTRAINT IF EXISTS orders_fk CASCADE;
ALTER TABLE public.payments ADD CONSTRAINT orders_fk FOREIGN KEY (order_id_orders)
REFERENCES public.orders (order_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: payments_uq | type: CONSTRAINT --
-- ALTER TABLE public.payments DROP CONSTRAINT IF EXISTS payments_uq CASCADE;
ALTER TABLE public.payments ADD CONSTRAINT payments_uq UNIQUE (order_id_orders);
-- ddl-end --

-- object: public.payment_code | type: TABLE --
-- DROP TABLE IF EXISTS public.payment_code CASCADE;
CREATE TABLE public.payment_code (
	payment_id smallint NOT NULL,
	paymet_description text,
	CONSTRAINT payment_code_pk PRIMARY KEY (payment_id)

);
-- ddl-end --
ALTER TABLE public.payment_code OWNER TO postgres;
-- ddl-end --

-- object: payment_code_fk | type: CONSTRAINT --
-- ALTER TABLE public.payments DROP CONSTRAINT IF EXISTS payment_code_fk CASCADE;
ALTER TABLE public.payments ADD CONSTRAINT payment_code_fk FOREIGN KEY (payment_id_payment_code)
REFERENCES public.payment_code (payment_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


