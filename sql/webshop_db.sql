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
    index ix_order_id(order_id),
    index ix_product_id(product_id)
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
('Johan Karlsson', 'johan.karlsson@email.se', 'Göteborg'),
('Emma Andersson', 'emma.andersson@email.se', 'Göteborg'),
('Lars Petersson', 'lars.petersson@email.se', 'Göteborg'),
('Sofia Nilsson', 'sofia.nilsson@email.se', 'Malmö'),
('Magnus Bergström', 'magnus.bergstrom@email.se', 'Malmö'),
('Astrid Gustafsson', 'astrid.gustafsson@email.se', 'Uppsala'),
('Oskar Hedberg', 'oskar.hedberg@email.se', 'Uppsala');

insert into category(category_name) values
('Tröjor'), -- 1
('Byxor'), -- 2
('Klänningar'), -- 3
('Underkläder'), -- 4
('Skor'), -- 5
('Jackor'), -- 6 
('Strumpor'), -- 7
('Träningskläder'), -- 8
('Casual'), -- 9
('Accessoarer'); -- 10

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
(1, '2025-01-01 10:30:00'),
(2, '2025-02-01 10:30:00'),
(3, '2025-03-01 10:30:00'),
(4, '2025-04-01 10:30:00'),
(5, '2025-05-01 10:30:00'),
(6, '2025-06-01 10:30:00'),
(7, '2025-07-01 10:30:00'),
(8, '2025-08-01 10:30:00'),
(9, '2025-09-01 10:30:00'),
(10, '2025-10-01 10:30:00');

INSERT INTO product(brand_id, product_name, color, size, stock_quantity, stock_price) VALUES
    -- Tröjor
    (2, 'Hoodie', 'Grå', 'L', 15, 399.00), -- 1, H&M
    (5, 'T-shirt', 'Svart', 'M', 12, 299.00), -- 2, Adidas
    
    -- Byxor
    (1, 'Casual byxor', 'Svart', '38', 10, 399.00), -- 3, SweetPants
    (4, 'Chinos', 'Blå', '32', 20, 499.00), -- 4, Zara
    
    -- Klänningar
    (2, 'Affärsklänning', 'Marinblå', 'M', 7, 1099.00), -- 5, H&M
    (6, 'Sommarklänning', 'Gul', 'L', 9, 599.00), -- 6, Uniqlo
    
    -- Underkläder
    (8, 'Kalsonger', 'Grå', 'L', 30, 249.00), -- 7, Calvin Klein
    (8, 'Boxershorts', 'Svart', 'M', 29, 149.00), -- 8, Calvin Klein
    
    -- Skor
    (3, 'Löparskor', 'Vit', '42', 15, 1299.00), -- 9, Nike
    (9, 'Basketskor', 'Svart', '43', 8, 1199.00), -- 10, Puma
    
    -- Jackor
    (5, 'Bomberjacka', 'Blå', 'L', 12, 899.00), -- 11, Adidas
    (6, 'Dunjacka', 'Svart', 'XL', 6, 1299.00), -- 12, Uniqlo
    
    -- Strumpor
    (3, 'Ankelstrumpor', 'Vit', '39-42', 25, 89.00), -- 13, Nike
    (8, 'Knästrumpor', 'Svart', '43-46', 20, 199.00), -- 14, Calvin Klein
    
    -- Träningskläder
    (3, 'Zip-hoodie', 'Svart', 'S', 14, 599.00), -- 15, Nike
    (5, 'Träningsshorts', 'Grå', 'M', 18, 349.00), -- 16, Adidas
    
    -- Casual 
    (1, 'Sweatpants', 'Grå', 'L', 16, 599.00), -- 17, SweetPants
    (2, 'Flanellskjorta', 'Röd', 'M', 11, 399.00), -- 18, H&M
    
    -- Accessoarer
    (10, 'Keps', 'Grön', 'M', 20, 399.00), -- 19, Lacoste
    (8, 'Bälte', 'Svart', '90cm', 15, 599.00); -- 20, Calvin Klein

INSERT INTO product_category(product_id, category_id) VALUES
    (1, 1),  -- Hoodie, Tröjor
    (2, 1),  -- T-shirt,Tröjor
    (3, 2),  -- Casual byxor, Byxor
    (4, 2),  -- Chinos, Byxor
    (5, 3),  -- Affärsklänning, Klänningar
    (6, 3),  -- Sommarklänning, Klänningar
    (7, 4),  -- Kalsonger, Underkläder
    (8, 4),  -- Boxershorts, Underkläder
    (9, 5),  -- Löparskor, Skor
    (10, 5), -- Basketskor, Skor
    (11, 6), -- Bomberjacka, Jackor
    (12, 6), -- Dunjacka, Jackor
    (13, 7), -- Ankelsockor,Strumpor
    (14, 7), -- Businesstrumpor, Strumpor
    (15, 8), -- Yogatights, Träningskläder
    (16, 8), -- Träningsshorts, Träningskläder
    (17, 9), -- Sweatpants, Casual
    (18, 9), -- Flanellskjorta, Casual
    (19, 10), -- Keps, Accessoarer
    (20, 10); -- Bälte, Accessoarer
    
    
insert into order_item(order_id, product_id, quantity) values
    -- Stockholm, Total: 1197kr
	(1, 3, 1), -- Name: Anna Svensson, Product: Casual byxor, Brand: SweetPants, Color: Svart, Size: 38, Quantity: 1, Price: 399
    (2, 3, 1), -- Name: Erik Johannson, Product: Casual byxor, Brand: SweetPants, Color: Svart, Size: 38, Quantity: 1, Price: 399
    (3, 1, 1), -- Name: Maria Lindqvist, Product: Hoodie, Brand: H&M, Color: Grå, Size: L, Quantity: 1, Price: 399

    -- Göteborg, Total: 2697
    (4, 9, 1), -- Name: Johan Karlsson, Product: Löparskor, Brand: Nike, Color: Vit, Size: 42, Quantity: 1, Price: 1299
    (5, 11, 1), -- Name: Emma Andersson, Product: Bomberjacka, Brand: Adidas, Color: Blå, Size: L, Quantity: 1, Price: 899
    (6, 4, 1), -- Name: Lars Petersson, Product: Chinos, Brand: Zara, Color: Blå, Size: 32, Quantity: 1, Price: 499

    -- Malmö, Total: 1598
    (7, 2, 1), -- Name: Sofia Nilsson, Product: T-shirt, Brand: Adidas, Color: Svart, Size: M, Quantity: 1, Price: 299
    (8, 12, 1), -- Name: Magnus Bergström, Product: Dunjacka, Brand: Uniqlo, Color: Svart, Size: XL, Quantity: 1, Price: 1299

    -- Uppsala, Total: 288
    (9, 13, 1), -- Name: Astrid Gustafsson, Product: Ankelstrumpor, Brand: Nike, Color: Vit, Size: 39-42, Quantity: 1, Price: 89
    (10, 14, 1); -- Name: Oskar Hedberg, Product: Knästrumpor, Brand: Calvin Klein, Color: Svart, Size: 43-46, Quantity: 1, Price: 199

    
set sql_safe_updates = 0;
