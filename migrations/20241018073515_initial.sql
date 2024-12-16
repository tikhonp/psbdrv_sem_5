-- +goose Up
-- +goose StatementBegin
-- Table: Сервисный центр
CREATE TABLE service_center (
    id_order SERIAL PRIMARY KEY,
    customer_name VARCHAR(255),
    operator_name VARCHAR(255),
    order_date DATE
);

-- Table: ТЗ (Technical Assignment)
CREATE TABLE technical_assignment (
    id_tz SERIAL PRIMARY KEY,
    product_name VARCHAR(255),
    required_quantity INT,
    due_date DATE,
    required_quality VARCHAR(255),
    id_order INT REFERENCES service_center(id_order) ON DELETE CASCADE
);

-- Table: ГОСТ и Нормы (Standards)
CREATE TABLE gost_norms (
    id_gost SERIAL PRIMARY KEY,
    gost_name VARCHAR(255),
    legal_features TEXT,
    tpi VARCHAR(255)
);

-- Table: Производственный процесс (Production Process)
CREATE TABLE production_process (
    id_process SERIAL PRIMARY KEY,
    id_gost INT REFERENCES gost_norms(id_gost) ON DELETE CASCADE,
    semi_product_name VARCHAR(255),
    quantity INT,
    quality VARCHAR(255),
    workshop_name VARCHAR(255)
);

-- Table: Личные данные (Personal Data)
CREATE TABLE personal_data (
    id_personal SERIAL PRIMARY KEY,
    position VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(255),
    address TEXT
);

-- Table: Сырьё (Raw Material)
CREATE TABLE raw_material (
    id_raw SERIAL PRIMARY KEY,
    name VARCHAR(255),
    availability BOOLEAN,
    quantity INT,
    storage_duration INT, -- duration in days
    quality VARCHAR(255)
);

-- Table: Инструменты (Tools)
CREATE TABLE tools (
    id_tool SERIAL PRIMARY KEY,
    name VARCHAR(255),
    quantity INT,
    "current_user" VARCHAR(255), -- References can be optional
    condition VARCHAR(255)
);

-- Table: Персонал (Personnel)
CREATE TABLE personnel (
    id_personnel SERIAL PRIMARY KEY,
    employee_name VARCHAR(255),
    id_process INT REFERENCES production_process(id_process) ON DELETE SET NULL,
    id_raw INT,
    id_tool INT,
    id_tz INT REFERENCES technical_assignment(id_tz) ON DELETE CASCADE,
    FOREIGN KEY (id_raw) REFERENCES raw_material(id_raw) ON DELETE SET NULL,
    FOREIGN KEY (id_tool) REFERENCES tools(id_tool) ON DELETE SET NULL
);

-- Table: Продукт (Product)
CREATE TABLE product (
    id_product SERIAL PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255),
    quantity INT,
    quality VARCHAR(255),
    production_date DATE,
    id_tool INT REFERENCES tools(id_tool) ON DELETE CASCADE
);

-- Table: Брак (Defects)
CREATE TABLE defects (
    id_defect SERIAL PRIMARY KEY,
    stage VARCHAR(255),
    quantity INT,
    defect_percentage_stat FLOAT,
    id_tool INT REFERENCES tools(id_tool) ON DELETE CASCADE
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE defects;
DROP TABLE product;
DROP TABLE tools;
DROP TABLE raw_material;
DROP TABLE personnel;
DROP TABLE personal_data;
DROP TABLE production_process;
DROP TABLE gost_norms;
DROP TABLE technical_assignment;
DROP TABLE service_center;
-- +goose StatementEnd
