SELECT * FROM pizza_sales;

-- 1. Total revenue 
SELECT round(SUM(TOTAL_PRICE),2) AS TOTAL_Revenue FROM pizza_sales;

-- 2. average order values
select round(sum(total_price)/ count(distinct( order_id)),2) as Avg_order_id from Pizza_sales;

-- 3. Total pizza sold
select sum(quantity) as Pizza_sold from pizza_sales;

-- 4. Total order
select count(distinct(order_id)) as Total_order from pizza_sales;

-- 5. Average Pizza Per Order
select round(sum(quantity)/ count(distinct(order_id)),2) as Avg_pizza_sale from pizza_sales;
-- (thats are our KPI's)

UPDATE pizza_sales
SET order_date= CASE
       
	    WHEN order_date LIKE '%-%' THEN date_format(str_to_date(order_date,'%d-%m-%Y'),'%Y-%m-%d')
        ELSE null
        END;
 ALTER TABLE pizza_sales
modify COLUMN order_date DATE ;
describe pizza_sales;

SELECT * FROM pizza_sales;
-- 6. Daily Trends for toatl order
select distinct(dayname(order_date)) as Day_name,count(distinct(order_id)) as Total_orders 
 from pizza_sales 
 group by dayname(order_date) ;

-- 7. Monthly trend for total orders
select distinct(monthname(order_date)) as Month_name,count(distinct(order_id)) as Total_orders 
 from pizza_sales 
 group by monthname(order_date)
 order by  Total_orders desc;

-- 8.  % of sales by category
select pizza_category,ROUND(SUM(TOTAL_PRICE),2) AS Total_Sales,round(sum(total_price)* 100 / (select sum(total_price) from pizza_sales
 WHERE month(order_date) =1),2) as PCT
from pizza_sales WHERE month(order_date) =1 group by pizza_category ;

-- 9. percentage of sales by size
select pizza_size,ROUND(SUM(TOTAL_PRICE),2) AS Total_Sales,round(sum(total_price)* 100 / (select sum(total_price) from pizza_sales
 WHERE month(order_date) =1),2) as PCT 
from pizza_sales WHERE month(order_date) =1 group by pizza_size ;
select * from pizza_sales; 
-- 10. total pizza sales by size
select distinct(Pizza_category), round(sum(total_price),2) as Total_sales from pizza_sales
group by pizza_category;

-- 11.(a) top 5 best seller by revenue, total quantity and total_order
 select pizza_name , sum(total_price) as Total_Revenue 
 from pizza_sales group by pizza_name order by Total_Revenue  desc
 limit 5;
 -- (b)
  select pizza_name , sum(quantity) as Total_Quantity
 from pizza_sales group by pizza_name order by Total_Quantity  desc
 limit 5;
 -- (c)
   select pizza_name , count(order_id) as Total_Order
 from pizza_sales group by pizza_name order by Total_Order  desc
 limit 5;
 
  
 -- 12. 
 






























