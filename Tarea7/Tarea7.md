# Tarea 7

## Revision de errores y ajuste de la base de datos
<br>

### Revision de errores

<br>

Revisar códigos zip con longitud diferente a 5 caracteres 


```sql	

SELECT * FROM customers WHERE LENGTH(customer_zip_code_prefix) != 5;

SELECT * FROM sellers WHERE LENGTH(seller_zip_code_prefix) != 5;

SELECT * FROM geolocation WHERE LENGTH(geolocation_zip_code_prefix) != 5;


```

Revisar zip igual a 00000 

```sql
SELECT * FROM customers WHERE customer_zip_code_prefix = '00000';
select * from sellers where seller_zip_code_prefix = '00000';
```

Revisar que las ordenes se encuentren dentro del rango de historia de la empresa (2016-2018)

```sql	
SELECT * FROM orders 
WHERE 
    (order_purchase_timestamp < '2016-01-01' OR order_purchase_timestamp > '2018-12-31')
    OR
    (order_approved_at < '2016-01-01' OR order_approved_at > '2018-12-31')
    OR
    (order_delivered_carrier_date < '2016-01-01' OR order_delivered_carrier_date > '2018-12-31')
    OR
    (order_delivered_customer_date < '2016-01-01' OR order_delivered_customer_date > '2018-12-31');
```

Revision de errores en la tabla de pagos

```sql
SELECT * FROM order_payments
WHERE 
    (payment_sequential < 1 OR payment_sequential > 30)
    OR
    (payment_installments < 1 OR payment_installments > 24)
    OR
    (payment_value < 0 OR payment_value > 99999)
    OR
    (payment_type NOT IN ('boleto', 'voucher', 'credit_card', 'debit_card', 'not_defined'))
    OR
    (payment_value IS NULL)
    OR
    (payment_sequential IS NULL)
    OR
    (payment_type IS NULL); 

/* remplazar los errores de payment_installments igual a 0 por 1 */

UPDATE order_payments
SET payment_installments = 1
WHERE payment_installments = 0;
```
<br>



### Ajuste de la base de datos

<br>


Agregar la columna costumer_unique_id a la tabla ordenes

```sql
ALTER TABLE orders
ADD customer_unique_id VARCHAR(32);

UPDATE orders
JOIN customers ON customers.customer_id = orders.customer_id
set orders.customer_unique_id = customers.customer_unique_id;
```


Agregar columna costumer_unique_id y costumer_id a todas las tablas 
relacionadas a las ordenes

```sql

/* agregar la columna customer_id y customer_unique_id a la tabla order_items, order_payments y orders_review*/

ALTER TABLE order_items
ADD customer_id VARCHAR(32),
ADD customer_unique_id VARCHAR(32);

ALTER TABLE order_payments
ADD customer_id VARCHAR(32),
ADD customer_unique_id VARCHAR(32);

ALTER TABLE order_reviews
ADD customer_id VARCHAR(32),
ADD customer_unique_id VARCHAR(32);



UPDATE order_items
JOIN orders ON orders.order_id = order_items.order_id
JOIN customers ON customers.customer_id = orders.customer_id
SET 
order_items.customer_id = customers.customer_id,
order_items.customer_unique_id = customers.customer_unique_id;


UPDATE order_payments
JOIN orders ON orders.order_id = order_payments.order_id
JOIN customers ON customers.customer_id = orders.customer_id
SET
order_payments.customer_id = customers.customer_id,
order_payments.customer_unique_id = customers.customer_unique_id;

UPDATE order_reviews
JOIN orders ON orders.order_id = order_reviews.order_id
JOIN customers ON customers.customer_id = orders.customer_id
SET
order_reviews.customer_id = customers.customer_id,
order_reviews.customer_unique_id = customers.customer_unique_id;


```

## Hallazgos y dificultades

1. Al utilizar un join sobre una tabla se puede crear otro join sobre la misma tabla haciendo uso de las columnas "agregadas" con el primer join, dentro del mismo query. Pensaba que era necesario hacerlo de manera separada o con un subquery.

2. Hay errores que se identificaron pero no encontró una manera lógica de solucionarlos, lo que fue el caso de  los clientes y vendedores con zip code igual a 00000. En este caso se decidió dejarlos como estaban, ya que no hay manera de encontrar el zip code correcto.


3. AL buscar errores en la tabla de pagos, se encontró que había 2 pagos con un periodo de pago igual a 0 lo cual no tiene sentido. Se decidió modificarlos a un periodo único 1.

