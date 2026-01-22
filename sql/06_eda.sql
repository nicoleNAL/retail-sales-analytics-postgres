-- Exploratory Data Analysis (EDA)
-- This file contains descriptive analysis queries used to understand dataset scale, revenue trends, product performance, and customer behavior.

-- EDA 1a: Row counts per table
SELECT 'orders' AS table_name, count(*) AS rows FROM clean.orders
UNION ALL
SELECT 'customers', count(*) FROM public.customers
UNION ALL
SELECT 'products', count(*) FROM public.products
UNION ALL
SELECT 'sales', count(*) FROM public.sales;

-- EDA 1b: Date coverage of orders
SELECT
  MIN(order_date) AS first_order_date,
  MAX(order_date) AS last_order_date,
  COUNT(distinct order_date) AS active_days
FROM clean.orders;

-- EDA 2: Overall dataset scale and revenue overview
SELECT
	COUNT (DISTINCT order_id) AS total_orders,
	COUNT (*) AS total_line_items,
	SUM (quantity) AS total_units_sold,
	SUM(total_price) AS total_rev,
	AVG(total_price) AS avg_line_item_rev
FROM sales;

-- EDA 3: Average delivery time per month
SELECT
	TO_CHAR(order_date::date, 'YYYY-MM') AS order_month,
	ROUND(AVG(delivery_date::date - order_date::date),2) AS avg_del_days
FROM orders
GROUP BY 1
ORDER BY 1;

-- EDA 4: Revenue Over Time
SELECT *
FROM sales;
SELECT *
FROM clean.orders;

SELECT o.order_date, SUM(s.total_price) AS daily_rev
FROM sales s
JOIN clean.orders o
	ON s.order_id = o.order_id
GROUP BY o.order_date
ORDER BY o.order_date;

-- EDA 4b: Monthly revenue trend
SELECT
  date_trunc('month', o.order_date) AS month,
  SUM(s.total_price) AS monthly_revenue
FROM sales s
JOIN clean.orders o
  ON s.order_id = o.order_id
GROUP BY month
ORDER BY month;

-- EDA 5a: Top 10 Products by Revenue
SELECT p.product_name, SUM(s.quantity) AS units_sold, SUM(s.total_price) AS total_rev
FROM sales s
JOIN products p
	ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_rev DESC
LIMIT 10; 

-- EDA 5b: Revenue and units sold by product category
SELECT p.product_type, SUM(s.quantity) AS units_sold, SUM(s.total_price) AS total_rev
FROM sales s
JOIN products p
	ON s.product_id = p.product_id
GROUP BY p.product_type
ORDER BY total_rev DESC; 

-- EDA 6: Top customers by revenue
SELECT * FROM customers;
SELECT * FROM sales;
SELECT * FROM clean.orders;

SELECT  c.customer_name, o.customer_id, SUM(total_price) AS total_rev, COUNT(DISTINCT o.order_id) AS total_orders
FROM sales s
	JOIN clean.orders o 
		ON  s.order_id = o.order_id
	JOIN customers c 
		ON  c.customer_id = o.customer_id
	GROUP BY o.customer_id, c.customer_name
	ORDER BY total_rev DESC
	LIMIT 20;



