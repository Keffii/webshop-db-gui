-- Query 1 
-- Vilka kunder har köpt svarta byxor i storlek 38 av SweetPants
select distinct customer.name  as customer_name
from customer
inner join orders on customer.customer_id = orders.customer_id
inner join order_item on orders.order_id = order_item.order_id
inner join product on order_item.product_id = product.product_id
inner join brand on product.brand_id = brand.brand_id
where brand.brand_name = 'SweetPants'
and product.color = 'Black'
and product.size = '38'
and product.product_name like '%pants%';

-- Query 2 
-- Lista antalet produkter per kategori. Listningen ska innehålla kategori-namn och antalet produkter.
select category.category_name, count(product_category.product_id) as product_amount
from category
left join product_category on category.category_id = product_category.category_id
group by category.category_id, category.category_name
order by product_amount;

-- Query 3 
-- skriv ut en lista på det totala beställningsvärdet per ort där beställningsvärdet är större än 1000kr
-- Ortnamn och värde ska visas. (det måste finnas orter i databasen där det har
-- handlats för mindre än 1000 kr för att visa att frågan är korrekt formulerad)
select customer.city as City, sum(product.stock_price * order_item.quantity) as Total_order_value
from customer
inner join orders on customer.customer_id = orders.customer_id
inner join order_item on orders.order_id = order_item.order_id  
inner join product on order_item.product_id = product.product_id
group by customer.city
having total_order_value > 1000
order by total_order_value desc;

-- Query 3 
-- Confirm that it's working properly
select customer.city as City, sum(product.stock_price * order_item.quantity) as Total_order_value
from customer
inner join orders on customer.customer_id = orders.customer_id
inner join order_item on orders.order_id = order_item.order_id  
inner join product on order_item.product_id = product.product_id
group by customer.city
order by total_order_value desc;

-- Query 4 Skapa en topp-5 lista av de mest sålda produkterna
select 
    product.product_name,
    brand.brand_name,
    sum(order_item.quantity) as top_5
from order_item
inner join orders on order_item.order_id = orders.order_id
inner join customer on orders.customer_id = customer.customer_id
inner join product on order_item.product_id = product.product_id
inner join brand on product.brand_id = brand.brand_id
group by product.product_id, product.product_name, brand.brand_name
order by top_5 desc
limit 5;

-- Query 5 Vilken månad hade du den största försäljningen?
select date_format(orders.order_date, '%Y-%M') as order_month,
    sum(order_item.quantity * product.stock_price) as total_sales
from orders
join order_item on orders.order_id = order_item.order_id
join product on order_item.product_id = product.product_id
group by order_month
order by total_sales desc;
