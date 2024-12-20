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

CREATE OR REPLACE PROCEDURE add_order(
    p_customer_name TEXT,
    p_product_type_name TEXT,
    p_quality_name TEXT,
    p_date DATE,
    p_state order_state,
    p_quantity INTEGER,
    p_quantity_unit quantity_unit
)
LANGUAGE plpgsql AS $$
DECLARE
    v_customer_id INTEGER;
    v_product_type_id INTEGER;
    v_quality_id INTEGER;
    v_tech_spec_id INTEGER;
BEGIN
    -- Получаем ID клиента
    SELECT id INTO v_customer_id 
    FROM customer 
    WHERE name = p_customer_name;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Customer % not found', p_customer_name;
    END IF;

    -- Получаем ID типа продукта
    SELECT id INTO v_product_type_id 
    FROM product_type 
    WHERE name = p_product_type_name;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Product type % not found', p_product_type_name;
    END IF;

    -- Получаем ID качества
    SELECT id INTO v_quality_id 
    FROM quality 
    WHERE name = p_quality_name;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Quality % not found', p_quality_name;
    END IF;

    -- Получаем или создаем техническую спецификацию
    SELECT id INTO v_tech_spec_id 
    FROM tech_spec 
    WHERE product_type_id = v_product_type_id AND quality_id = v_quality_id;

    IF NOT FOUND THEN
        INSERT INTO tech_spec (product_type_id, quality_id) 
        VALUES (v_product_type_id, v_quality_id)
        RETURNING id INTO v_tech_spec_id;
    END IF;

    -- Создаем заказ
    INSERT INTO "order" (date, tech_spec_id, customer_id, state, quantity, quantity_unit)
    VALUES (p_date, v_tech_spec_id, v_customer_id, p_state, p_quantity, p_quantity_unit);

    RAISE NOTICE 'Order successfully added for customer % on date %', p_customer_name, p_date;
END;
$$;

