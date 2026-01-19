-- Create clean.products table with standardized structure

CREATE TABLE clean.products AS
SELECT
  product_id,
  product_type,
  product_name,
  size,
  colour,
  price,
  quantity,
  description
FROM public.products;
