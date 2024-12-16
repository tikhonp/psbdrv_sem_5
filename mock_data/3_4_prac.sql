-- Процедуры
-- 1. Добавление нового инструмента
CREATE OR REPLACE PROCEDURE add_new_tool(tool_name TEXT, tool_quantity INT, tool_condition TEXT)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO tools (name, quantity, condition)
    VALUES (tool_name, tool_quantity, tool_condition);
END;
$$;

-- 2. Удаление заказа по ID
CREATE OR REPLACE PROCEDURE delete_order_by_id(order_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM service_center WHERE id_order = order_id;
END;
$$;

-- 3. Обновление количества сырья
CREATE OR REPLACE PROCEDURE update_raw_material_quantity(material_id INT, new_quantity INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE raw_material
    SET quantity = new_quantity
    WHERE id_raw = material_id;
END;
$$;

-- 4. Добавление нового сотрудника
CREATE OR REPLACE PROCEDURE add_new_employee(emp_name TEXT, process_id INT, raw_id INT, tool_id INT, tz_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO personnel (employee_name, id_process, id_raw, id_tool, id_tz)
    VALUES (emp_name, process_id, raw_id, tool_id, tz_id);
END;
$$;

-- 5. Очистка таблицы брака
CREATE OR REPLACE PROCEDURE clear_defects_table()
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM defects;
END;
$$;
