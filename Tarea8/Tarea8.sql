

-- Crear un view con los datos de los clientes que tienen un pedido pendiente de entrega.


CREATE OR REPLACE VIEW customer_undelivered_orders AS
SELECT customers.customer_id, customers.customer_unique_id, customers.customer_zip_code_prefix, customers.customer_city, customers.customer_state, 
orders.order_status, orders.order_id, orders.order_purchase_timestamp
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_status = 'invoiced'
or orders.order_status = 'shipped'
or orders.order_status = 'created'
or orders.order_status = 'approved'
or orders.order_status = 'processing';




-- Crea un view con el detalle de los productos vendidos por cada vendedor, solo se incluyen los vendodres con datos


CREATE OR REPLACE VIEW seller_analysis AS
SELECT 
  sellers.seller_id, 
  sellers.seller_city, 
  COUNT(orders.order_id) AS total_orders,
  SUM(order_items.price * order_items.order_item_id) AS total_sales
FROM 
  sellers
RIGHT JOIN 
  order_items ON sellers.seller_id = order_items.seller_id
RIGHT JOIN 
  orders ON order_items.order_id = orders.order_id
WHERE 
  sellers.seller_id IS NOT NULL
GROUP BY 
  sellers.seller_id, 
  sellers.seller_city;


-- Crea un view con el detalle de las ordenes de los clientes, se incluye la totalidad de clintes aunque no tengan ordenes
CREATE OR REPLACE VIEW customer_analysis AS
SELECT 
  customers.customer_unique_id, 
  customers.customer_city, 
  COUNT(orders.order_id) AS total_orders,
  AVG(order_reviews.review_score) AS average_review_score,
  SUM(order_items.price * order_items.order_item_id) AS total_spent
FROM 
  customers
LEFT JOIN 
  orders ON customers.customer_id = orders.customer_id
LEFT JOIN 
  order_reviews ON orders.order_id = order_reviews.order_id
LEFT JOIN 
  order_items ON orders.order_id = order_items.order_id
GROUP BY 
  customers.customer_unique_id, 
  customers.customer_city;



-- Actualizamos la tabla productos, con el monto total que a vendido un producto, y generamos un trigger, en caso que se genere una nueva venta actualiza el VALIDATE_PASSWORD_STRENGTH

ALTER TABLE products
ADD COLUMN total_sales DECIMAL(10,2);



DROP TRIGGER IF EXISTS update_total_sales;

CREATE  TRIGGER update_total_sales
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
  IF NEW.price > 0 OR NEW.price IS NOT NULL THEN
    UPDATE products
    SET total_sales = total_sales + NEW.price
    WHERE product_id = NEW.product_id;
  END IF;
END;


