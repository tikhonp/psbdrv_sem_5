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

INSERT INTO public.order(date,
                        tech_spec_id,
                        customer_id,
                        state,
                        quality_id,
                        quantity_unit)
VALUES ('2020-01-01',
            (INSERT INTO public.tech_spec(quality_id, product_type) VALUES (
        
    )
