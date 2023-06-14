-- Active: 1684464908367@@127.0.0.1@3306@e-commer


-- Cuenta la cantidad de productos que se han vendido por lo menos 100 unidades (conteo)
SELECT COUNT(*) AS numero_filas
FROM (
  SELECT product_id, COUNT(product_id) AS repeticiones
  FROM order_items
  GROUP BY product_id
  HAVING COUNT(product_id) >= 100
)AS subquery;



-- Mayor numero de ordenes efectuadas por un solo cliente


SELECT MAX(max_orders) AS max_value
FROM (
  SELECT COUNT(customer_unique_id) AS max_orders
  FROM orders
  JOIN customers ON customers.customer_id = orders.customer_id
  GROUP BY customer_unique_id
) AS subquery;


-- Encuentra el monto mas bajo pagado por un producto (mínimo)
SELECT MIN(price) AS precio_minimo
FROM order_items;

-- quantiles del numero del valor de los pagos

SET SESSION group_concat_max_len = @@max_allowed_packet;
SET @temp_rows = (SELECT GROUP_CONCAT(payment_value ORDER BY payment_value ASC SEPARATOR ',') FROM order_payments WHERE payment_value IS NOT NULL);
SET @temp_count = (SELECT COUNT(payment_value) FROM order_payments WHERE payment_value IS NOT NULL);

SELECT
  SUBSTRING_INDEX(SUBSTRING_INDEX(@temp_rows, ',', ROUND(@temp_count * 0.25 + 1)), ',', -1) AS q1,
  SUBSTRING_INDEX(SUBSTRING_INDEX(@temp_rows, ',', ROUND(@temp_count * 0.5 + 1)), ',', -1) AS mediana,
  SUBSTRING_INDEX(SUBSTRING_INDEX(@temp_rows, ',', ROUND(@temp_count * 0.75 + 1)), ',', -1) AS q3;

   
SET @temp_count := NULL;
SET @temp_rows := NULL;




-- Encuentra el producto mas vendido (moda)
SELECT product_id, COUNT(product_id) AS repeticiones
FROM order_items
GROUP BY product_id
HAVING COUNT(product_id) = (
    SELECT COUNT(product_id) AS repeticiones
    FROM order_items
    GROUP BY product_id
    ORDER BY repeticiones DESC
    LIMIT 1
);

