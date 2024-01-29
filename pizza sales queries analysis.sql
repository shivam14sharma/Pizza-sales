select * from food.pizza_sales;
use food;
#0. Basic exploration (Nulls, counting, distinct values)
    
SELECT * FROM pizza_sales WHERE pizza_id is NULL OR order_id is NULL or pizza_name_id is NULL or quantity is NULL OR order_date is NULL or order_time is NULL or unit_price IS NULL or total_price IS NULL or pizza_size is NULL or
  pizza_category IS NULL or pizza_ingredients IS NULL or pizza_name IS NULL;

SELECT COUNT(DISTINCT order_id ) FROM pizza_sales;
SELECT DISTINCT order_id FROM pizza_sales;
SELECT * FROM pizza_sales WHERE pizza_name ='""'; 

SELECT COUNT(DISTINCT pizza_category) FROM pizza_sales;
SELECT COUNT(DISTINCT pizza_size) FROM pizza_sales;
SELECT COUNT(DISTINCT pizza_id) FROM pizza_sales;
SELECT COUNT(DISTINCT pizza_ingredients) FROM pizza_sales;
#We need to analyze key indicators for our pizza sales data to gain insights into our business performance. Specifically, we want to calculate the following metrics:

#1. Total Revenue.
    
SELECT
    SUM(total_price) AS Total_Revenue
FROM 
    pizza_sales;

#2. Average Order Value
SELECT
    SUM(total_price) / COUNT(DISTINCT order_id)  AS Average_Order_Value 
FROM pizza_sales;

#3. Total Pizzas Sold
SELECT
    SUM(quantity) AS Total_Pizza_Sold
FROM
    pizza_sales;

#4. Total Orders
SELECT
    COUNT(distinct order_id) AS Total_Orders
FROM pizza_sales;

#5. Average Pizzas Per Order
SELECT 
    CAST(SUM(quantity) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Avg_Pizzas_per_order
FROM 
    pizza_sales;

#We would like to visualize various aspects of our pizza sales data to gain insights and understand key trends. We have identified the following requirements for creating charts:
    
#6. Hourly Trend for Total Pizzas Sold: This chart will help us identify any patterns or fluctuations in order volumes on a hourly basis.
SELECT
    HOUR(order_time) AS order_hour,
    SUM(quantity) AS Total_pizzas_sold
FROM
    pizza_sales
GROUP BY
    HOUR(order_time)
ORDER BY
	HOUR(order_time);
#7. Weekly Trend for Total Orders: This chart will allow us to identify peak weeks or periods of high order activity.
SELECT 
    WEEK(order_date, 3) AS week_number,
    YEAR(order_date) AS Order_year,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM 
    pizza_sales
GROUP BY 
    WEEK(order_date, 3), YEAR(order_date)
ORDER BY 
    week_number, Order_year;

#8. Percentage of Sales by Pizza Category: This chart will provide insights into the popularity of various pizza categories and their contribution to overall sales.
SELECT
	pizza_category,
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(SUM(total_price) * 100 / (SELECT sum(total_price) from pizza_sales) AS DECIMAL(10,2))  AS Sales_by_PC
FROM 
    pizza_sales
GROUP BY
    pizza_category;
#9. Percentage of Sales by Pizza Size: This chart will help us understand customer preferences for pizza sizes and their impact on sales.
SELECT
	pizza_size,
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(SUM(total_price) * 100 / (SELECT sum(total_price) from pizza_sales) AS DECIMAL(10,2)) AS Sales_by_PS
FROM 
    pizza_sales
GROUP BY 
    pizza_size
ORDER BY 
    Sales_by_PS DESC;
#10. Total Pizzas Sold by Pizza Category: This chart will allow us to compare the sales performance of different pizza categories.
SELECT 
	pizza_category,
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
FROM 
	pizza_sales
GROUP BY
    pizza_category;
#11. Top 5 Best Sellers by Revenue, Total Quantity and Total Orders: This chart will help us identify the most popular pizza options.
#TOP 5 Best sellers by Total Orders  

SELECT
    pizza_name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM 
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
    Total_Orders DESC
LIMIT 5;

#TOP 5 Best sellers by Total Quantity  

SELECT
    pizza_name,
    SUM(quantity) AS Total_Quantity
FROM 
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
     Total_Quantity DESC
LIMIT 5;

#TOP 5 Best sellers by Total Revenue  

SELECT
    pizza_name,
    SUM(total_price) AS Total_Revenue
FROM 
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
     Total_Revenue DESC
LIMIT 5;
#12.  Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders:  This chart will help us identify the least popular pizza options.
#Bottom 5 Pizzas Sales by Total Orders

SELECT 
    pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
    Total_Orders ASC
LIMIT 5;

#Bottom 5 Pizzas Sales by Total Quantity  

SELECT
    pizza_name,
    SUM(quantity) AS Total_Quantity
FROM 
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
     Total_Quantity ASC
LIMIT 5;

#Bottom 5 Pizzas Sales  by Total Revenue  

SELECT
    pizza_name,
    SUM(total_price) AS Total_Revenue
FROM 
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
     Total_Revenue ASC
LIMIT 5;