# Tarea 8

En este reporte, se describirán y explicarán tres views y un trigger implementados en la base de datos. Cada view y el trigger desempeñan una función específica y proporcionan información valiosa sobre los clientes, los vendedores y los productos. A continuación, se detallará la utilidad de cada uno:

## View: customer_undelivered_orders

<br>

```sql
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
```
Este view muestra los datos de los clientes que tienen un pedido pendiente de entrega. Los clientes se seleccionan de la tabla "customers" y se unen con la tabla "orders" utilizando el identificador del cliente. Los pedidos pendientes se filtran mediante la condición "order_status" que incluye los valores 'invoiced', 'shipped', 'created', 'approved' y 'processing'. La finalidad de este view es proporcionar una lista de clientes con pedidos pendientes para su posterior seguimiento y gestión.

<br>

## View: seller_analysis

```sql
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
```
Este view proporciona un análisis detallado de los productos vendidos por cada vendedor. El view muestra el identificador del vendedor, la ciudad del vendedor, el número total de pedidos realizados por ese vendedor y el total de ventas generadas por esos pedidos. Esta información es útil para analizar el rendimiento de los vendedores y determinar su contribución al negocio.

<br>

## View: customer_analysis

```sql
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

```
Este view ofrece un análisis detallado de las órdenes de los clientes. Incluye todos los clientes, incluso aquellos que no tienen ninguna orden. El view muestra el identificador único del cliente, la ciudad del cliente, el número total de órdenes realizadas por ese cliente, el promedio de la puntuación de revisión de esas órdenes y el total gastado por el cliente en esas órdenes. Esta vista proporciona una visión general de los hábitos de compra de los clientes y su satisfacción con los productos adquiridos.

<br>

## Trigger: update_total_sales

<br>

```sql
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



```

Este trigger se dispara después de insertar un nuevo registro en la tabla "order_items". Su propósito es actualizar la columna "total_sales" en la tabla "products" con el monto total vendido de un producto. El trigger verifica si el precio del nuevo artículo es mayor que cero o no es nulo y, en ese caso, actualiza la columna "total_sales" del producto correspondiente sumando el precio del nuevo artículo vendido. Este trigger garantiza que la columna "total_sales" se mantenga actualizada cada vez que se realice una nueva venta de un producto.



