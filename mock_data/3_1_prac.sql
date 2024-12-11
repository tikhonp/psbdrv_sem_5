-- Операция проекции
select name from customer;

-- Операция селекции
select name from customer where description = 'Производство кирпичей';

-- Операции соединения
select o.date, c.name as customer_name
from "order" o
join public.customer c on c.id = o.customer_id;

-- Операция объединения
select o.date, c.name as customer_name
from "order" o
join public.customer c on c.id = o.customer_id
where o.quantity = 100 OR o.quantity = 400;

-- Операция пересечения
select o.date, c.name as customer_name
from "order" o
inner join public.customer c on c.id = o.customer_id
where o.quantity = 100
and exists(select * from "order" o where o.customer_id=c.id and o.quantity = 100);

-- Операция разности
select o.date, c.name as customer_name
from "order" o
         inner join public.customer c on c.id = o.customer_id
where o.quantity = 100
  and not exists(select * from "order" o where o.customer_id=c.id and o.quantity = 100);

-- Операция группировки
select c.name, o.quantity
from "order" o
inner join public.customer c on c.id = o.customer_id
group by o.quantity, c.name;

-- Операция группировки
select c.name, o.quantity
from "order" o
inner join public.customer c on c.id = o.customer_id
group by o.quantity, c.name order by o.quantity;

-- Операция сортировки
select c.name, o.quantity, COUNT(*) AS count
from "order" o
inner join public.customer c on c.id = o.customer_id
group by o.quantity, c.name order by count;

