-- Функции
-- 1. Подсчёт количества сотрудников на процессе
CREATE OR REPLACE FUNCTION count_employees_on_process(process_id INT)
RETURNS INT AS $$
DECLARE
    employee_count INT;
BEGIN
    SELECT COUNT(*) INTO employee_count
    FROM personnel
    WHERE id_process = process_id;
    RETURN employee_count;
END;
$$ LANGUAGE plpgsql;

-- 2. Получить общее количество инструментов
CREATE OR REPLACE FUNCTION get_total_tools()
RETURNS INT AS $$
DECLARE
    total INT;
BEGIN
    SELECT SUM(quantity) INTO total
    FROM tools;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- 3. Проверка состояния инструмента по его ID
CREATE OR REPLACE FUNCTION get_tool_condition(tool_id INT)
RETURNS TEXT AS $$
DECLARE
    cond TEXT;
BEGIN
    SELECT condition INTO cond
    FROM tools
    WHERE id_tool = tool_id;
    RETURN cond;
END;
$$ LANGUAGE plpgsql;

-- 4. Получение всех заказов за текущий месяц
CREATE OR REPLACE FUNCTION get_current_month_orders()
RETURNS TABLE (id_o INT, cus_name VARCHAR(255), order_d DATE) AS $$
BEGIN
    RETURN QUERY
    SELECT id_order, customer_name, order_date
    FROM service_center
    WHERE EXTRACT(MONTH FROM order_date) = EXTRACT(MONTH FROM CURRENT_DATE)
      AND EXTRACT(YEAR FROM order_date) = EXTRACT(YEAR FROM CURRENT_DATE);
END;
$$ LANGUAGE plpgsql;

-- 5. Подсчёт брака по инструменту
CREATE OR REPLACE FUNCTION calculate_defect_percentage(tool_id INT)
RETURNS NUMERIC AS $$
DECLARE
    defect_percentage NUMERIC;
BEGIN
    SELECT AVG(defect_percentage_stat) INTO defect_percentage
    FROM defects
    WHERE id_tool = tool_id;
    RETURN defect_percentage;
END;
$$ LANGUAGE plpgsql;

