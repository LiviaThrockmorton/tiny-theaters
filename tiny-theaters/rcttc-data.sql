use tiny_theaters;
select * from temp;


-- customer
insert into customer (first_name, last_name, email, phone, address)
	select distinct customer_first, customer_last,
		customer_email, customer_phone, customer_address
	from temp;
    
select * from customer;



-- theater
insert into theater (theater_name, email, phone, address)
	select distinct theater, theater_address, theater_phone, theater_email
	from temp;
    
select * from theater;



-- show
insert into showing (title, price, performance, theater_id)
	select distinct `show`, ticket_price, `date`, th.theater_id
	from temp te
    inner join theater th on te.theater = th.theater_name;
    
select * from showing;


    
-- ticket
insert into ticket (seat, customer_id, show_id)
	select distinct seat, c.customer_id, s.show_id
	from temp te
	inner join customer c on te.customer_email = c.email
	inner join showing s on te.show = s.title and te.date = s.performance;
    
select * from ticket;


drop table if exists temp;



-- updates
 select show_id, price, performance from showing
	where title = 'The Sky Lit Up' and performance = '2021-03-01';
    
 update showing set price = 22.25
	where show_id = 5;
    
    
    
select t.ticket_id, t.seat, t.customer_id, first_name, last_name from ticket t
	inner join customer c on t.customer_id = c.customer_id
    where show_id = 5;    
   
update ticket set seat = 'XX'
		where ticket_id = 101;
update ticket set seat = 'C2'
		where ticket_id = 100;
update ticket set seat = 'B4'
		where ticket_id = 98;
update ticket set seat = 'A4'
		where ticket_id = 101;
        
select distinct seat from ticket where show_id = 5;

    
    
select customer_id, first_name, last_name, phone from customer
	where first_name = 'Jammie' and last_name = 'Swindles';
    
update customer set phone = '1-801-EAT-CAKE'
	where customer_id = 48;
    
    
-- delete
select t.ticket_id, t.customer_id from theater th
	inner join showing s on th.theater_id = s.theater_id
    inner join ticket t on s.show_id = t.show_id
    where th.theater_id = 1;
    
select count(t.ticket_id) single, t.customer_id, min(t.ticket_id) ticket_id from theater th
	inner join showing s on th.theater_id = s.theater_id
    inner join ticket t on s.show_id = t.show_id
    where th.theater_id = 1
    group by t.customer_id
    having count(t.ticket_id) = 1;
    
delete from ticket where ticket_id = 25;
delete from ticket where ticket_id = 26;
delete from ticket where ticket_id = 29;
delete from ticket where ticket_id = 41;
delete from ticket where ticket_id = 50;
delete from ticket where ticket_id = 51;
delete from ticket where ticket_id = 59;
delete from ticket where ticket_id = 67;
delete from ticket where ticket_id = 68;



select customer_id from customer
	where first_name = 'Liv' and last_name = 'Egle of Germany';
delete from ticket where customer_id = 65;

set sql_safe_updates = 0;
delete from customer where first_name = 'Liv' and last_name = 'Egle of Germany';
set sql_safe_updates = 1;