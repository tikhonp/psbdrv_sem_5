-- COUNT
-- Посчитать количество сотрудников в каждом производственном процессе (с накопительным итогом)
SELECT 
    employee_name,
    id_process,
    COUNT(employee_name) OVER (PARTITION BY id_process) AS employee_count
FROM personnel;

-- SUM
-- Вычислить накопительное количество инструментов для каждого состояния (например, "в использовании")
SELECT 
    name AS tool_name,
    condition,
    SUM(quantity) OVER (PARTITION BY condition ORDER BY name) AS cumulative_quantity
FROM tools;

-- AVERAGE (AVG)
-- Рассчитать среднее количество продукции для каждого типа продукта
SELECT
    type,
    quantity,
    avg(quantity) OVER (PARTITION BY type) AS average_quantity
FROM product;

-- MAX
-- Определить максимальное количество сырья для каждого типа срока хранения (storage_time)
SELECT
    name AS material_name,
    storage_duration,
    MAX(quantity) OVER (PARTITION BY storage_duration) AS max_quantity
FROM raw_material;

-- MIN
-- Определить минимальное качество продукции в каждой категории типа продукции
SELECT 
    type,
    quality,
    MIN(quality) OVER (PARTITION BY type) AS min_quality
FROM product;

-- ROW_NUMBER
-- Пронумеровать сотрудников в каждом производственном процессе
SELECT 
    id_process,
    employee_name,
    ROW_NUMBER() OVER (PARTITION BY id_process ORDER BY employee_name) AS row_number
FROM personnel;

-- RANK
-- Присвоить ранг сырью на основе количества (в порядке убывания)
SELECT 
    name AS material_name,
    quantity,
    RANK() OVER (ORDER BY quantity DESC) AS rank
FROM raw_material;

-- DENSE_RANK
-- Присвоить плотный ранг инструментам по состоянию и количеству
SELECT 
    name AS tool_name,
    condition,
    quantity,
    DENSE_RANK() OVER (PARTITION BY condition ORDER BY quantity DESC) AS dense_rank
FROM tools;

-- NTILE
-- Разделить заказы на 4 равные группы на основе даты заказа
SELECT 
    id_order,
    customer_name,
    order_date,
    NTILE(4) OVER (ORDER BY order_date) AS group_number
FROM service_center;

-- LAG
-- Найти предыдущее количество для каждого сырья
SELECT 
    name AS material_name,
    quantity,
    LAG(quantity) OVER (PARTITION BY name ORDER BY id_raw) AS previous_quantity
FROM raw_material;
