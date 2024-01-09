
--KPI Generation
Select SUM(total_price) As Total_Revenue
From pizza_sales

Select SUM(total_price) / count(distinct(order_id)) As Average_Order_Value
From pizza_sales

Select SUM(quantity) As Total_Pizza_Sold
From pizza_sales

Select count(distinct(order_id)) As Total_Orders
From pizza_sales

-- The fuction is used to convert an interger to a float
Select cast(cast(sum(quantity) AS Decimal(10,2))/cast(count(distinct order_id) AS Decimal(10,2)) as decimal (10,2)) AS Avg_Pizza_per_Order
From pizza_sales

Select DATENAME(DW,order_date) as Order_day, Count(distinct order_id) As Total_Orders
from pizza_sales
Group By DATENAME(DW,order_date)

Select DATENAME(Month, order_date) as Order_month, Count(distinct order_id) As Total_Orders
From pizza_sales
group by DATENAME(Month, order_date)
order by Total_Orders Desc

--the where clause will be used to filter the sales with a specify month and do not forget to put the where clause in the sunquery as well
Select pizza_category, sum(total_price) as Total_sales , sum(total_price)*100 / (select sum(total_price) from pizza_sales) as Total_sales_Percent
from pizza_sales
--where MONTH(order_date)=1
group by pizza_category

Select pizza_size, CAST(sum(total_price) AS decimal (10,2)) as Total_sales, CAST(sum(total_price)*100/(select sum(total_price) from pizza_sales) AS DECIMAL (10,2)) as Total_sales_percentage
from pizza_sales
group by pizza_size
Order by Total_sales_percentage DESC

--If l wanted the results based on a specific quarter
Select pizza_size, CAST(sum(total_price) AS decimal (10,2)) as Total_sales, CAST(sum(total_price)*100/(select sum(total_price) from pizza_sales where DATEPART(quarter, order_date) =1) AS DECIMAL (10,2)) as Total_sales_percentage
from pizza_sales
where DATEPART(quarter, order_date) =1
group by pizza_size
Order by Total_sales_percentage DESC

--BEST SELLERS

--1) By Revenue
Select TOP 5 pizza_name, sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue DESC

--2) By Total Quantity
Select TOP 5 pizza_name, sum(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity DESC

--3) By Total Orders
Select TOP 5 pizza_name, sum(order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders DESC

--BOTTOM SELLERS

--1) By Revenue
Select TOP 5 pizza_name, sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue ASC

--2) By Total Quantity
Select TOP 5 pizza_name, sum(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity ASC

--3) By Total Orders
Select TOP 5 pizza_name, sum(order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders ASC