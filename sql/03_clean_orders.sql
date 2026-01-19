-- Create clean.orders with proper date types

CREATE schema if NOT EXISTS clean;

CREATE TABLE clean.orders AS
SELECT
  order_id,
  customer_id,
  payment,
  to_date(order_date, 'YYYY-MM-DD') as order_date,
  to_date(delivery_date, 'YYYY-MM-DD') as delivery_date
FROM public.orders;
