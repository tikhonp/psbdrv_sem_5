-- +goose Up
-- +goose StatementBegin
CREATE TABLE public.customer (
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    contract_data TEXT
);

CREATE TYPE public.order_state AS ENUM (
    'created', 
    'approved', 
    'producing',
    'waiting_for_delivery', 
    'delivery', 
    'completed',
    'canceled'
);

CREATE TYPE public.quantity_unit as ENUM (
    'ton'
);

CREATE TABLE public.order (
    id INTEGER PRIMARY KEY NOT NULL,
    date DATE NOT NULL,
    tech_spec_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    state public.order_state NOT NULL,
    quantity DECIMAL(10, 2) NOT NULL,
    quantity_unit public.quantity_unit NOT NULL
);

CREATE TABLE public.tech_spec (
    id INTEGER PRIMARY KEY NOT NULL,
    quality_id INTEGER NOT NULL,
    product_type_id INTEGER NOT NULL
);

CREATE TABLE public.quality (
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE public.product_type (
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE public.customer;
DROP TABLE public.order;
DROP TABLE public.tech_spec;
DROP TABLE public.quality;
DROP TABLE public.product_type;
DROP TYPE public.order_state;
DROP TYPE public.quantity_unit;
-- +goose StatementEnd
