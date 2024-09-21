-- Team __
-- Team Bryson Bien (bbien6)
-- Team Elliot Willner (ewillner3)
-- Team Max Sikora (msikora8)

-- Directions:
-- Please follow all instructions for Phase III as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from an SQL Dump file.
-- This file must run without error for credit.

drop database if exists grocery_drone_express;
create database if not exists grocery_drone_express;
use grocery_drone_express;

-- -----------------------------------------------
-- table structures
-- -----------------------------------------------

create table users (
uname varchar(40) not null,
first_name varchar(100) not null,
last_name varchar(100) not null,
address varchar(500) not null,
birthdate date default null,
primary key (uname)
) engine = innodb;

create table customers (
uname varchar(40) not null,
rating integer not null,
credit integer not null,
primary key (uname)
) engine = innodb;

create table employees (
uname varchar(40) not null,
taxID varchar(40) not null,
hired date not null,
service integer not null,
salary integer not null,
primary key (uname),
unique key (taxID)
) engine = innodb;

create table drone_pilots (
uname varchar(40) not null,
licenseID varchar(40) not null,
experience integer not null,
primary key (uname),
unique key (licenseID)
) engine = innodb;

create table floor_workers (
uname varchar(40) not null,
primary key (uname)
) engine = innodb;

create table items (
barcode varchar(40) not null,
iname varchar(100) not null,
weight integer not null,
primary key (barcode)
) engine = innodb;

create table orders (
orderID varchar(40) not null,
sold_on date not null,
purchased_by varchar(40) not null,
carrier_store varchar(40) not null,
carrier_tag integer not null,
primary key (orderID)
) engine = innodb;

create table stores (
storeID varchar(40) not null,
sname varchar(100) not null,
revenue integer not null,
manager varchar(40) not null,
primary key (storeID)
) engine = innodb;

create table drones (
storeID varchar(40) not null,
droneTag integer not null,
capacity integer not null,
remaining_trips integer not null,
pilot varchar(40) not null,
primary key (storeID, droneTag)
) engine = innodb;

create table order_lines (
orderID varchar(40) not null,
barcode varchar(40) not null,
price integer not null,
quantity integer not null,
primary key (orderID, barcode)
) engine = innodb;

create table employed_workers (
storeID varchar(40) not null,
uname varchar(40) not null,
primary key (storeID, uname)
) engine = innodb;

-- -----------------------------------------------
-- referential structures
-- -----------------------------------------------

alter table customers add constraint fk1 foreign key (uname) references users (uname)
	on update cascade on delete cascade;
alter table employees add constraint fk2 foreign key (uname) references users (uname)
	on update cascade on delete cascade;
alter table drone_pilots add constraint fk3 foreign key (uname) references employees (uname)
	on update cascade on delete cascade;
alter table floor_workers add constraint fk4 foreign key (uname) references employees (uname)
	on update cascade on delete cascade;
alter table orders add constraint fk8 foreign key (purchased_by) references customers (uname)
	on update cascade on delete cascade;
alter table orders add constraint fk9 foreign key (carrier_store, carrier_tag) references drones (storeID, droneTag)
	on update cascade on delete cascade;
alter table stores add constraint fk11 foreign key (manager) references floor_workers (uname)
	on update cascade on delete cascade;
alter table drones add constraint fk5 foreign key (storeID) references stores (storeID)
	on update cascade on delete cascade;
alter table drones add constraint fk10 foreign key (pilot) references drone_pilots (uname)
	on update cascade on delete cascade;
alter table order_lines add constraint fk6 foreign key (orderID) references orders (orderID)
	on update cascade on delete cascade;
alter table order_lines add constraint fk7 foreign key (barcode) references items (barcode)
	on update cascade on delete cascade;
alter table employed_workers add constraint fk12 foreign key (storeID) references stores (storeID)
	on update cascade on delete cascade;
alter table employed_workers add constraint fk13 foreign key (uname) references floor_workers (uname)
	on update cascade on delete cascade;

-- -----------------------------------------------
-- table data
-- -----------------------------------------------

