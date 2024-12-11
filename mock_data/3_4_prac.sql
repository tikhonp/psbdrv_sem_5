-- Процедуры
-- 1. Создание нового заказа
CREATE OR REPLACE PROCEDURE create_order(
    customer_id INTEGER, 
    tech_spec_id INTEGER, 
    quantity INTEGER, 
    quantity_unit ENUM
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO "order" (customer_id, tech_spec_id, state, quantity, quantity_unit, date)
    VALUES (customer_id, tech_spec_id, 'created', quantity, quantity_unit, CURRENT_DATE);
END;
$$;


-- 2. Обновление состояния заказа
CREATE OR REPLACE PROCEDURE update_order_state(order_id INTEGER, new_state ENUM)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE "order" SET state = new_state WHERE id = order_id;
END;
$$;


-- 3. Удаление заказов клиента
CREATE OR REPLACE PROCEDURE delete_customer_orders(customer_id INTEGER)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM "order" WHERE customer_id = customer_id;
END;
$$;


-- 4. Обновление информации о клиенте
CREATE OR REPLACE PROCEDURE update_customer_info(customer_id INTEGER, new_name VARCHAR, new_description TEXT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE customer 
    SET name = new_name, description = new_description 
    WHERE id = customer_id;
END;
$$;


-- 5. Очистка старых заказов
CREATE OR REPLACE PROCEDURE clean_old_orders(clean_date DATE)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM "order" WHERE date < clean_date;
END;
$$;
