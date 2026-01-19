-- Analytical query: daily revenue

SELECT
  order_date,
  sum(payment) AS daily_revenue
FROM clean.orders
GROUP BY order_date
ORDER BY order_date;