insert into users values
('jstone5', 'Jared', 'Stone', '101 Five Finger Way', '1961-01-06'),
('sprince6', 'Sarah', 'Prince', '22 Peachtree Street', '1968-06-15'),
('awilson5', 'Aaron', 'Wilson', '220 Peachtree Street', '1963-11-11'),
('lrodriguez5', 'Lina', 'Rodriguez', '360 Corkscrew Circle', '1975-04-02'),
('tmccall5', 'Trey', 'McCall', '360 Corkscrew Circle', '1973-03-19'),
('eross10', 'Erica', 'Ross', '22 Peachtree Street', '1975-04-02'),
('hstark16', 'Harmon', 'Stark', '53 Tanker Top Lane', '1971-10-27'),
('echarles19', 'Ella', 'Charles', '22 Peachtree Street', '1974-05-06'),
('csoares8', 'Claire', 'Soares', '706 Living Stone Way', '1965-09-03'),
('agarcia7', 'Alejandro', 'Garcia', '710 Living Water Drive', '1966-10-29'),
('bsummers4', 'Brie', 'Summers', '5105 Dragon Star Circle', '1976-02-09'),
('cjordan5', 'Clark', 'Jordan', '77 Infinite Stars Road', '1966-06-05'),
('fprefontaine6', 'Ford', 'Prefontaine', '10 Hitch Hikers Lane', '1961-01-28');

insert into customers values
('jstone5', 4, 40),
('sprince6', 5, 30),
('awilson5', 2, 100),
('lrodriguez5', 4, 60),
('bsummers4', 3, 110),
('cjordan5', 3, 50);

insert into employees values
('awilson5', '111-11-1111', '2020-03-15', 9, 46000),
('lrodriguez5', '222-22-2222', '2019-04-15', 20, 58000),
('tmccall5', '333-33-3333', '2018-10-17', 29, 33000),
('eross10', '444-44-4444', '2020-04-17', 10, 61000),
('hstark16', '555-55-5555', '2018-07-23', 20, 59000),
('echarles19', '777-77-7777', '2021-01-02', 3, 27000),
('csoares8', '888-88-8888', '2019-02-25', 26, 57000),
('agarcia7', '999-99-9999', '2019-03-17', 24, 41000),
('bsummers4', '000-00-0000', '2018-12-06', 17, 35000),
('fprefontaine6', '121-21-2121', '2020-04-19', 5, 20000);

insert into floor_workers values
('eross10'),
('hstark16'),
('echarles19');

insert into stores values
('pub', 'Publix', 200, 'hstark16'),
('krg', 'Kroger', 300, 'echarles19');

insert into employed_workers values
('pub', 'eross10'),
('pub', 'hstark16'),
('krg', 'eross10'),
('krg', 'echarles19');

insert into drone_pilots values
('awilson5', '314159', 41),
('lrodriguez5', '287182', 67),
('tmccall5', '181633', 10),
('agarcia7', '610623', 38),
('bsummers4', '411911', 35),
('fprefontaine6', '657483', 2);

insert into drones values
('pub', 1, 10, 3, 'awilson5'),
('pub', 2, 20, 2, 'lrodriguez5'),
('krg', 1, 15, 4, 'tmccall5'),
('pub', 9, 45, 1, 'fprefontaine6');

insert into items values
('pr_3C6A9R', 'pot roast', 6),
('ss_2D4E6L', 'shrimp salad', 3),
('hs_5E7L23M', 'hoagie sandwich', 3),
('clc_4T9U25X', 'chocolate lava cake', 5),
('ap_9T25E36L', 'antipasto platter', 4);

insert into orders values
('pub_303', '2021-05-23', 'sprince6', 'pub', 1),
('pub_305', '2021-05-22', 'sprince6', 'pub', 2),
('krg_217', '2021-05-23', 'jstone5', 'krg', 1),
('pub_306', '2021-05-22', 'awilson5', 'pub', 2);

insert into order_lines values
('pub_303', 'pr_3C6A9R', 20, 1),
('pub_303', 'ap_9T25E36L', 4, 1),
('pub_305', 'clc_4T9U25X', 3, 2),
('pub_306', 'hs_5E7L23M', 3, 2),
('pub_306', 'ap_9T25E36L', 10, 1),
('krg_217', 'pr_3C6A9R', 15, 2);

