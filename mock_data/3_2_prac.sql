-- 1. Логирование изменений в заказах
-- Триггер записывает изменения статуса заказа в таблицу логов.
-- Создаем таблицу для логов
CREATE TABLE order_logs (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    old_state order_state,
    new_state order_state,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Функция для записи изменений
CREATE OR REPLACE FUNCTION log_order_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.state IS DISTINCT FROM NEW.state THEN
        INSERT INTO order_logs (order_id, old_state, new_state)
        VALUES (OLD.id, OLD.state, NEW.state);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггер
CREATE TRIGGER trigger_log_order_changes
AFTER UPDATE ON "order"
FOR EACH ROW
WHEN (OLD.state IS DISTINCT FROM NEW.state)
EXECUTE FUNCTION log_order_changes();


-- 2. Автоматическое обновление времени изменения
-- Добавляет или обновляет поле last_updated при изменении записи.
-- Добавим поле last_updated, если его нет
ALTER TABLE "order" ADD COLUMN last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Функция для обновления времени
CREATE OR REPLACE FUNCTION update_last_updated()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_updated = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггер
CREATE TRIGGER trigger_update_last_updated
BEFORE UPDATE ON "order"
FOR EACH ROW
EXECUTE FUNCTION update_last_updated();


-- 3. Валидация количества при создании заказа
-- Гарантирует, что количество (quantity) положительное и не нулевое.
-- Функция проверки
CREATE OR REPLACE FUNCTION validate_order_quantity()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.quantity <= 0 THEN
        RAISE EXCEPTION 'Quantity must be greater than 0';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггер
CREATE TRIGGER trigger_validate_order_quantity
BEFORE INSERT ON "order"
FOR EACH ROW
EXECUTE FUNCTION validate_order_quantity();


-- 4. Обновление состояния заказа
-- Автоматически переводит заказ в статус completed, если выполнены условия.
-- Функция для автоматического изменения состояния
CREATE OR REPLACE FUNCTION auto_complete_order()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.state = 'delivery' THEN
        NEW.state = 'completed';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггер
CREATE TRIGGER trigger_auto_complete_order
BEFORE UPDATE ON "order"
FOR EACH ROW
WHEN (NEW.state = 'delivery')
EXECUTE FUNCTION auto_complete_order();


-- 5. Связь между заказом и спецификацией
-- Запрещает создание заказа с несуществующей спецификацией.
-- Функция проверки спецификации
CREATE OR REPLACE FUNCTION validate_tech_spec()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM tech_spec WHERE id = NEW.tech_spec_id) THEN
        RAISE EXCEPTION 'Tech Spec ID % does not exist', NEW.tech_spec_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггер
CREATE TRIGGER trigger_validate_tech_spec
BEFORE INSERT OR UPDATE ON "order"
FOR EACH ROW
EXECUTE FUNCTION validate_tech_spec();


