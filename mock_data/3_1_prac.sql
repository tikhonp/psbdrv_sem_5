-- Операция проекции
SELECT name, description
FROM customer;


-- Операция селекции
SELECT *
FROM "order"
WHERE quantity = 200;


-- Операции соединения
SELECT
    o.id AS order_id,
    o.date AS order_date,
    c.name AS customer_name,
    pt.id AS product_type_id
FROM "order" o
JOIN tech_spec ts ON o.tech_spec_id = ts.id
JOIN product_type pt ON ts.product_type_id = pt.id
JOIN customer c ON o.customer_id = c.id;


-- Операция объединения
SELECT *
FROM "order"
WHERE state = 'producing'
UNION
SELECT *
FROM "order"
WHERE state = 'waiting_for_delivery';


-- Операция пересечения
select o.date, c.name as customer_name
from "order" o
inner join public.customer c on c.id = o.customer_id
where o.quantity = 100
and exists(select * from "order" o where o.customer_id=c.id and o.quantity = 100);


-- Операция разности
SELECT *
FROM "order"
WHERE state = 'producing'
EXCEPT
SELECT *
FROM "order"
WHERE state = 'waiting_for_delivery';


-- Операция группировки
SELECT state, COUNT(*) AS order_count
FROM "order"
GROUP BY state;


-- Операция сортировки
SELECT *
FROM customer
ORDER BY name ASC;


-- Операция деления
WITH tech_spec_id_5 AS (
    INSERT INTO public.tech_spec (quality_id, product_type_id) 
    VALUES (
        (SELECT id FROM public.quality WHERE name = 'Высокое' LIMIT 1),
        (SELECT id FROM public.product_type WHERE name = 'Керамическая плитка' LIMIT 1)
    ) RETURNING id
)
INSERT INTO public."order" (date, tech_spec_id, customer_id, state, quantity, quantity_unit)
VALUES (
    '2024-01-05',
    (SELECT id FROM tech_spec_id_5),
    (SELECT id FROM public.customer WHERE name = 'Сызранский рудный завод' LIMIT 1),
    'producing',
    150,
    'ton'
);

SELECT c.id, c.name
FROM customer c
WHERE NOT EXISTS (
    SELECT pt.id
    FROM product_type pt
    WHERE NOT EXISTS (
        SELECT o.id
        FROM "order" o
        JOIN tech_spec ts ON o.tech_spec_id = ts.id
        WHERE o.customer_id = c.id AND ts.product_type_id = pt.id
    )
);