-- -----------------------------------------------
-- stored procedures and views
-- -----------------------------------------------

-- add customer
delimiter // 
create procedure add_customer
	(in ip_uname varchar(40), in ip_first_name varchar(100),
	in ip_last_name varchar(100), in ip_address varchar(500),
    in ip_birthdate date, in ip_rating integer, in ip_credit integer)
sp_main: begin
	-- place your solution here
    insert into users values(
    ip_uname, ip_first_name, ip_last_name, ip_address, ip_birthdate);
    insert into customers values(
    ip_uname, ip_rating, ip_credit);
end //
delimiter ;

-- add drone pilot
delimiter // 
create procedure add_drone_pilot
	(in ip_uname varchar(40), in ip_first_name varchar(100),
	in ip_last_name varchar(100), in ip_address varchar(500),
    in ip_birthdate date, in ip_taxID varchar(40), in ip_hired date,
    in ip_service integer, in ip_salary integer, in ip_licenseID varchar(40),
    in ip_experience integer)
sp_main: begin
	-- place your solution here
    insert into users values(
    ip_uname, ip_first_name, ip_last_name, ip_address, ip_birthdate);
    insert into employees values(
    ip_uname, ip_taxID, ip_hired, ip_service, ip_salary);
    insert into drone_pilots values(
    ip_uname, ip_licenseID, ip_experience);
end //
delimiter ;

-- add item
delimiter // 
create procedure add_item
	(in ip_barcode varchar(40), in ip_iname varchar(100),
    in ip_weight integer)
sp_main: begin
	-- place your solution here
    insert into items values(
    ip_barcode, ip_iname, ip_weight);
end //
delimiter ;

-- add drone
delimiter // 
create procedure add_drone
	(in ip_storeID varchar(40), in ip_droneTag integer,
    in ip_capacity integer, in ip_remaining_trips integer,
    in ip_pilot varchar(40))
sp_main: begin
	-- place your solution here
    insert into drones values(
    ip_storeID, ip_droneTag, ip_capacity, ip_remaining_trips, ip_pilot);
end //
delimiter ;

-- increase customer credits
delimiter // 
create procedure increase_customer_credits
	(in ip_uname varchar(40), in ip_money integer)
sp_main: begin
	-- place your solution here
	if (ip_money >= 0) then
	update customers
	set credit = (credit + ip_money)
	where customers.uname = ip_uname;
    end if;
end //
delimiter ;

-- swap drone control
delimiter // 
create procedure swap_drone_control
	(in ip_incoming_pilot varchar(40), in ip_outgoing_pilot varchar(40))
sp_main: begin
	-- place your solution here
    update drones
    set drones.pilot = ip_incoming_pilot
    where drones.pilot = ip_outgoing_pilot;
end //
delimiter ;

-- repair and refuel a drone
delimiter // 
create procedure repair_refuel_drone
	(in ip_drone_store varchar(40), in ip_drone_tag integer,
    in ip_refueled_trips integer)
sp_main: begin
	-- place your solution here
    if (ip_refueled_trips >= 0) then
    update drones
    set drones.remaining_trips = (drones.remaining_trips + ip_refueled_trips)
    where drones.droneTag = ip_drone_tag and drones.storeID = ip_drone_store;
    end if;
end //
delimiter ;

-- begin order
delimiter // 
create procedure begin_order
	(in ip_orderID varchar(40), in ip_sold_on date,
    in ip_purchased_by varchar(40), in ip_carrier_store varchar(40),
    in ip_carrier_tag integer, in ip_barcode varchar(40),
    in ip_price integer, in ip_quantity integer)
sp_main: begin
	-- place your solution here
    insert ignore into orders values(ip_orderID, ip_sold_on, ip_purchased_by, ip_carrier_store, ip_carrier_tag);
    insert ignore into order_lines values(ip_orderID, ip_barcode, ip_price, ip_quantity);
end //
delimiter ;

-- add order line
delimiter // 
create procedure add_order_line
	(in ip_orderID varchar(40), in ip_barcode varchar(40),
    in ip_price integer, in ip_quantity integer)
sp_main: begin
	-- place your solution here
