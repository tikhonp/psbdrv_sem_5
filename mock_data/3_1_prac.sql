-- Операция проекции
-- Выбрать имена сотрудников из таблицы personal_data.
SELECT employee_name 
FROM personnel;

-- Операция селекции
-- Выбрать все заказы, сделанные после 01.01.2024.
SELECT *
FROM service_center
WHERE order_date > '2024-01-01';

-- Операции соединения
-- Найти сотрудников и названия производственных процессов, на которых они работают.
SELECT p.employee_name, pp.semi_product_name
FROM personnel p
JOIN production_process pp ON p.id_process = pp.id_process;

-- Операция объединения
-- Объединить названия инструментов и сырья.
SELECT name AS item_name
FROM tools
UNION
SELECT name AS item_name
FROM raw_material;

-- Операция пересечения
-- Найти совпадающие названия между таблицами tools и raw_material.
SELECT name
FROM tools
INTERSECT
SELECT name
FROM raw_material;

-- Операция разности
-- Найти инструменты, названия которых отсутствуют в сырье.
SELECT name
FROM tools
EXCEPT
SELECT name
FROM raw_material;

-- Операция группировки
-- Посчитать количество сотрудников на каждом производственном процессе.
SELECT id_process, COUNT(*) AS employee_count
FROM personnel
GROUP BY id_process;

-- Операция сортировки
-- Отсортировать заказы по дате в порядке убывания.
SELECT *
FROM service_center
ORDER BY order_date DESC;

-- Операция деления
-- Найти сотрудников, которые работают с каждым инструментом в таблице tools.
SELECT p.employee_name
FROM personnel p
WHERE NOT EXISTS (
    SELECT 1
    FROM tools t
    WHERE NOT EXISTS (
        SELECT 1
        FROM personnel p2
        WHERE p2.id_tool = t.id_tool AND p2.employee_name = p.employee_name
    )
);

