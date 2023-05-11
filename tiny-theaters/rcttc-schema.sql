drop database if exists tiny_theaters;
create database tiny_theaters;
use tiny_theaters;

create table customer (
	customer_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(260) not null,
    phone varchar(15) null,
    address varchar(124) null);
    
create table theater (
	theater_id int primary key auto_increment,
    theater_name varchar(25) not null,
    email varchar(260) not null,
    phone varchar(15) not null,
    address varchar(124) not null);
    
create table showing (
	show_id int primary key auto_increment,
    title varchar(75) not null,
    price decimal(4, 2) not null,
    performance date not null,
    theater_id int not null,
		constraint fk_showing_theater_id foreign key (theater_id) references theater(theater_id));
        
create table ticket (
	ticket_id int primary key auto_increment,
    seat varchar(3) not null,
    customer_id int not null,
    show_id int not null,
		constraint uq_ticket_seat_show_id unique (seat, show_id),
		constraint fk_ticket_customer_id foreign key (customer_id) references customer(customer_id),
        constraint fk_ticket_show_id foreign key (show_id) references showing(show_id));