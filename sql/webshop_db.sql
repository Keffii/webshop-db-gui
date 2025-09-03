drop database webshop_db;
create database webshop_db;
use webshop_db;

create table customer (
	customer_id int not null auto_increment primary key,
    name varchar(30) not null,
    email varchar(30) unique not null,
    city varchar(30) not null
);

create table brand (
	brand_id int not null auto_increment primary key,
    brand_name varchar(30) not null,
    description varchar(30) not null
);
    
create table orders (
	order_id int not null auto_increment primary key,
    customer_id int not null,
    order_date datetime not null,
    foreign key(customer_id) references customer(customer_id)
);

create table product (
	product_id int not null auto_increment primary key,
	brand_id int not null,
    product_name varchar(30) not null,
    color varchar(30) not null,
    size varchar(30) not null,
    stock_quantity int default 0,
    stock_price double default 0,
	foreign key(brand_id) references brand(brand_id)
);

create table order_item (
	order_item_id int not null auto_increment primary key,
    order_id int not null,
    product_id int not null,
    quantity int not null default 0,
    foreign key(order_id) references orders(order_id),
    foreign key(product_id) references product(product_id),
    index ix_order_id (order_id),
    index ix_product_id (product_id)
);

create table category (
	category_id int not null auto_increment primary key,
    category_name varchar(30) not null
);

create table product_category (
	product_id int not null,
    category_id int not null,
    foreign key(product_id) references product(product_id) on delete cascade,
    foreign key(category_id) references category(category_id) on delete cascade
);

insert into customer(name, email, city) values
('Anna Svensson', 'anna.svensson@email.se', 'Stockholm'),
('Erik Johannson', 'erik.johannsson@email.se', 'Stockholm'),
('Maria Lindqvist', 'maria.lindqvist@email.se', 'Stockholm'),
('Johan Karlsson', 'johan.karlsson@email.se', 'Gothenburg'),
('Emma Andersson', 'emma.andersson@email.se', 'Gothenburg'),
('Lars Petersson', 'lars.petersson@email.se', 'Gothenburg'),
('Sofia Nilsson', 'sofia.nilsson@email.se', 'Malmo'),
('Magnus Bergström', 'magnus.bergstrom@email.se', 'Malmo'),
('Astrid Gustafsson', 'astrid.gustafsson@email.se', 'Uppsala'),
('Oskar Hedberg', 'oskar.hedberg@email.se', 'Uppsala');

insert into category(category_name) values
('Shirts'), -- 1
('Pants'), -- 2 
('Dresses'), -- 3 
('Underwear'), -- 4 
('Shoes'), -- 5 
('Jackets'), -- 6 
('Socks'), -- 7 
('Sportswear'), -- 8 
('Casual'), -- 9
('Accessories'); -- 10 

insert into brand(brand_name, description) values
('SweetPants', 'Casual pants fashion'), -- 1
('H&M', 'Swedish fashion retailer'), -- 2
('Nike', 'Athletic footwear brand'), -- 3
('Zara', 'Spanish fashion retailer'), -- 4
('Adidas', 'Performance sportswear'), -- 5
('Uniqlo', 'Japanese casual wear'), -- 6
('Ralph Lauren', 'American luxury fashion'), -- 7
('Calvin Klein', 'American designer fashion'), -- 8
('Puma', 'German athletic apparel'), -- 9
('Lacoste', 'French luxury fashion brand'); -- 10

