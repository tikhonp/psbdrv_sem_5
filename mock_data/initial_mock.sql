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
                        quantity,
                        quantity_unit)
VALUES ('2024-01-01',
            (INSERT INTO public.tech_spec(quality_id, product_type) VALUES (
                (SELECT id FROM public.quality WHERE name = 'Высокое'),
                (SELECT id FROM public.product_type WHERE name = 'Кирпич')
            ) RETURNING id),
        (SELECT id FROM public.customer WHERE name = 'Сызранский рудный завод'),
        public.typed_order_state('producing'),
        100,
        public.typed_quantity_unit('ton')),
        ('2024-01-02',
            (INSERT INTO public.tech_spec(quality_id, product_type) VALUES (
                (SELECT id FROM public.quality WHERE name = 'Среднее'),
                (SELECT id FROM public.product_type WHERE name = 'Кирпич')
            ) RETURNING id),
        (SELECT id FROM public.customer WHERE name = 'Волжский металлургический завод'),
        public.typed_order_state('producing'),
        200,
        public.typed_quantity_unit('ton')),
        ('2024-01-03',
            (INSERT INTO public.tech_spec(quality_id, product_type) VALUES (
                (SELECT id FROM public.quality WHERE name = 'Низкое'),
                (SELECT id FROM public.product_type WHERE name = 'Кирпич')
            ) RETURNING id),
        (SELECT id FROM public.customer WHERE name = 'Куйбышевский завод строительных материалов'),
        public.typed_order_state('producing'),
        300,
        public.typed_quantity_unit('ton')),
        ('2024-01-04',
            (INSERT INTO public.tech_spec(quality_id, product_type) VALUES (
                (SELECT id FROM public.quality WHERE name = 'Высокое'),
                (SELECT id FROM public.product_type WHERE name = 'Керамическая плитка')
            ) RETURNING id),
        (SELECT id FROM public.customer WHERE name = 'Самарский завод строительных материалов'),
        public.typed_order_state('producing'),
        400,
        public.typed_quantity_unit('ton'));

