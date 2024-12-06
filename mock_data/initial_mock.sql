INSERT INTO public.customer(name,
                            description,
                            contract_data)
VALUES ('Сызранский рудный завод',
        'Перерабатывающеее предприятие',
        NULL),
       ('Волжский металлургический завод',
        'Производство металлопроката',
        NULL),
       ('Куйбышевский завод строительных материалов',
        'Производство кирпичей',
        NULL),
       ('Самарский завод строительных материалов',
        'Производство керамической плитки',
        NULL),
       ('Тольяттинский завод строительных материалов',
        'Производство керамической плитки',
        NULL),
       ('Сызранский завод строительных материалов',
        'Производство кирпичей',
        NULL),
       ('Самарский завод строительных материалов',
        'Производство кирпичей',
        NULL),
       ('Тольяттинский завод строительных материалов',
        'Производство кирпичей',
        NULL),
       ('Куйбышевский завод строительных материалов',
        'Производство керамической плитки',
        NULL),
       ('Самарский завод строительных материалов',
        'Производство керамической плитки',
        NULL),
       ('Тольяттинский завод строительных материалов',
        'Производство керамической плитки',
        NULL),
       ('Сызранский завод строительных материалов',
        'Производство керамической плитки',
        NULL),
       ('Куйбышевский завод строительных материалов',
        'Производство кирпичей',
        NULL),
       ('Самарский завод строительных материалов',
        'Производство кирпичей',
        NULL);

INSERT INTO public.quality(name)
VALUES ('Высокое'),
       ('Среднее'),
       ('Низкое');

INSERT INTO public.product_type(name)
VALUES ('Кирпич'),
       ('Керамическая плитка');

WITH inserted_tech_spec_1 AS (
    INSERT INTO public.tech_spec (quality_id, product_type_id) VALUES ((SELECT id FROM public.quality WHERE name = 'Высокое'),
                                                                       (SELECT id FROM public.product_type WHERE name = 'Кирпич')) RETURNING *)
INSERT
INTO public.order(date,
                  tech_spec_id,
                  customer_id,
                  state,
                  quantity,
                  quantity_unit)
VALUES ('2024-01-01',
        (SELECT id FROM inserted_tech_spec_1 LIMIT 1),
        (SELECT id FROM public.customer WHERE name = 'Сызранский рудный завод'),
        'producing',
        100,
        'ton');

WITH inserted_tech_spec_2 AS (
    INSERT INTO public.tech_spec (quality_id, product_type_id) VALUES ((SELECT id FROM public.quality WHERE name = 'Среднее' LIMIT 1),
                                                                       (SELECT id FROM public.product_type WHERE name = 'Кирпич' LIMIT 1)) RETURNING id)
INSERT
INTO public.order(date,
                  tech_spec_id,
                  customer_id,
                  state,
                  quantity,
                  quantity_unit)
VALUES ('2024-01-02',
        (SELECT id FROM inserted_tech_spec_2),
        (SELECT id FROM public.customer WHERE name = 'Волжский металлургический завод'),
        'producing',
        200,
        'ton');

WITH inserted_tech_spec_3 AS (
    INSERT INTO public.tech_spec (quality_id, product_type_id) VALUES ((SELECT id FROM public.quality WHERE name = 'Низкое' LIMIT 1),
                                                                       (SELECT id FROM public.product_type WHERE name = 'Кирпич' LIMIT 1)) RETURNING id)
INSERT
INTO public.order(date,
                  tech_spec_id,
                  customer_id,
                  state,
                  quantity,
                  quantity_unit)
VALUES ('2024-01-03',
        (SELECT id FROM inserted_tech_spec_3),
        (SELECT id FROM public.customer WHERE name = 'Куйбышевский завод строительных материалов' LIMIT 1),
        'producing',
        300,
        'ton');

WITH texh_spec_id_4 AS (
    INSERT INTO public.tech_spec (quality_id, product_type_id) VALUES ((SELECT id FROM public.quality WHERE name = 'Высокое' LIMIT 1),
                                                                       (SELECT id
                                                                        FROM public.product_type
                                                                        WHERE name = 'Керамическая плитка'
                                                                        LIMIT 1)) RETURNING id)
INSERT
INTO public.order(date,
                  tech_spec_id,
                  customer_id,
                  state,
                  quantity,
                  quantity_unit)
VALUES ('2024-01-04',
        (SELECT id FROM texh_spec_id_4),
        (SELECT id FROM public.customer WHERE name = 'Самарский завод строительных материалов' LIMIT 1),
        'producing',
        400,
        'ton');