insert ignore into order_lines values(ip_orderID, ip_barcode, ip_price, ip_quantity);
end //

delimiter ;

-- deliver order
delimiter // 
create procedure deliver_order
	(in ip_orderID varchar(40))
    
sp_main: begin
	-- place your solution here
    update customers 
    set customers.credit = customers.credit - (select cost from orders_in_progress as OIP where OIP.orderID = ip_orderID)
    where uname = 
    (select purchased_by
    from orders
    where orders.orderID = ip_orderID);
    
    update stores 
    set stores.revenue = stores.revenue + (select cost from orders_in_progress as OIP where OIP.orderID = ip_orderID)
    where storeID = 
    (select carrier_store 
    from orders where 
    orderID = ip_orderID);
    
    update drones 
    set drones.remaining_trips = drones.remaining_trips - 1
    where storeID = 
    (select carrier_store 
    from orders where 
    orderID = ip_orderID);
    
    update drone_pilots
    set experience = experience + 1
    where uname = 
    (select pilot
    from drones
    where droneTag = 
    (select carrier_tag
    from orders where 
    orderID = ip_orderID)
    and storeID =
    (select carrier_store
    from orders where 
    orderID = ip_orderID)
    );
    
    update customers 
    set rating =
		case 
			WHEN (select cost from orders_in_progress where orderID = ip_orderID) > 25 
            THEN rating + 1
	end
    where uname = 
    (select purchased_by
    from orders
    where orders.orderID = ip_orderID);
    
    
    delete from orders
    where orders.orderID = ip_orderID;
	delete from order_lines
    where order_lines.orderID = ip_orderID;
    delete from order_lines
    where order_lines.orderID = ip_orderID;
    
end //
delimiter ;

-- cancel an order
delimiter // 
create procedure cancel_order
	(in ip_orderID varchar(40))
sp_main: begin
	-- place your solution here
    update customers 
    set rating = rating - 1
    where uname = 
    (select purchased_by
    from orders
    where orders.orderID = ip_orderID);
    
    delete from orders
    where orders.orderID = ip_orderID;
    
	delete from order_lines
    where order_lines.orderID = ip_orderID;
end //
delimiter ;
	
-- display persons distribution across roles
create or replace view role_distribution (category, total) as
-- replace this select query with your solution
select "users", count(*) from users
	union all
select "customers", count(*) from customers
	union all
select "employees", count(*) from employees
	union all
select "customer_employer_overlap", count(e.uname)
from employees as e, customers as c
where e.uname = c.uname
	union all
select "drone_pilots", count(*) from drone_pilots
	union all
select "floor_workers", count(*) from floor_workers
	union all
select "other_employee_roles", 
  (
    select
      count(*) as val1 
    from 
      employees
  ) - (
    select
      count(*) as val2 
    from 
      drone_pilots
  ) - (
    select 
      count(*) as val2 
    from 
      floor_workers
  ) as total_count;

-- display customer status and current credit and spending activity
create or replace view customer_credit_check (customer_name, rating, current_credit,
	credit_already_allocated) as
-- replace this select query with your solution
select c.uname as "customer_name", c.rating, c.credit as "current_credit", IFNull(p.totals, "0")
from customers as c left join (select purchased_by, sum(totals) as totals from orders as o join (select orderID, sum(price*quantity) as totals from order_lines group by orderID ) as t on o.orderID = t.orderID group by purchased_by) as p on c.uname = purchased_by;

-- display drone status and current activity
create or replace view drone_traffic_control (drone_serves_store, drone_tag, pilot,
	total_weight_allowed, current_weight, deliveries_allowed, deliveries_in_progress) as
-- replace this select query with your solution
(select d.storeID as "drone_serves_store", d.droneTag as "drone_tag", d.pilot, d.capacity as "total_weight_allowed", ifNULL(sum(current_weight), 0) as current_weight, remaining_trips as "deliveries_allowed",count(current_weight) as deliveries_in_progress
from drones as d 
left join
(select o.orderID, carrier_store, carrier_tag, sum(quantity*weight) as current_weight from orders as o left join (select orderID, ol.barcode, quantity, weight from order_lines as ol left join (select barcode, weight from items) as I on ol.barcode = I.barcode) as ol2 on o.orderID = ol2.orderID group by orderID, carrier_store, carrier_tag) as agg on storeId = carrier_store and droneTag = carrier_tag
group by d.storeID, d.droneTag, d.pilot, d.capacity, remaining_trips);

