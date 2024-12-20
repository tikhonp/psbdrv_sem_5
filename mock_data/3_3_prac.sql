-- Функции
-- 1. Получение описания состояния заказа
CREATE OR REPLACE FUNCTION get_order_state_description(state order_state)
RETURNS TEXT AS $$
BEGIN
    RETURN CASE state
        WHEN 'created' THEN 'Order created'
        WHEN 'approved' THEN 'Order approved'
        WHEN 'producing' THEN 'Producing in progress'
        WHEN 'waiting_for_delivery' THEN 'Waiting for delivery'
        WHEN 'delivery' THEN 'Delivery in progress'
        WHEN 'completed' THEN 'Order completed'
        ELSE 'Unknown state'
    END;
END;
$$ LANGUAGE plpgsql;


-- 2. Расчет общего количества заказов клиента
CREATE OR REPLACE FUNCTION total_orders_by_customer(cid INTEGER)
RETURNS INTEGER AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM "order" WHERE cid = $1);
END;
$$ LANGUAGE plpgsql;


-- 3. Получение списка заказов по дате
CREATE OR REPLACE FUNCTION get_orders_by_date(cdate DATE)
RETURNS INTEGER AS $$
BEGIN
    RETURN (SELECT o.id
            FROM "order" o
            WHERE o.date = cdate
    );
END;
$$ LANGUAGE plpgsql;



-- 4. Проверка наличия клиента
CREATE OR REPLACE FUNCTION is_customer_exists(customer_id INTEGER)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (SELECT 1 FROM customer WHERE id = $1);
END;
$$ LANGUAGE plpgsql;


-- 5. Получение качества продукта
CREATE OR REPLACE FUNCTION get_product_quality(tech_spec_id INTEGER)
RETURNS TEXT AS $$
BEGIN
    RETURN (SELECT ql.name
            FROM quality ql
            JOIN tech_spec ts ON ql.id = ts.quality_id
            WHERE ts.id = $1);
END;
$$ LANGUAGE plpgsql;