insert into orders(customer_id, order_date) values
    (1, '2025-01-01 10:30:00'),  -- 1 Anna Svensson
    (2, '2025-02-01 10:30:00'),  -- 2 Erik Johannson
    (3, '2025-03-01 10:30:00'),  -- 3 Maria Lindqvist
    (1, '2025-04-02 10:30:00'),  -- 4 Anna Svensson second order
    (2, '2025-04-05 10:30:00'),  -- 5 Erik Johannson second order
    (3, '2025-04-10 10:30:00'),  -- 6 Maria Lindqvist second order
    (4, '2025-05-01 10:30:00'),  -- 7 Johan Karlsson
    (5, '2025-05-01 10:30:00'),  -- 8 Emma Andersson
    (6, '2025-06-01 10:30:00'),  -- 9 Lars Petersson
    (4, '2025-06-05 10:30:00'),  -- 10 Johan Karlsson second order
    (5, '2025-06-10 10:30:00'),  -- 11 Emma Andersson second order
    (6, '2025-06-15 10:30:00'),  -- 12 Lars Petersson second order
    (7, '2025-07-01 10:30:00'),  -- 13 Sofia Nilsson
    (8, '2025-08-01 10:30:00'),  -- 14 Magnus Bergström
    (7, '2025-08-05 10:30:00'),  -- 15 Sofia Nilsson second order
    (8, '2025-08-10 10:30:00'),  -- 16 Magnus Bergström second order
    (9, '2025-09-01 10:30:00'),  -- 17 Astrid Gustafsson
    (10, '2025-10-01 10:30:00'), -- 18 Oskar Hedberg
    (9, '2025-10-05 10:30:00'),  -- 19 Astrid Gustafsson second order
    (10, '2025-10-10 10:30:00'); -- 20 Oskar Hedberg second order


INSERT INTO product(brand_id, product_name, color, size, stock_quantity, stock_price) VALUES
    -- Shirts
    (2, 'Hoodie', 'Grey', 'L', 15, 399.00), -- 1, H&M
    (5, 'T-shirt', 'Black', 'M', 12, 299.00), -- 2, Adidas
    
    -- Pants
    (1, 'Casual pants', 'Black', '38', 10, 399.00), -- 3, SweetPants
    (4, 'Chinos', 'Blue', '32', 20, 499.00), -- 4, Zara
    
    -- Dresses
    (2, 'Business dress', 'Navy blue', 'M', 7, 1099.00), -- 5, H&M
    (6, 'Summer dress', 'Yellow', 'L', 9, 599.00), -- 6, Uniqlo
    
    -- Underwear
    (8, 'Briefs', 'Grey', 'L', 30, 249.00), -- 7, Calvin Klein
    (8, 'Boxers', 'Black', 'M', 29, 149.00), -- 8, Calvin Klein
    
    -- Shoes
    (3, 'Running shoes', 'White', '42', 15, 1299.00), -- 9, Nike
    (9, 'Basketball shoes', 'Black', '43', 8, 1199.00), -- 10, Puma
    
    -- Jackets
    (5, 'Bomber jacket', 'Blue', 'L', 12, 899.00), -- 11, Adidas
    (6, 'Down jacket', 'Black', 'XL', 6, 1299.00), -- 12, Uniqlo
    
    -- Socks
    (3, 'Ankle socks', 'White', '39-42', 25, 89.00), -- 13, Nike
    (8, 'Knee socks', 'Black', '43-46', 20, 199.00), -- 14, Calvin Klein
    
    -- Sportswear
    (3, 'Zip hoodie', 'Black', 'S', 14, 599.00), -- 15, Nike
    (5, 'Training shorts', 'Grey', 'M', 18, 349.00), -- 16, Adidas
    
    -- Casual 
    (1, 'Sweatpants', 'Grey', 'L', 16, 599.00), -- 17, SweetPants
    (2, 'Flannel shirt', 'Red', 'M', 11, 399.00), -- 18, H&M
    
    -- Accessories
    (10, 'Cap', 'Green', 'M', 20, 399.00), -- 19, Lacoste
    (8, 'Belt', 'Black', '90cm', 15, 599.00); -- 20, Calvin Klein

INSERT INTO product_category(product_id, category_id) VALUES
    (1, 1),  -- Hoodie, Shirts
    (2, 1),  -- T-shirt, Shirts
    (3, 2),  -- Casual pants, Pants
    (4, 2),  -- Chinos, Pants
    (5, 3),  -- Business dress, Dresses
    (6, 3),  -- Summer dress, Dresses
    (7, 4),  -- Briefs, Underwear
    (8, 4),  -- Boxers, Underwear
    (9, 5),  -- Running shoes, Shoes
    (10, 5), -- Basketball shoes, Shoes
    (11, 6), -- Bomber jacket, Jackets
    (12, 6), -- Down jacket, Jackets
    (13, 7), -- Ankle socks, Socks
    (14, 7), -- Knee socks, Socks
    (15, 8), -- Zip hoodie, Sportswear
    (16, 8), -- Training shorts, Sportswear
    (17, 9), -- Sweatpants, Casual
    (18, 9), -- Flannel shirt, Casual
    (19, 10), -- Cap, Accessories
    (20, 10); -- Belt, Accessories
    
    