-- display item status and current activity including most popular items
create or replace view most_popular_items (barcode, item_name, weight, lowest_price,
	highest_price, lowest_quantity, highest_quantity, total_quantity) as
-- replace this select query with your solution
select I.barcode, iname as "item_name", weight, lowest_price, highest_price, ifNULL(lowest_quantity, 0), ifNULL(highest_quantity, 0), ifNULL(total_quantity, 0) from items as I
left join
(select barcode, min(price) as "lowest_price", max(price) as "highest_price", ifNULL(min(quantity), 0) as "lowest_quantity", max(quantity) as "highest_quantity", sum(quantity) as "total_quantity"
from order_lines
group by barcode) as OL
on I.barcode = ol.barcode;

-- display drone pilot status and current activity including experience
create or replace view drone_pilot_roster (pilot, licenseID, drone_serves_store,
	drone_tag, successful_deliveries, pending_deliveries) as
-- replace this select query with your solution
select distinct p.uname as "pilot", p.licenseID, d.storeID, d.droneTag as "drone_tag", p.experience as "succesfull_deliveries", ifNULL(pd,0) as "pending_deliveries"
from (drone_pilots as p left join drones as d on pilot = uname) left join (select carrier_store, carrier_tag, count(orderID) as pd from orders group by carrier_store, carrier_tag) as o on storeID = o.carrier_store and droneTag = o.carrier_tag;

-- display store revenue and activity
create or replace view store_sales_overview (store_id, sname, manager, revenue,
	incoming_revenue, incoming_orders) as
-- replace this select query with your solution
select s.storeID as "store_id", s.sname, s.manager, revenue, incoming_revenue, incoming_orders
from stores as s
left join
(select carrier_store,  sum(pq) as "incoming_revenue", count(pq)as "incoming_orders" from 
(select carrier_store, carrier_tag, pq from orders as o
left join (select orderId, sum(price*quantity) as pq from order_lines group by orderID) as ol on o.orderID = ol.orderID) as agg
group by carrier_store) as agg2
on s.storeID = carrier_store;

-- display the current orders that are being placed/in progress
create or replace view orders_in_progress (orderID, cost, num_items, payload,
	contents) as
-- replace this select query with your solution

(select distinct o.orderID, pq, c, payload, contents
from orders as o
left join 
(select orderId, sum(price*quantity) as pq, count(price) as c from order_lines group by orderID) as ol
on o.orderId = ol.orderId
left join
(select orderID, group_concat(iname) as "contents", sum(weight*quantity) as "payload"
from order_lines as ol
left join
(select *
from items) as I
on ol.barcode = i.barcode
group by orderID) as agg2
on o.orderID = agg2.orderID)
order by orderID;

-- remove customer
delimiter // 
create procedure remove_customer
	(in ip_uname varchar(40))
sp_main: begin
	-- place your solution here
    delete from customers
    where customers.uname = ip_uname;
    delete from users
    where users.uname = ip_uname;
end //
delimiter ;

-- remove drone pilot
delimiter // 
create procedure remove_drone_pilot
	(in ip_uname varchar(40))
sp_main: begin
	-- place your solution here
    delete from drone_pilots
    where drone_pilots.uname = ip_uname;
    delete from users
    where users.uname = ip_uname;
    delete from employees
    where employees.uname = ip_uname;
end //
delimiter ;

-- remove item
delimiter // 
create procedure remove_item
	(in ip_barcode varchar(40))
sp_main: begin
	-- place your solution here
    delete from order_lines
    where order_lines.barcode = ip_barcode;
    delete from items
    where items.barcode = ip_barcode;
end //
delimiter ;

-- remove drone
delimiter // 
create procedure remove_drone
	(in ip_storeID varchar(40), in ip_droneTag integer)
sp_main: begin
	-- place your solution here
    delete from drones
    where drones.storeID = ip_storeID and drones.droneTag = ip_droneTag;
end //
delimiter ;
