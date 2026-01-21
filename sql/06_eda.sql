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

-- EDA 3: Order-Level Metrics (AOV, Items per order)
SELECT
	COUNT (DISTINCT order_id) AS total_orders,
	ROUND(SUM (total_price) * 1.0/ COUNT (DISTINCT order_id),2) AS avg_order_value,
	ROUND(SUM (quantity) * 1.0/COUNT (DISTINCT order_id),2) AS avg_items_per_order
FROM sales;

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

-- EDA 5a: Revenue and units sold by product category
SELECT p.product_name, SUM(s.quantity) AS units_sold, SUM(s.total_price) AS total_rev
FROM sales s
JOIN products p
	ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_rev DESC;

-- EDA 5b: Top products by units sold
SELECT p.product_name, SUM(s.quantity) AS units_sold, SUM(s.total_price) AS total_rev
FROM sales s
JOIN products p
	ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 10; 

-- EDA 5c: Revenue and units sold by product category
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

-- EDA 7: Order composition
SELECT
  o.order_id,
  o.order_date,
  COUNT(DISTINCT s.product_id) AS distinct_products,
  SUM(s.quantity) AS total_items,
  SUM(s.total_price) AS order_revenue
FROM clean.orders o
JOIN public.sales s
  ON o.order_id = s.order_id
GROUP BY o.order_id, o.order_date
ORDER BY order_revenue DESC;