insert into order_item(order_id, product_id, quantity) values
    -- Stockholm, Total: 2293.00kr
    (1, 3, 1),  -- Name: Anna Svensson, Product: Casual pants, Brand: SweetPants, Color: Black, Size: 38, Quantity: 1, Price: 399.00
    (1, 1, 1),  -- Name: Anna Svensson, Product: Hoodie, Brand: H&M, Color: Grey, Size: L, Quantity: 1, Price: 399.00
    (2, 3, 2),  -- Name: Erik Johannson, Product: Casual pants, Brand: SweetPants, Color: Black, Size: 38, Quantity: 2, Price: 399.00
    (3, 1, 1),  -- Name: Maria Lindqvist, Product: Hoodie, Brand: H&M, Color: Grey, Size: L, Quantity: 1, Price: 399.00
    (4, 5, 1),  -- Name: Anna Svensson, Product: Business dress, Brand: H&M, Color: Navy blue, Size: M, Quantity: 1, Price: 1099.00
    (5, 3, 1),  -- Name: Erik Johannson, Product: Casual pants, Brand: SweetPants, Color: Black, Size: 38, Quantity: 1, Price: 399.00
    (6, 1, 1),  -- Name: Maria Lindqvist, Product: Hoodie, Brand: H&M, Color: Grey, Size: L, Quantity: 1, Price: 399.00

    -- Gothenburg, Total: 3696.00kr
    (7, 9, 1),  -- Name: Johan Karlsson, Product: Running shoes, Brand: Nike, Color: White, Size: 42, Quantity: 1, Price: 1299.00
    (8, 11, 1), -- Name: Emma Andersson, Product: Bomber jacket, Brand: Adidas, Color: Blue, Size: L, Quantity: 1, Price: 899.00
    (9, 4, 1),  -- Name: Lars Petersson, Product: Chinos, Brand: Zara, Color: Blue, Size: 32, Quantity: 1, Price: 499.00
    (10, 9, 1), -- Name: Johan Karlsson, Product: Running shoes, Brand: Nike, Color: White, Size: 42, Quantity: 1, Price: 1299.00
    (11, 11, 1),-- Name: Emma Andersson, Product: Bomber jacket, Brand: Adidas, Color: Blue, Size: L, Quantity: 1, Price: 899.00
    (12, 4, 1), -- Name: Lars Petersson, Product: Chinos, Brand: Zara, Color: Blue, Size: 32, Quantity: 1, Price: 499.00

    -- Malmo, Total: 2196.00kr
    (13, 2, 2),  -- Name: Sofia Nilsson, Product: T-shirt, Brand: Adidas, Color: Black, Size: M, Quantity: 2, Price: 299.00
    (14, 12, 1), -- Name: Magnus Bergström, Product: Down jacket, Brand: Uniqlo, Color: Black, Size: XL, Quantity: 1, Price: 1299.00
    (15, 2, 1),  -- Name: Sofia Nilsson, Product: T-shirt, Brand: Adidas, Color: Black, Size: M, Quantity: 1, Price: 299.00
    (16, 12, 1), -- Name: Magnus Bergström, Product: Down jacket, Brand: Uniqlo, Color: Black, Size: XL, Quantity: 1, Price: 1299.00

    -- Uppsala, Total: 586.00kr
    (17, 13, 1), -- Name: Astrid Gustafsson, Product: Ankle socks, Brand: Nike, Color: White, Size: 39-42, Quantity: 1, Price: 89.00
    (18, 14, 1), -- Name: Oskar Hedberg, Product: Knee socks, Brand: Calvin Klein, Color: Black, Size: 43-46, Quantity: 1, Price: 199.00
    (19, 13, 1), -- Name: Astrid Gustafsson, Product: Ankle socks, Brand: Nike, Color: White, Size: 39-42, Quantity: 1, Price: 89.00
    (20, 8, 2);  -- Name: Oskar Hedberg, Product: Boxers, Brand: Calvin Klein, Color: Black, Size: M, Quantity: 2, Price: 149.00




    
set sql_safe_updates = 0;
