-- COUNT
-- общее количество заказов в каждом состоянии по всем строкам
SELECT 
    id AS order_id,
    state,
    COUNT(*) OVER (PARTITION BY state) AS orders_count_per_state
FROM "order";
call create_order(1, 1, 100, 'ton')


-- SUM
-- количество заказанных тонн продукта для каждого состояния
SELECT 
    id AS order_id,
    state,
    SUM(quantity) OVER (PARTITION BY state) AS total_quantity_per_state
FROM "order";

-- AVERAGE (AVG)
-- среднее количество заказов для каждого типа состояния
SELECT 
    id AS order_id,
    state,
    AVG(quantity) OVER (PARTITION BY state) AS avg_quantity_per_state
FROM "order";

-- MAX
-- максимальное количество заказов для каждого клиента
SELECT 
    id AS order_id,
    customer_id,
    MAX(quantity) OVER (PARTITION BY customer_id) AS max_quantity_per_customer
FROM "order";

-- MIN
-- минимальное количество заказов для каждого состояния
SELECT 
    id AS order_id,
    state,
    MIN(quantity) OVER (PARTITION BY state) AS min_quantity_per_state
FROM "order";

-- ROW_NUMBER
-- каждому заказу порядковый номер в рамках каждого клиента
SELECT 
    id AS order_id,
    customer_id,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY date) AS row_number_per_customer
FROM "order";

-- RANK
-- Присваиваем каждому заказу ранг по количеству, учитывая равенство значений, для каждого клиента
SELECT
    id AS order_id,
    customer_id,
    RANK() OVER (ORDER BY state) AS rank_per_customer
FROM "order";


-- DENSE_RANK
-- Присваиваем плотный ранг (без пропусков) каждому заказу по количеству для каждого клиента.
SELECT
    id AS order_id,
    customer_id,
    DENSE_RANK() OVER (ORDER BY state) AS rank_per_customer
FROM "order";


-- NTILE
-- Делим заказы каждого клиента на 4 равные группы (если возможно).
SELECT 
    id AS order_id,
    customer_id,
    NTILE(4) OVER (PARTITION BY customer_id ORDER BY quantity) AS ntile_per_customer
FROM "order";

-- LAG
-- Для каждого заказа выводим количество тонн предыдущего заказа для данного клиента.
SELECT 
    id AS order_id,
    customer_id,
    quantity,
    LAG(quantity) OVER (PARTITION BY customer_id ORDER BY date) AS previous_quantity
FROM "order";

-- LEAD
SELECT 
    id AS order_id,
    customer_id,
    quantity,
    LEAD(quantity) OVER (PARTITION BY customer_id ORDER BY date) AS previous_quantity
FROM "order";


