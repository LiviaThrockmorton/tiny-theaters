use tiny_theaters;

-- Find all performances in the last quarter of 2021 (Oct. 1, 2021 - Dec. 31 2021).
select * from showing
	where performance between '2021-10-1' and '2021-12-31';
    
-- List customers without duplication.
select * from customer;

-- Find all customers without a .com email address.
select customer_id, first_name, last_name, email from customer
	where email not like '%.com';

-- Find the three cheapest shows.
select * from showing order by price asc limit 3;

-- List customers and the show they're attending with no duplication.
select c.first_name, c.last_name, s.title, count(s.show_id) tickets_per_show from ticket t
	inner join customer c on t.customer_id = c.customer_id
    inner join showing s on t.show_id = s.show_id
    group by s.show_id, c.customer_id
    order by c.last_name;

-- List customer, show, theater, and seat number in one query.
select c.first_name, c.last_name, s.title, th.theater_name, t.seat from ticket t
	inner join customer c on t.customer_id = c.customer_id
    inner join showing s on t.show_id = s.show_id
    inner join theater th on s.theater_id = th.theater_id;
    
-- Find customers without an address.
select customer_id, first_name, last_name, phone, email from customer
	where address is null or address = '';

-- Recreate the spreadsheet data with a single query.
select c.first_name customer_first, c.last_name customer_last, c.email customer_email, c.phone customer_phone,
	c.address customer_address, t.seat, s.title `show`, s.price ticket_price, s.performance `date`,
    th.theater_name theater, th.address theater_address, th.phone theater_phone, th.email theater_email
    from ticket t
inner join customer c on t.customer_id = c.customer_id
    inner join showing s on t.show_id = s.show_id
    inner join theater th on s.theater_id = th.theater_id;

-- Count total tickets purchased per customer.
select c.first_name, c.last_name, count(*) tickets_purchased from ticket t
	inner join customer c on t.customer_id = c.customer_id
    group by c.customer_id
    order by c.last_name;

-- Calculate the total revenue per show based on tickets sold.
select s.title, s.performance, s.price,  count(t.ticket_id) tickets_sold, sum(s.price) revenue, s.theater_id from showing s
	inner join ticket t on s.show_id = t.show_id
    group by s.show_id;

-- Calculate the total revenue per theater based on tickets sold.
select th.theater_name, count(t.ticket_id) tickets_sold, sum(s.price) revenue from showing s
	inner join ticket t on s.show_id = t.show_id
    inner join theater th on s.theater_id = th.theater_id
    group by th.theater_id;

-- Who is the biggest supporter of RCTTC? Who spent the most in 2021?
select c.first_name, c.last_name, count(t.ticket_id) tickets_bought, sum(s.price) money_spent from customer c
	inner join ticket t on c.customer_id = t.customer_id
    inner join showing s on t.show_id = s.show_id
    where year(s.performance) = 2021
	group by c.customer_id
    order by money_spent desc limit 1;