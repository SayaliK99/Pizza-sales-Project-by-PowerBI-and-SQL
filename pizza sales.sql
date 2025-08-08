select * from pizza_sales

--KPIS

---1. Total revenue
select Round(sum(total_price), 2) AS Revenue
from pizza_sales

---2.Average order value
select sum(total_price)/ count(distinct order_id) as Average_order_Value
from pizza_sales

---3.Total pizza sold
select sum(quantity) As Total_pizza_sales
from pizza_sales

---4.Total Orders
select count(distinct order_id) AS Total_orders
from pizza_sales

---5.Average pizzas per Orders
select CAST(cast(sum(quantity) AS decimal (10,2))/ 
cast(count(distinct order_id) AS DECIMAL (10,2)) AS Decimal (10,2)) AS Average_pizzas_per_orders
from pizza_sales
--------------------------------------------------------------------------------

---1. Daily trends for our daily orders

select DateName(DW,  order_date) As order_day, count(distinct order_id) AS Total_orders                          ---DW = day of week
from pizza_sales
group by DateName(DW,  order_date)

---2. Montly trend forTotal orders

select datename(MONTH, order_date) AS Month_name, count(distinct order_id) as Total_orders
from pizza_sales
group by datename(MONTH, order_date)
order by Total_orders desc

---3.percentage of sales by pizza category
select pizza_category, sum(total_price) as Total_sales, sum(total_price)*100/ (select sum(total_price) from pizza_sales where month(order_date) = 1) AS Per_Sales_category
from pizza_sales
where month(order_date) = 1
Group by pizza_category


----4. pecentage of sales by pizza_size

select pizza_size, cast(sum(total_price) AS decimal (10,2)) as Total_sales, cast(sum(total_price)*100/
(select sum(total_price) from pizza_sales where Datepart(quarter, order_date)=1) AS Decimal (10,2)) AS Per_Sales_size
from pizza_sales
where Datepart(quarter, order_date)=1
Group by pizza_size

----5. top 5 best sellers by revenue, 
select top 5 pizza_name, sum(total_price) as Total_revenue from pizza_sales
group by pizza_name
order by Total_revenue desc

---6. bottom 5 sellers by revenue
select top 5 pizza_name, sum(total_price) as Total_revenue from pizza_sales
group by pizza_name
order by Total_revenue Asc

---7. top 5 sellers by quantity
select top 5 pizza_name, sum(quantity) as Total_Quantity from pizza_sales
group by pizza_name
order by Total_Quantity desc

---8. bottom 5 sellers by quantity 
select top 5 pizza_name, sum(quantity) as Total_Quantity from pizza_sales
group by pizza_name
order by Total_Quantity Asc

--9. top 5 sellers by orders
select top 5 pizza_name, count(distinct order_id) as Total_orders from pizza_sales
group by pizza_name
order by Total_orders desc

---10 bottom 5 sellers by orders
select top 5 pizza_name, count(distinct order_id) as Total_orders from pizza_sales
group by pizza_name
order by Total_orders Asc


