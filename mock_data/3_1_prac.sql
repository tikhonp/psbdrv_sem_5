-- Операция проекции
SELECT position, phone_number
FROM personal_data;


-- Операция селекции
SELECT *
FROM raw_material
WHERE quantity > 300;


-- Операции соединения
SELECT personnel.employee_name, production_process.semi_product_name
FROM personnel
JOIN production_process ON personnel.id_process = production_process.id_process;


-- Операция объединения
SELECT name AS item_name
FROM tools
UNION
SELECT name AS item_name
FROM raw_material;


-- Операция пересечения
SELECT name
FROM tools
INTERSECT
SELECT name
FROM raw_material;


-- Операция разности
SELECT name
FROM tools
EXCEPT
SELECT name
FROM raw_material;


-- Операция группировки
SELECT id_process, COUNT(*) AS employee_count
FROM personnel
GROUP BY id_process;


-- Операция сортировки
SELECT name, quantity
FROM tools
ORDER BY quantity DESC;


