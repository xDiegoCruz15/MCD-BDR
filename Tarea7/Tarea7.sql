/* Revisar códigos zip con longitud diferente a 5 caracteres */

SELECT * FROM customers WHERE LENGTH(customer_zip_code_prefix) != 5;

SELECT * FROM sellers WHERE LENGTH(seller_zip_code_prefix) != 5;

SELECT * FROM geolocation WHERE LENGTH(geolocation_zip_code_prefix) != 5;


/* revisar zip igual a 00000 */

SELECT * FROM customers WHERE customer_zip_code_prefix = '00000';
select * from sellers where seller_zip_code_prefix = '00000';


/* Revisar la fecha de las ordenes */

SELECT * FROM orders 
WHERE 
    (order_purchase_timestamp < '2016-01-01' OR order_purchase_timestamp > '2018-12-31')
    OR
    (order_approved_at < '2016-01-01' OR order_approved_at > '2018-12-31')
    OR
    (order_delivered_carrier_date < '2016-01-01' OR order_delivered_carrier_date > '2018-12-31')
    OR
    (order_delivered_customer_date < '2016-01-01' OR order_delivered_customer_date > '2018-12-31');


/* Revisar inconsistencias en la tabla pagos*/


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




/* remplazar order_approved_at igual a null por order_purchase_timestamp */

UPDATE orders
SET order_approved_at = order_purchase_timestamp
WHERE order_approved_at IS NULL;

/* remplazar order_delivered_carrier_date igual a null por order_approved_at */

UPDATE orders



/* agregar la columna costumer_unique_id a la tabla ordenes*/

ALTER TABLE orders
ADD customer_unique_id VARCHAR(32);

UPDATE orders
JOIN customers ON customers.customer_id = orders.customer_id
set orders.customer_unique_id = customers.customer_unique_id;

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




