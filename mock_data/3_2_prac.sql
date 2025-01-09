-- 1. Автоматическое заполнение текущей даты при добавлении заказа
CREATE OR REPLACE FUNCTION set_order_date()
RETURNS TRIGGER AS $$
BEGIN
    NEW.order_date := CURRENT_DATE;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_order_date
BEFORE INSERT ON service_center
FOR EACH ROW
EXECUTE FUNCTION set_order_date();

-- 2. Проверка качества продукта при добавлении в product
CREATE OR REPLACE FUNCTION check_product_quality()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.quality NOT IN ('Высокое', 'Среднее', 'Низкое') THEN
        RAISE EXCEPTION 'Недопустимое качество продукта: %', NEW.quality;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_product_quality
BEFORE INSERT OR UPDATE ON product
FOR EACH ROW
EXECUTE FUNCTION check_product_quality();

-- 3. Обновление количества инструментов после их использования
CREATE OR REPLACE FUNCTION update_tool_quantity()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.quantity < 0 THEN
        RAISE EXCEPTION 'Количество инструмента не может быть отрицательным!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_tool_quantity
BEFORE UPDATE ON tools
FOR EACH ROW
EXECUTE FUNCTION update_tool_quantity();

-- 4. Логирование изменений в таблице personnel
CREATE TABLE personnel_log (
    log_id SERIAL PRIMARY KEY,
    employee_name TEXT,
    action TEXT,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_personnel_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO personnel_log (employee_name, action)
    VALUES (OLD.employee_name, 'Удаление');
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_personnel
AFTER DELETE ON personnel
FOR EACH ROW
EXECUTE FUNCTION log_personnel_changes();


-- Триггер 5: Проверка наличия достаточного количества сырья
CREATE OR REPLACE FUNCTION check_raw_material_availability()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.quantity < 10 THEN
        RAISE WARNING 'Остаток сырья низкий: %', NEW.name;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_raw_material
BEFORE UPDATE ON raw_material
FOR EACH ROW
EXECUTE FUNCTION check_raw_material_availability();
